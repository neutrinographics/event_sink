

import 'package:event_sync/src/core/data/local_cache.dart';
import 'package:event_sync/src/feature/data/local/models/event_model.dart';

abstract class EventLocalDataSource {
  /// Writes an event to the cache.
  Future<void> cacheEvent(EventModel model);

  /// Returns a sorted list of [EventModel]
  Future<List<EventModel>> getAllEvents();

  /// Deletes an event from the cache.
  Future<void> deleteEvent(String eventId);

  /// Clears the cache.
  Future<void> clear();
}

class EventLocalDataSourceImpl extends EventLocalDataSource {
  final LocalCache<String, EventModel> cache;

  EventLocalDataSourceImpl({required this.cache});

  @override
  Future<void> cacheEvent(EventModel model) => cache.write(model.id, model);

  @override
  Future<void> deleteEvent(String eventId) => cache.delete(eventId);

  @override
  Future<List<EventModel>> getAllEvents() async {
    final eventModels = await cache.values();

    eventModels.sort((a, b) {
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
        return a.remoteId! - b.remoteId!;
      }
      return a.createdAt.compareTo(b.createdAt);
    });

    return eventModels;
  }

  @override
  Future<void> clear() => cache.clear();
}
