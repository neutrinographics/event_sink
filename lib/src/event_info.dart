/// This is event info that can be synced.
abstract class EventInfo<T> {
  /// The id of this event stream.
  /// This should be a UUID.
  final String streamId;
  final String name;
  final T? data;

  const EventInfo({
    required this.streamId,
    required this.data,
    required this.name,
  })  : assert(streamId != ''),
        assert(name != '');
}
