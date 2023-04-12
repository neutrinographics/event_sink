import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/sink_controller.dart';
import 'injection_container.dart' as ic;

typedef EventParamsGenerator = EventData Function(Map<String, dynamic>);

/// Defines the logic for interacting with the event controller.
abstract class EventSinkBase {
  Map<String, EventHandler> eventHandlersMap();

  Map<String, EventParamsGenerator> get eventParamsGeneratorMap;

  /// Returns the correct url path to which a pool of events will be synced.
  String remotePoolPath(int pool);

  late SinkController _controller;

  List<EventInfo> events = [];

  EventSinkBase({String? host}) {
    ic.init();
    _controller = ic.sl<SinkController>();
  }

  /// Configures the auth token used for API requests.
  Future<Either<Failure, void>> setAuth(String token) =>
      _controller.setAuth(token);

  /// Configures the remote host for API requests.
  Future<Either<Failure, void>> setHost(Uri host) => _controller.setHost(host);

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> sync() => _controller.sync();

  /// Adds an event to the queue.
  Future<Either<Failure, void>> add(EventInfo<EventData> event, int pool) =>
      _controller.add(event, pool);

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
