import 'package:event_sink/src/annotations/params/event.dart';

/// Defines a new event sink controller.
class EventSink {
  final List<Event> events;

  // TODO: we could provide additional configuration options here

  const EventSink({required this.events});
}
