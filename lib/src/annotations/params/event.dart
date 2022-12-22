import 'package:event_sync/event_sync.dart';

/// This defines a new event.
/// This is used when registering events in the [EventSync] annotation.
class Event {
  // TODO: we could include additional information about the event here.
  final EventHandler handler;

  const Event({required this.handler});
}
