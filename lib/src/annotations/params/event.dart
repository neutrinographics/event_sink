import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/event_data.dart';

/// This defines a new event.
/// This is used when registering events in the [EventSync] annotation.
class Event<T extends EventData> {
  /// The unique name of the event.
  final String name;

  /// The data that will be stored in the event.
  // final EventData data;

  const Event({required this.name});
}
