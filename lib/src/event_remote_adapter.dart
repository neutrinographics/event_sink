import 'package:event_sink/event_sink.dart';

abstract class EventRemoteAdapter {
  /// Pulls events from the remote source
  /// then apply [pullStrategy].
  Future<List<RemoteEventModel>> pull();

  /// Pushes events to the remote source.
  /// Returns the newly created remote events.
  Future<List<RemoteEventModel>> push(List<RemoteNewEventModel> events);
}

mixin RemoteAdapterProperties {
  int get priority;

  PullStrategy get pullStrategy;
}
