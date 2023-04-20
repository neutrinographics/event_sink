import 'package:event_sink/src/core/data/local_cache.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';

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

  /// Returns a sorted list of events from the pool.
  Future<List<EventModel>> getPooledEvents(int pool);

  /// Returns a list of all cached pools.
  Future<List<int>> getPools();

  /// Clears the cache.
  Future<void> clear();
}

class EventLocalDataSourceImpl extends EventLocalDataSource {
  final LocalCache<String, EventModel> eventCache;
  final LocalCache<int, List<String>> poolCache;

  EventLocalDataSourceImpl({required this.eventCache, required this.poolCache});

  @override
  Future<void> addEvent(EventModel model) async {
    await eventCache.write(model.eventId, model);

    final eventPool = await _readPool(model.pool);
    if (!eventPool.contains(model.eventId)) {
      eventPool.add(model.eventId);
      await poolCache.write(model.pool, eventPool);
    }
  }

  @override
  Future<void> removeEvent(String eventId) async {
    final model = await eventCache.read(eventId);
    await eventCache.delete(eventId);

    final eventPool = await _readPool(model.pool);
    eventPool.remove(eventId);
    if (eventPool.isEmpty) {
      await poolCache.delete(model.pool);
    } else {
      await poolCache.write(model.pool, eventPool);
    }
  }

  @override
  Future<List<EventModel>> getPooledEvents(int pool) async {
    final List<EventModel> models = [];

    final List<String> eventIds = await _readPool(pool);
    for (final id in eventIds) {
      models.add(await eventCache.read(id));
    }

    sort(models);
    return models;
  }

  @override
  Future<List<int>> getPools() => poolCache.keys();

  @override
  Future<List<EventModel>> getAllEvents() async {
    final List<EventModel> eventModels;
    try {
      eventModels = await eventCache.values();
    } catch (e, trace) {
      throw CacheException(message: '$e\n\n$trace');
    }

    sort(eventModels);
    return eventModels;
  }

  @override
  Future<void> clear() => eventCache.clear();

  /// Returns the pool data or an empty list if the pool is empty.
  Future<List<String>> _readPool(int pool) async {
    if (await poolCache.exists(pool)) {
      return List.from(await poolCache.read(pool));
    } else {
      return [];
    }
  }

  /// Sorts a list of events.
  static void sort(List<EventModel> models) {
    models.sort((a, b) {
      if (a.streamId == b.streamId) {
        return a.version - b.version;
      }
      if (a.synced && !b.synced) {
        return -1;
      }
      if (!a.synced && b.synced) {
        return 1;
      }
      if (a.synced && b.synced) {
        return a.remoteCreatedAt!.compareTo(b.remoteCreatedAt!);
      }
      return a.createdAt.compareTo(b.createdAt);
    });
  }

  @override
  Future<bool> hasEvent(String eventId) => eventCache.exists(eventId);

  @override
  Future<EventModel> getEvent(String eventId) => eventCache.read(eventId);
}
