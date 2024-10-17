import 'package:event_sink/src/feature/data/local/models/event_model.dart';

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
