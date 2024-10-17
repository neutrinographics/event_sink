import 'package:event_sink/src/annotations/params/event.dart';

/// Defines a new event sink controller.
class EventSinkConfig {
  final List<Event> events;

  const EventSinkConfig({
    required this.events,
  });
}
