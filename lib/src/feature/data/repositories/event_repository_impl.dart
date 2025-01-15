import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/data/event_resolver.dart';
import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/core/hash_generator.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/extensions.dart';

class EventRepositoryImpl extends EventRepository {
  final EventLocalDataSource localDataSource;
  final Map<String, EventRemoteAdapter> remoteAdapters;
  final EventResolver eventResolver;
  final IdGenerator idGenerator;
  final HashGenerator hashGenerator;
  final TimeInfo timeInfo;

  EventRepositoryImpl({
    required this.localDataSource,
    required this.remoteAdapters,
    required this.eventResolver,
    required this.idGenerator,
    required this.hashGenerator,
    required this.timeInfo,
  });

  @override
  Future<Either<Failure, void>> fetch({
    required String remoteAdapterName,
    required String pool,
  }) async {
    List<RemoteEventModel> remoteEvents;
    try {
      List<EventModel> pooledEvents =
          await localDataSource.getPooledEvents(pool);
      final stateHash = pooledEvents.asHash(hashGenerator);
      remoteEvents = await _getRemoteAdapter(remoteAdapterName).pull(
        pool,
        stateHash,
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }

    List<EventModel> eventsToAdd = [];
    for (final e in remoteEvents) {
      final remoteEvent = EventModel.fromRemote(
        remoteEvent: e,
        pool: pool,
        remoteAdapterName: remoteAdapterName,
      ).copyWith(createdAt: timeInfo.now());
      final resolvedEvent = await _resolveEvent(remoteEvent, remoteAdapterName);
      eventsToAdd.add(resolvedEvent);
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
    List<EventModel> pooledEvents;

    try {
      pooledEvents = await localDataSource.getPooledEvents(pool);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }

    final eventsToAdd = <EventModel>[];

    try {
      final eventsToPush = pooledEvents
          .where((e) => !e.isSyncedWith(remoteAdapterName))
          .map((e) => e.toRemote())
          .toList();
      final stateHash = pooledEvents.asHash(hashGenerator);
      final pushedEvents = await _getRemoteAdapter(remoteAdapterName)
          .push(pool, stateHash, eventsToPush);

      final pushEvents = pushedEvents.map((pushedEvent) async {
        final isApplied = pooledEvents
            .firstWhere((event) => event.eventId == pushedEvent.eventId)
            .applied;
        final pooledEvent = pooledEvents
            .where((p) => p.eventId == pushedEvent.eventId)
            .firstOrNull;
        final synced =
            pooledEvent != null ? pooledEvent.synced.toSet() : <String>{};
        synced.add(remoteAdapterName);
        final remoteEvent = EventModel.fromRemote(
          remoteEvent: pushedEvent,
          pool: pool,
          remoteAdapterName: remoteAdapterName,
        );
        final resolvedEvent = await _resolveEvent(
          remoteEvent,
          remoteAdapterName,
        );
        return resolvedEvent.copyWith(
          applied: isApplied,
          createdAt: timeInfo.now(),
        );
      });
      final remotePushedEvents = await Future.wait(pushEvents);
      eventsToAdd.addAll(remotePushedEvents);
    } on OutOfSyncException catch (e) {
      return Left(OutOfSyncFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
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
        // TODO: replace rebase with [EventRebaseHelper.rebase]
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
    final syncedEvents = <EventModel>[];
    final unSyncedEvents = <EventModel>[];
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
  // TODO: rename this so it doesn't get confused with listEvents method
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
  Future<Either<Failure, List<EventModel>>> listEvents(String pool) async {
    try {
      final events = await localDataSource.getPooledEvents(pool);
      return Right(events);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  @override
  Future<Either<Failure, EventModel>> get(String eventId) async {
    try {
      final event = await localDataSource.getEvent(eventId);
      return Right(event);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
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

  @override
  Future<Either<Failure, String>> getStreamRootHash(
    String pool,
    String streamId,
  ) async {
    try {
      final hashResult = await localDataSource.getStreamRootHash(
        pool,
        streamId,
      );
      return Right(hashResult);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  @override
  Future<Either<Failure, List<StreamHash>>> listStreamHashes(
    String pool,
    String streamId,
  ) async {
    try {
      final hashes = await localDataSource.listStreamHashes(pool, streamId);
      return Right(hashes);
    } on Exception catch (e, stack) {
      return Left(CacheFailure(message: "$e\n\n$stack"));
    }
  }

  Future<EventModel> _resolveEvent(
    EventModel eventFromAdapter,
    String remoteAdapterName,
  ) async {
    final localEventExists =
        await localDataSource.hasEvent(eventFromAdapter.eventId);
    if (localEventExists) {
      final localEvent =
          await localDataSource.getEvent(eventFromAdapter.eventId);
      final resolvedEvent = eventResolver.resolve(
        eventFromAdapter: eventFromAdapter,
        existingEvent: localEvent,
        remoteAdapterName: remoteAdapterName,
        remoteAdapters: remoteAdapters,
      );

      // synced to many
      return resolvedEvent;
    } else {
      // synced to one
      return eventFromAdapter;
    }
  }

  EventRemoteAdapter _getRemoteAdapter(String name) {
    final adapter = remoteAdapters[name];
    if (adapter == null) {
      throw Exception("Remote adapter not found: $name");
    }
    return adapter;
  }
}
