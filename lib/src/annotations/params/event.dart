import 'package:event_sink/event_sink.dart';

/// This defines a new event.
/// This is used when registering events in the [EventSinkConfig] annotation.
class Event<T extends EventData> {
  /// The unique name of the event.
  final String name;

  /// The data that will be stored in the event.
  // final EventData data;

  const Event({required this.name});
}
