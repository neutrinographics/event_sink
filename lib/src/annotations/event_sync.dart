import 'package:event_sync/src/annotations/params/event.dart';

/// Defines a new event sync controller.
class EventSync {
  // TODO: we could provide additional configuration options here
  final List<Event> events;

  const EventSync({required this.events});
}
