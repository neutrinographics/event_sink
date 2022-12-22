import 'package:event_sync/src/annotations/params/event.dart';

/// Defines a new event sync controller.
class EventSync {
  final List<Event> events;

  // TODO: we could provide additional configuration options here

  const EventSync({required this.events});
}
