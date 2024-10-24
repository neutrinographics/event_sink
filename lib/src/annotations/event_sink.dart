import 'package:event_sink/src/annotations/params/event.dart';
import 'package:event_sink/src/annotations/params/remote_adapter.dart';

/// Defines a new event sink controller.
class EventSinkConfig {
  final List<Event> events;

  final List<RemoteAdapter> remotes;

  const EventSinkConfig({
    required this.remotes,
    required this.events,
  });
}
