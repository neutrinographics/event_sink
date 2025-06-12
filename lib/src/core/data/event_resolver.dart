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

    final syncedAdapters = <String>{};
    syncedAdapters.addAll(existingEvent.synced);
    syncedAdapters.addAll(eventFromAdapter.synced);

    if (_existingEventHasLowerOrEqualPriority(
      existingEvent,
      newEventAdapter,
      remoteAdapters,
    )) {
      return eventFromAdapter.copyWith(
        synced: syncedAdapters.toList(),
        applied: existingEvent.applied,
      );
    } else {
      return existingEvent.copyWith(
        synced: syncedAdapters.toList(),
      );
    }
  }

  /// The existing event was synced to an adapter with lower priority than the compared adapter.
  bool _existingEventHasLowerOrEqualPriority(
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
          existingEventAdapter.priority <= comparedAdapter.priority;
    });
  }
}
