import 'package:clean_cache/clean_cache.dart';
import 'package:collection/collection.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';

import '../models/pool_model.dart';

abstract class EventLocalDataSource {
  /// Writes an event to the cache.
  Future<void> addEvent(EventModel model);

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
  Future<int> getPoolSize(int poolId);

  /// Returns a sorted list of events from the pool.
  Future<List<EventModel>> getPooledEvents(int poolId);

  /// Returns a list of all cached pools.
  Future<List<int>> getPools();

  /// Clears the cache in all pools.
  Future<void> clear();

  /// Clears the cache in a single pool.
  Future<void> clearPool(int poolId);
}

class EventLocalDataSourceImpl extends EventLocalDataSource {
  /// A cache of every event record
  final CleanCache<String, EventModel> eventCache;

  /// A cache of pools of events.
  /// This allows us to manage events from different pools.
  final CleanCache<int, PoolModel> poolCache;

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
  Future<List<EventModel>> getPooledEvents(int poolId) async {
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
  Future<List<int>> getPools() => poolCache.keys();

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
  Future<PoolModel> _readPool(int poolId) async {
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
    final pools = <int, PoolModel>{};

    for (final event in events) {
      final pool = pools[event.pool] ?? PoolModel(id: event.pool, eventIds: []);
      pool.eventIds.add(event.eventId);
    }
    for (final pool in pools.values) {
      await poolCache.write(pool.id, pool);
    }
  }

  /// Sorts a list of events.
  static void sort(List<EventModel> models) {
    models.sort((a, b) {
      // place synced events in front
      if (a.synced && !b.synced) {
        return -1;
      }
      if (!a.synced && b.synced) {
        return 1;
      }
      // sort synced events by order
      if (a.synced && b.synced) {
        return a.order - b.order;
      }
      // sort un-synced events by order
      if (!a.synced && !b.synced) {
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
  Future<int> getPoolSize(int poolId) async {
    final pool = await _readPool(poolId);
    return pool.eventIds.length;
  }

  @override
  Future<void> clearPool(int poolId) async {
    final pool = await _readPool(poolId);
    for (final id in pool.eventIds) {
      await eventCache.delete(id);
    }
    await poolCache.delete(poolId);
  }
}
