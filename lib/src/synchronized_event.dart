import '../event_sync.dart';

class SynchronizedEvent {
  /// Manually set the event name.
  final String? name;

  const SynchronizedEvent({this.name});
}

/// Defines a new event sync model.
class EventSync {
  final List<Event> events;

  const EventSync({required this.events});
}

abstract class EventSyncBase {
  Map<String, Command> get commandsMap;

  List<EventInfo> events = [];

  /// Adds an event to the queue.
  void add(EventInfo event) {
    // TODO: finish implementing this
    events.add(event);
  }

  /// Applies any un-processed events.
  /// This executes the event command.
  Future<void> apply() async {
    // TODO: get a list of the un-processed events
    // final List<EventInfo> events = [];

    for (final event in events) {
      await commandsMap[event.name]!(event.streamId, event.data);
    }
  }

  /// Compacts all of the event streams.
  /// This will attempt to combine and deduplicate events
  /// within individual streams.
  Future<void> compact() async {
    // TODO: implement this
    throw UnimplementedError();
  }
}
