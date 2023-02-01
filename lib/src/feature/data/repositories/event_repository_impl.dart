import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/data/id_generator.dart';
import 'package:event_sync/src/core/error/exception.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/core/time/time_info.dart';
import 'package:event_sync/src/event_params.dart';
import 'package:event_sync/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sync/src/feature/data/local/models/event_model.dart';
import 'package:event_sync/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sync/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sync/src/feature/domain/entities/event_info.dart';
import 'package:event_sync/src/feature/domain/entities/event_stub.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  final EventLocalDataSource localDataSource;
  final EventRemoteDataSource remoteDataSource;
  final IdGenerator idGenerator;
  final TimeInfo timeInfo;

  EventRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.idGenerator,
    required this.timeInfo,
  });

  @override
  Future<Either<Failure, void>> fetch(String host, String authToken) async {
    List<EventModel> localEvents;
    try {
      localEvents = await localDataSource.getAllEvents();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }

    // TRICKY: This will increase performance when there are many events.
    // Reducing an O(n^2) operation to an almost O(n*2) operation.
    // This will miss events that have the same creation time. See below for the solution.
    DateTime lastEventSyncTime = DateTime.utc(0);
    for (var e in localEvents) {
      DateTime? remoteDate = e.remoteCreatedAt;
      // Identify the most recently synced remote event.
      if (e.synced &&
          remoteDate != null &&
          remoteDate.isAfter(lastEventSyncTime)) {
        lastEventSyncTime = remoteDate;
      }
    }

    // TRICKY: it's not safe to completely trust time comparisons because records
    // could theoretically have the same time. Therefore, we collect these theoretical events
    // for a final filtering.
    final List<EventModel> localSyncedEvents = [];
    for (var e in localEvents) {
      DateTime? remoteDate = e.remoteCreatedAt;
      // TRICKY: Notice the ! prefix to the date comparison.
      if (e.synced &&
          remoteDate != null &&
          !remoteDate.isAfter(lastEventSyncTime)) {
        localSyncedEvents.add(e);
      }
    }

    List<RemoteEventModel> remoteEvents;
    try {
      remoteEvents = await remoteDataSource.getEvents(
        host: Uri.parse(host),
        token: authToken,
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }

    for (var e in remoteEvents) {
      final DateTime? remoteDate = e.createdAt;
      // skip already synced events
      if (remoteDate != null && remoteDate.isBefore(lastEventSyncTime)) {
        continue;
      }

      // TRICKY: because date comparisons like the one above are imprecise,
      // we brute-force check over a theoretical remaining subset.
      final int index = localSyncedEvents.indexWhere((element) {
        return element.remoteId != null && element.remoteId == e.id;
      });
      if (index >= 0) continue;

      // add new events
      try {
        await localDataSource.cacheEvent(EventModel.fromRemote(
          remoteEvent: e,
          id: idGenerator.generateId(),
        ).copyWith(createdAt: timeInfo.now()));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> push(String host, String authToken) async {
    List<EventModel> events;

    try {
      events = await localDataSource.getAllEvents();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }

    for (var e in events) {
      if (e.synced) continue;
      try {
        final syncedEvent = await remoteDataSource.createEvent(
          e.toRemote(),
          host: Uri.parse(host),
          token: authToken,
        );

        await localDataSource.cacheEvent(EventModel.fromRemote(
          remoteEvent: syncedEvent,
          id: e.id,
        ).copyWith(merged: e.merged, createdAt: timeInfo.now()));
      } on OutOfSyncException catch (e) {
        return Left(OutOfSyncFailure(message: e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> rebase() async {
    List<EventModel> events;
    try {
      events = await localDataSource.getAllEvents();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }

    // Group events based on stream_id
    final eventGroups = groupBy(events, (EventModel obj) => obj.streamId);

    for (final streamId in eventGroups.keys) {
      final events = eventGroups[streamId];
      if (events == null || events.isEmpty) continue;
      try {
        await _rebaseStream(events);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
    return const Right(null);
  }

  /// Rebase the events within a single stream.
  /// The process of rebasing will ensure that all un-synced event versions
  /// properly increment from the last synced version.
  ///
  /// Secondarily, this will ensure that a stream with no synced events starts at version 1.
  ///
  /// This expects [events] to be sorted by version.
  /// This may throw a [CacheException]
  Future<void> _rebaseStream(List<EventModel> events) async {
    final syncedEvents = [];
    final unSyncedEvents = [];
    for (var e in events) {
      if (e.synced) {
        syncedEvents.add(e);
      } else {
        unSyncedEvents.add(e);
      }
    }

    // skip rebase if everything is synced
    if (unSyncedEvents.isEmpty) return;

    int lastSyncedVersion = 0;
    if (syncedEvents.isNotEmpty) {
      lastSyncedVersion = syncedEvents.last.version;
    }

    // skip rebase if versions are already correct
    if (unSyncedEvents.first.version == lastSyncedVersion + 1) return;

    int lastVersion = lastSyncedVersion;
    for (final unSyncedEvent in unSyncedEvents) {
      final updatedEvent = unSyncedEvent.copyWith(
        version: lastVersion + 1,
      );

      await localDataSource.cacheEvent(updatedEvent);
      lastVersion = updatedEvent.version;
    }
  }

  @override
  Future<Either<Failure, void>> add(EventInfo<EventParams> event) async {
    // get stream version
    final int streamVersion;
    try {
      streamVersion = await _getStreamVersion(event.streamId);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }

    try {
      final eventModel = EventModel(
        id: idGenerator.generateId(),
        version: streamVersion + 1,
        createdAt: timeInfo.now(),
        streamId: event.streamId,
        data: event.data?.toJson() ?? {},
        name: event.name,
      );

      await localDataSource.cacheEvent(eventModel);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
    return const Right(null);
  }

  /// Returns the latest version of the event stream.
  /// This will throw a [CacheException] if the stream cannot be loaded.
  Future<int> _getStreamVersion(String streamId) async {
    List<EventModel> streamEvents;

    streamEvents = await localDataSource.getAllEvents();
    streamEvents.removeWhere((element) => element.streamId != streamId);

    int lastEventVersion = 0;
    if (streamEvents.isNotEmpty) {
      lastEventVersion = streamEvents.last.version;
    }
    return lastEventVersion;
  }

  @override
  Future<Either<Failure, List<EventStub>>> list() async {
    List<EventModel> models;
    try {
      models = await localDataSource.getAllEvents();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }

    final List<EventStub> events = [];
    for (var e in models) {
      events.add(e.toDomain());
    }

    return Right(events);
  }

  @override
  Future<Either<Failure, void>> markReduced(EventStub event) async {
    List<EventModel> models;
    try {
      models = await localDataSource.getAllEvents();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }

    for (var m in models) {
      if (m.id == event.id) {
        try {
          await localDataSource.cacheEvent(m.copyWith(merged: true));
          return const Right(null);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      }
    }
    return const Left(CacheFailure(message: 'Event does not exist'));
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDataSource.clear();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
