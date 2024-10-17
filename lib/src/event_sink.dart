import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/event_controller.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'injection_container.dart' as ic;

typedef EventDataGenerator = EventData Function(Map<String, dynamic>);

/// Defines the logic for interacting with the event controller.
abstract class EventSink {
  Map<String, EventHandler> eventHandlersMap();

  Map<String, EventDataGenerator> get eventDataGeneratorMap;

  late EventController _controller;

  /// Make sure you call this in your app's main function before doing anything else!
  Future<void> init({
    required EventLocalDataSource localDataSource,
    required EventRemoteDataSource remoteDataSource,
  }) async {
    await ic.init();
    ic.sl<EventRepository>().init(
          localDataSource: localDataSource,
          remoteDataSource: remoteDataSource,
        );
    _controller = ic.sl<EventController>();
  }

  /// Uploads events to the server that have been generated on this device.
  Future<Either<Failure, void>> sync(
    int pool, {
    int retryCount = 4,
  }) =>
      _controller.sync(
        pool,
        retryCount: retryCount,
      );

  /// Adds an event to the pool.
  Future<Either<Failure, void>> add(EventInfo<EventData> event, int pool) =>
      _controller.add(event, pool);

  /// Applies any un-processed events.
  Future<Either<Failure, void>> apply(int pool) => _controller.processNewEvents(
      pool, eventHandlersMap(), eventDataGeneratorMap);

  /// Deletes all of the locally cached data.
  Future<Either<Failure, void>> drain() => _controller.deleteAllPoolCaches();

  /// Deletes all of the locally cached data in the pool
  Future<Either<Failure, void>> drainPool(int pool) =>
      _controller.deletePoolCache(pool);
}
