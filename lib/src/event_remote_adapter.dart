import 'package:event_sink/event_sink.dart';

abstract class EventRemoteAdapter {
  /// The pull strategy to apply to the remote events.
  PullStrategy get pullStrategy;

  /// The priority of the remote adapter.
  /// higher number means higher priority
  int get priority;

  /// Pulls events from the remote source
  /// then apply [pullStrategy].
  Future<List<RemoteEventModel>> pull();

  /// Pushes events to the remote source.
  /// Returns the newly created remote events.
  Future<List<RemoteEventModel>> push(List<RemoteNewEventModel> events);
}
