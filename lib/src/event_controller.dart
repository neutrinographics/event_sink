import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/event_handler.dart';
import 'package:event_sink/src/event_sink_base.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sink/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/clear_cache.dart';
import 'package:event_sink/src/feature/domain/use_cases/set_string_config.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';

// this is sort of in the position of a bloc.
// So this should only interact directly with the use-cases.
class EventController {
  final SyncEvents _syncEvents;
  final ApplyEvents _applyEvents;
  final AddEvent _addEvent;
  final ClearCache _clearCache;

  EventController({
    required SyncEvents syncEvents,
    required ApplyEvents applyEvents,
    required AddEvent addEvent,
    required SetStringConfig setConfig,
    required ClearCache clearCache,
  })  : _syncEvents = syncEvents,
        _applyEvents = applyEvents,
        _addEvent = addEvent,
        _clearCache = clearCache;

  /// Synchronizes events with the server
  Future<Either<Failure, void>> sync(
    Uri host,
    int pool, {
    String? authToken,
    int retryCount = 4,
  }) =>
      _syncEvents(SyncEventsParams(
        host: host,
        authToken: authToken,
        pool: pool,
        retryCount: retryCount,
      ));

  /// Processes events
  Future<Either<Failure, void>> apply(
          int pool,
          Map<String, EventHandler> handlers,
          Map<String, EventDataGenerator> paramGenerators) =>
      _applyEvents(ApplyEventsParams(
        pool: pool,
        handlers: handlers,
        dataGenerators: paramGenerators,
      ));

  /// Adds an event
  Future<Either<Failure, void>> add(EventInfo<EventData> event, int pool) =>
      _addEvent(AddEventParams(event: event, pool: pool));

  /// Deletes all of the locally cached data.
  Future<Either<Failure, void>> drain() async =>
      _clearCache(const ClearCacheParams());

  /// Deletes all of the locally cached data in the pool
  Future<Either<Failure, void>> drainPool(int pool) async =>
      _clearCache(ClearCacheParams(pool: pool));
}
