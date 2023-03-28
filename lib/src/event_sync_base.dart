import 'package:dartz/dartz.dart';
import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/sync_controller.dart';
import 'injection_container.dart' as ic;

typedef EventParamsGenerator = EventParams Function(Map<String, dynamic>);

/// Defines the logic for interacting with the event controller.
abstract class EventSyncBase {
  Map<String, EventHandler> eventHandlersMap();

  Map<String, EventParamsGenerator> get eventParamsGeneratorMap;

  late SyncController _controller;

  List<EventInfo> events = [];

  EventSyncBase({String? host}) {
    ic.init();
    _controller = ic.sl<SyncController>();
  }

  /// Configures the auth token used for API requests.
  Future<Either<Failure, void>> setAuth(String token) =>
      _controller.setAuth(token);

  /// Configures the remote host for API requests.
  Future<Either<Failure, void>> setHost(Uri host) => _controller.setHost(host);

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> sync() => _controller.sync();

  /// Adds an event to the queue.
  Future<Either<Failure, void>> add(EventInfo<EventParams> event) =>
      _controller.add(event);

  /// Applies any un-processed events.
  /// This executes the event command.
  Future<Either<Failure, void>> apply() =>
      _controller.apply(eventHandlersMap(), eventParamsGeneratorMap);

  /// Compacts all of the event streams.
  /// This will attempt to combine and deduplicate events
  /// within individual streams.
  Future<Either<Failure, void>> compact() async {
    // TODO: implement this
    throw UnimplementedError();
  }
}
