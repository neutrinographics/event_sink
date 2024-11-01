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
    final newEventAdapter = remoteAdapters[remoteAdapterName];
    if (newEventAdapter == null) {
      throw ArgumentError('Remote Adapter "$remoteAdapterName" not found');
    }

    if (!existingEvent.isSynced()) {
      return eventFromAdapter;
    }

    if (_isExistingEventSyncedWithEqualPriorityAdapters(
      existingEvent,
      newEventAdapter,
      remoteAdapters,
    )) {
      return eventFromAdapter;
    }

    if (_isExistingEventSyncedWithLowerPriorityAdapters(
      existingEvent,
      newEventAdapter,
      remoteAdapters,
    )) {
      return eventFromAdapter;
    } else {
      return existingEvent;
    }
  }

  bool _isExistingEventSyncedWithEqualPriorityAdapters(
    EventModel existingEvent,
    EventRemoteAdapter newEventAdapter,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) {
    return existingEvent.synced.entries.any((entry) {
      final existingEventAdapter = remoteAdapters[entry.key];
      if (existingEventAdapter == null) {
        throw ArgumentError('Remote Adapter "${entry.key}" not found');
      }

      return existingEventAdapter != newEventAdapter &&
          existingEventAdapter.priority == newEventAdapter.priority;
    });
  }

  bool _isExistingEventSyncedWithLowerPriorityAdapters(
    EventModel existingEvent,
    EventRemoteAdapter newEventAdapter,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) {
    return existingEvent.synced.entries.any((entry) {
      final existingEventAdapter = remoteAdapters[entry.key];
      if (existingEventAdapter == null) {
        throw ArgumentError('Remote Adapter "${entry.key}" not found');
      }

      return existingEventAdapter != newEventAdapter &&
          existingEventAdapter.priority < newEventAdapter.priority;
    });
  }
}
