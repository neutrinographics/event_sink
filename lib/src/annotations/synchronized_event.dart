/// Generates an event from an event handler.
@Deprecated('use the @EventSink annotation instead to register events.')
class SynchronizedEvent {
  /// Manually set the event name.
  final String? name;

  const SynchronizedEvent({this.name});
}
