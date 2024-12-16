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

    if (_existingEventHasEqualPriority(
      existingEvent,
      newEventAdapter,
      remoteAdapters,
    )) {
      return eventFromAdapter;
    }

    if (_existingEventHasLowerPriority(
      existingEvent,
      newEventAdapter,
      remoteAdapters,
    )) {
      return eventFromAdapter;
    } else {
      return existingEvent;
    }
  }

  /// The existing event was synced to an adapter with the same priority as the compared adapter.
  bool _existingEventHasEqualPriority(
    EventModel existingEvent,
    EventRemoteAdapter comparedAdapter,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) {
    return existingEvent.synced.any((adapterName) {
      final existingEventAdapter = remoteAdapters[adapterName];
      if (existingEventAdapter == null) {
        throw ArgumentError('Remote Adapter "$adapterName" not found');
      }

      return existingEventAdapter != comparedAdapter &&
          existingEventAdapter.priority == comparedAdapter.priority;
    });
  }

  /// The existing event was synced to an adapter with lower priority than the compared adapter.
  bool _existingEventHasLowerPriority(
    EventModel existingEvent,
    EventRemoteAdapter comparedAdapter,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) {
    return existingEvent.synced.any((adapterName) {
      final existingEventAdapter = remoteAdapters[adapterName];
      if (existingEventAdapter == null) {
        throw ArgumentError('Remote Adapter "$adapterName" not found');
      }

      return existingEventAdapter != comparedAdapter &&
          existingEventAdapter.priority < comparedAdapter.priority;
    });
  }
}
