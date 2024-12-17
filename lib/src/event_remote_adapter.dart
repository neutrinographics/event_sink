import 'package:event_sink/event_sink.dart';

abstract class EventRemoteAdapter {
  /// The pull strategy to apply to the remote events.
  PullStrategy get pullStrategy;

  /// The priority of the remote adapter.
  /// higher number means higher priority
  int get priority;

  /// Pulls events from the remote source [pool] with
  /// hashed current events [stateHash] then apply [pullStrategy].
  Future<List<RemoteEventModel>> pull(
    String pool,
    String stateHash,
  );

  /// Pushes events to the remote source.
  /// Returns the newly created remote events.
  Future<List<RemoteEventModel>> push(
    String pool,
    String stateHash,
    List<RemoteEventModel> events,
  );
}
