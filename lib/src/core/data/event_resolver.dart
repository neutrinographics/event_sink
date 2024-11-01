import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/extensions.dart';

abstract class EventResolver {
  /// Produces a new event by resolving the change against the remote adapters.
  /// Adapters have different priorities and strategies, so the resolved event will
  /// be the result of applying the strategies in the correct order.
  EventModel resolve({
    required EventModel existingEvent,
    required EventModel eventFromAdapter,
    required String remoteAdapterName,
    required Map<String, EventRemoteAdapter> remoteAdapters,
  });
}

class EventResolverImpl implements EventResolver {
  @override
  EventModel resolve({
    required EventModel existingEvent,
    required EventModel eventFromAdapter,
    required String remoteAdapterName,
    required Map<String, EventRemoteAdapter> remoteAdapters,
  }) {
    final newEventRemoteAdapter = remoteAdapters[remoteAdapterName];
    if (newEventRemoteAdapter == null) {
      throw ArgumentError('Remote Adapter "$remoteAdapterName" not found');
    }

    // RULE 1: if the existing event has not been synced,
    // return the event from the adapter.
    if (!existingEvent.isSynced()) {
      return eventFromAdapter;
    }

    // RULE 2: if the existing event has been synced with lower priority adapters,
    // return the event from the adapter.
    // RULE 3: if the existing event has been synced with higher priority adapters,
    // return the existing event.
    final existingEventPriority = newEventRemoteAdapter.priority;
    final existingEventSyncedWithLowerPriorityAdapters =
        existingEvent.synced.entries.any((entry) {
      final adapter = remoteAdapters[entry.key];
      if (adapter == null) {
        throw ArgumentError('Remote Adapter "${entry.key}" not found');
      }

      return adapter.priority < existingEventPriority;
    });
    if (existingEventSyncedWithLowerPriorityAdapters) {
      return eventFromAdapter;
    } else {
      return existingEvent;
    }
  }
}
