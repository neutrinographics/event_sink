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
  /// The name of the remote adapter.
  String get name;

  /// The priority of the remote adapter.
  int get priority;

  /// The pull strategy to apply to the remote events.
  PullStrategy get pullStrategy;
}
