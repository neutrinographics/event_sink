import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/event_controller.dart';
import 'injection_container.dart' as ic;

typedef EventDataGenerator = EventData Function(Map<String, dynamic>);

/// Defines the logic for interacting with the event controller.
abstract class EventSink {
  Map<String, EventHandler> eventHandlersMap();

  Map<String, EventDataGenerator> get eventDataGeneratorMap;

  Map<String, EventRemoteAdapter> get eventRemoteAdapters;

  late EventController _controller;

  /// Make sure you call this in your app's main function before doing anything else!
  Future<void> init() async {
    await ic.init();
    _controller = ic.sl<EventController>();
  }

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> sync({
    required String remoteAdapterName,
    required String pool,
  }) {
    final remoteAdapter = eventRemoteAdapters[remoteAdapterName];
    if (remoteAdapter == null) {
      return Future.value(
          const Left(ServerFailure(message: 'Remote adapter not found')));
    }

    return _controller.sync(
      remoteAdapter: remoteAdapter,
      pool: pool,
    );
  }

  /// Adds an event to the pool.
  Future<Either<Failure, void>> add(EventInfo<EventData> event, String pool) =>
      _controller.add(event, pool);

  /// Applies any un-processed events.
  Future<Either<Failure, void>> apply(String pool) => _controller
      .processNewEvents(pool, eventHandlersMap(), eventDataGeneratorMap);

  /// Deletes all of the locally cached data.
  Future<Either<Failure, void>> drain() => _controller.deleteAllPoolCaches();

  /// Deletes all of the locally cached data in the pool
  Future<Either<Failure, void>> drainPool(String pool) =>
      _controller.deletePoolCache(pool);
}
