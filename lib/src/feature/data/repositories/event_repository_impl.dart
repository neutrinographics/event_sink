import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/extensions.dart';

class EventRepositoryImpl extends EventRepository {
  final EventLocalDataSource localDataSource;
  final IdGenerator idGenerator;
  final TimeInfo timeInfo;

  late Map<String, EventRemoteAdapter> _remoteAdapters;

  EventRepositoryImpl({
    required this.localDataSource,
    required this.idGenerator,
    required this.timeInfo,
  });

  @override
  void init({required Map<String, EventRemoteAdapter> remoteAdapters}) {
    _remoteAdapters = remoteAdapters;
  }

  @override
  Future<Either<Failure, void>> fetch({
    required String remoteAdapterName,
    required String pool,
  }) async {
    List<RemoteEventModel> remoteEvents;
    try {
      remoteEvents = await _getRemoteAdapter(remoteAdapterName).pull();
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }

    List<EventModel> eventsToAdd = [];
    for (var e in remoteEvents) {
      final bool hasEvent = await localDataSource.hasEvent(e.eventId);
      if (!hasEvent) {
        eventsToAdd.add(
          EventModel.fromRemote(
            remoteEvent: e,
            remoteAdapterName: remoteAdapterName,
            pool: pool,
          ).copyWith(createdAt: timeInfo.now()),
        );
      } else {
        final existingEvent = await localDataSource.getEvent(e.eventId);
        if (!existingEvent.isSyncedWith(remoteAdapterName)) {
          eventsToAdd.add(
            existingEvent.copyWith(
              synced: Map.fromEntries(existingEvent.synced.entries)
                ..[remoteAdapterName] = true,
              // TRICKY: the remote event order may be different from the local order.
              order: e.order,
            ),
          );
        }
      }
    }

    try {
      await localDataSource.addEvents(eventsToAdd);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> push({
    required String remoteAdapterName,
    required String pool,
  }) async {
    List<EventModel> events;

    try {
      events = await localDataSource.getPooledEvents(pool);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }

    List<EventModel> eventsToAdd = [];
    for (var e in events) {
      if (e.isSyncedWith(remoteAdapterName)) continue;
      try {
        // TODO: refactor this to use a batch push
        final syncedEvent =
            await _getRemoteAdapter(remoteAdapterName).push([e.toNewRemote()]);

        eventsToAdd.add(
          EventModel.fromRemote(
            remoteEvent: syncedEvent.first,
            remoteAdapterName: remoteAdapterName,
            pool: pool,
          ).copyWith(applied: e.applied, createdAt: timeInfo.now()),
        );
      } on OutOfSyncException catch (e) {
        return Left(OutOfSyncFailure(message: e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on Exception catch (e, stack) {
        return Left(CacheFailure(message: "$e\n\n$stack"));
      }
    }

    try {
      await localDataSource.addEvents(eventsToAdd);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> rebase(String pool) async {
    List<EventModel> events;
    try {
      events = await localDataSource.getPooledEvents(pool);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }

    // Group events based on stream_id
    final eventGroups = groupBy(events, (EventModel obj) => obj.streamId);

    for (final streamId in eventGroups.keys) {
      final events = eventGroups[streamId];
      if (events == null || events.isEmpty) continue;
      try {
        await _rebaseStream(events);
      } on Exception catch (e, stack) {
        return Left(CacheFailure(message: "$e\n\n$stack"));
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
      // TODO: handle the case where an event is synced to multiple remotes
      if (e.isSynced()) {
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

    List<EventModel> eventsToAdd = [];
    for (final unSyncedEvent in unSyncedEvents) {
      final updatedEvent = unSyncedEvent.copyWith(
        version: lastVersion + 1,
      );
      eventsToAdd.add(updatedEvent);
      lastVersion = updatedEvent.version;
    }

    await localDataSource.addEvents(eventsToAdd);
  }

  @override
  Future<Either<Failure, void>> add(
      EventInfo<EventData> event, String pool) async {
    try {
      final streamVersion = await _getStreamVersion(event.streamId, pool);
      final poolSize = await localDataSource.getPoolSize(pool);
      final eventModel = EventModel(
        eventId: idGenerator.generateId(),
        order: poolSize + 1,
        version: streamVersion + 1,
        createdAt: timeInfo.now(),
        streamId: event.streamId,
        data: event.data?.toJson() ?? {},
        name: event.name,
        pool: pool,
      );

      await localDataSource.addEvent(eventModel);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
    return const Right(null);
  }

  /// Returns the latest version of the event stream.
  /// This will throw a [CacheException] if the stream cannot be loaded.
  /// TODO: this should be updated to be more performant.
  Future<int> _getStreamVersion(String streamId, String pool) async {
    List<EventModel> streamEvents;

    streamEvents = await localDataSource.getPooledEvents(pool);
    streamEvents.removeWhere((element) => element.streamId != streamId);

    int lastEventVersion = 0;
    if (streamEvents.isNotEmpty) {
      lastEventVersion = streamEvents.last.version;
    }
    return lastEventVersion;
  }

  @override
  Future<Either<Failure, List<EventStub>>> list(String pool) async {
    List<EventModel> models;
    try {
      models = await localDataSource.getPooledEvents(pool);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }

    final List<EventStub> events = [];
    for (var e in models) {
      events.add(e.toDomain());
    }

    return Right(events);
  }

  @override
  Future<Either<Failure, void>> markApplied(EventStub event) async {
    try {
      final model = await localDataSource.getEvent(event.eventId);
      await localDataSource.addEvent(model.copyWith(applied: true));
      return const Right(null);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  @override
  Future<Either<Failure, void>> markAppliedList(List<EventStub> events) async {
    try {
      final eventIds = events.map((e) => e.eventId).toList();
      final eventModels = await localDataSource.getAllEvents()
        ..retainWhere((element) => eventIds.contains(element.eventId));

      final updatedModels =
          eventModels.map((e) => e.copyWith(applied: true)).toList();

      await localDataSource.addEvents(updatedModels);

      return const Right(null);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDataSource.clear();
      return const Right(null);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  @override
  Future<Either<Failure, void>> clearPoolCache(String pool) async {
    try {
      await localDataSource.clearPool(pool);
      return const Right(null);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  EventRemoteAdapter _getRemoteAdapter(String name) {
    final adapter = _remoteAdapters[name];
    if (adapter == null) {
      throw Exception("Remote adapter not found: $name");
    }
    return adapter;
  }
}
