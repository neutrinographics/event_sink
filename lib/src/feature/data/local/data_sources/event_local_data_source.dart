import 'package:clean_cache/clean_cache.dart';
import 'package:collection/collection.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/extensions.dart';

import '../models/pool_model.dart';

abstract class EventLocalDataSource {
  /// Writes an event to the cache.
  Future<void> addEvent(EventModel model);

  /// Writes a list of events to the cache.
  Future<void> addEvents(List<EventModel> models);

  /// Checks if an event exists in the cache
  Future<bool> hasEvent(String eventId);

  /// Returns the event.
  /// This will raise a CacheException if the event does not exist.
  Future<EventModel> getEvent(String eventId);

  /// Deletes an event from the cache.
  Future<void> removeEvent(String eventId);

  /// Returns a sorted list of [EventModel]
  Future<List<EventModel>> getAllEvents();

  /// Returns the number of events in the pool.
  Future<int> getPoolSize(String poolId);

  /// Returns a sorted list of events from the pool.
  Future<List<EventModel>> getPooledEvents(String poolId);

  /// Returns a list of all cached pools.
  Future<List<String>> getPools();

  /// Clears the cache in all pools.
  Future<void> clear();

  /// Clears the cache in a single pool.
  Future<void> clearPool(String poolId);
}

class EventLocalDataSourceImpl extends EventLocalDataSource {
  /// A cache of every event record
  final CleanCache<String, EventModel> eventCache;

  /// A cache of pools of events.
  /// This allows us to manage events from different pools.
  final CleanCache<String, PoolModel> poolCache;

  EventLocalDataSourceImpl({required this.eventCache, required this.poolCache});

  @override
  Future<void> addEvent(EventModel model) async {
    await eventCache.write(model.eventId, model);

    final pool = await _readPool(model.pool);
    if (!pool.eventIds.contains(model.eventId)) {
      final updatedPool =
          pool.copyWith(eventIds: [...pool.eventIds, model.eventId]);
      await poolCache.write(updatedPool.id, updatedPool);
    }
  }

  @override
  Future<void> addEvents(List<EventModel> models) async {
    await eventCache.writeAll(Map.fromEntries(
      models.map((model) => MapEntry(model.eventId, model)),
    ));

    for (final model in models) {
      final pool = await _readPool(model.pool);
      if (!pool.eventIds.contains(model.eventId)) {
        final updatedPool =
            pool.copyWith(eventIds: [...pool.eventIds, model.eventId]);
        await poolCache.write(updatedPool.id, updatedPool);
      }
    }
  }

  @override
  Future<void> removeEvent(String eventId) async {
    final model = await eventCache.read(eventId);
    await eventCache.delete(eventId);

    final pool = await _readPool(model.pool);
    final updatedPoolEventIds =
        pool.eventIds.whereNot((id) => id == eventId).toList();

    if (updatedPoolEventIds.isEmpty) {
      await poolCache.delete(pool.id);
    } else {
      await poolCache.write(
          pool.id,
          pool.copyWith(
            eventIds: updatedPoolEventIds,
          ));
    }
  }

  @override
  Future<List<EventModel>> getPooledEvents(String poolId) async {
    final List<EventModel> models = [];

    final PoolModel pool = await _readPool(poolId);
    for (final id in pool.eventIds) {
      final event = await eventCache.read(id);
      models.add(event);
    }
    sort(models);
    return models;
  }

  @override
  Future<List<String>> getPools() => poolCache.keys();

  @override
  Future<List<EventModel>> getAllEvents() async {
    final List<EventModel> events = await eventCache.values();
    sort(events);
    return events;
  }

  @override
  Future<void> clear() async {
    await eventCache.clear();
    await poolCache.clear();
  }

  /// Returns the pool data or an empty list if the pool is empty.
  Future<PoolModel> _readPool(String poolId) async {
    final noPools = (await poolCache.keys()).isEmpty;
    if (noPools) {
      await _indexPools();
    }

    final poolExists = await poolCache.exists(poolId);
    if (poolExists) {
      return poolCache.read(poolId);
    } else {
      return PoolModel(
        id: poolId,
        eventIds: [],
      );
    }
  }

  Future<void> _indexPools() async {
    final events = await eventCache.values();
    final pools = <String, List<String>>{};

    for (final event in events) {
      final pool = pools[event.pool] ?? [];
      pool.add(event.eventId);
      pools[event.pool] = pool;
    }
    for (final poolId in pools.keys) {
      await poolCache.write(
        poolId,
        PoolModel(
          id: poolId,
          eventIds: pools[poolId] ?? [],
        ),
      );
    }
  }

  /// Sorts a list of events.
  static void sort(List<EventModel> models) {
    models.sort((a, b) {
      // TODO: handle the case where an event is synced to multiple remotes
      final aSynced = a.isSynced();
      final bSynced = b.isSynced();

      // place synced events in front
      if (aSynced && !bSynced) {
        return -1;
      }
      if (!aSynced && bSynced) {
        return 1;
      }
      // sort synced events by order
      if (aSynced && bSynced) {
        return a.order - b.order;
      }
      // sort un-synced events by order
      if (!aSynced && !bSynced) {
        return a.order - b.order;
      }

      // The below sorting rules aren't actually needed.
      // They are just a sanity check.

      // sort streams by version
      if (a.streamId == b.streamId) {
        return a.version - b.version;
      }

      return a.createdAt.compareTo(b.createdAt);
    });
  }

  @override
  Future<bool> hasEvent(String eventId) => eventCache.exists(eventId);

  @override
  Future<EventModel> getEvent(String eventId) {
    return eventCache.read(eventId);
  }

  @override
  Future<int> getPoolSize(String poolId) async {
    final pool = await _readPool(poolId);
    return pool.eventIds.length;
  }

  @override
  Future<void> clearPool(String poolId) async {
    final pool = await _readPool(poolId);
    for (final id in pool.eventIds) {
      await eventCache.delete(id);
    }
    await poolCache.delete(poolId);
  }
}
