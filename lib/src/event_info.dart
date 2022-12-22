/// Defines an event instance.
abstract class EventInfo<T> {
  /// The id of this event stream.
  /// This should be a UUID.
  final String streamId;

  /// The name of the event is used to deserialize raw event data.
  final String name;

  /// The domain specific data for the event.
  final T? data;

  const EventInfo({
    required this.streamId,
    required this.data,
    required this.name,
  })  : assert(streamId != ''),
        assert(name != '');
}
