import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/sink_controller.dart';
import 'injection_container.dart' as ic;

typedef EventDataGenerator = EventData Function(Map<String, dynamic>);

/// Defines the logic for interacting with the event controller.
abstract class EventSinkBase {
  Map<String, EventHandler> get _eventHandlersMap;

  Map<String, EventDataGenerator> get _eventDataGeneratorMap;

  late SinkController _controller;

  EventSinkBase() {
    ic.init();
    _controller = ic.sl<SinkController>();
  }

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> sync(
    Uri host,
    int pool, {
    String? authToken,
    int retryCount = 4,
  }) =>
      _controller.sync(
        host,
        pool,
        authToken: authToken,
        retryCount: retryCount,
      );

  /// Adds an event to the pool.
  Future<Either<Failure, void>> add(EventInfo<EventData> event, int pool) =>
      _controller.add(event, pool);

  /// Applies any un-processed events.
  Future<Either<Failure, void>> apply(int pool) =>
      _controller.apply(pool, _eventHandlersMap, _eventDataGeneratorMap);
}
