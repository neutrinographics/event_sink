import 'package:event_sink/event_sink.dart';

abstract class EventResolver {
  /// Produces a new event by resolving the change against the remote adapters.
  /// Adapters have different priorities and strategies, so the resolved event will
  /// be the result of applying the strategies in the correct order.
  EventModel resolve(EventModel existingEvent, EventModel eventFromAdapter,
      String remoteAdapterName, Map<String, EventRemoteAdapter> remoteAdapters);
}

class EventResolverImpl implements EventResolver {
  @override
  EventModel resolve(
      EventModel existingEvent,
      EventModel eventFromAdapter,
      String remoteAdapterName,
      Map<String, EventRemoteAdapter> remoteAdapters) {
    return eventFromAdapter;
  }
}
