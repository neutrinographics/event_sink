import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sink/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/clear_cache.dart';
import 'package:event_sink/src/feature/domain/use_cases/list_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';

// this is sort of in the position of a bloc.
// So this should only interact directly with the use-cases.
class EventController {
  final SyncEvents _syncEvents;
  final ApplyEvents _applyEvents;
  final AddEvent _addEvent;
  final ClearCache _clearCache;
  final ListEvents _listEvents;

  EventController({
    required SyncEvents syncEvents,
    required ApplyEvents applyEvents,
    required AddEvent addEvent,
    required ClearCache clearCache,
    required ListEvents listEvents,
  })  : _syncEvents = syncEvents,
        _applyEvents = applyEvents,
        _addEvent = addEvent,
        _clearCache = clearCache,
        _listEvents = listEvents;

  /// Synchronizes events with the server
  Future<Either<Failure, void>> sync({
    required String remoteAdapterName,
    required String pool,
  }) =>
      _syncEvents(SyncEventsParams(
        remoteAdapterName: remoteAdapterName,
        pool: pool,
      ));

  Future<Either<Failure, void>> processNewEvents(
          String pool,
          Map<String, EventHandler> handlers,
          Map<String, EventDataGenerator> paramGenerators) =>
      _applyEvents(ApplyEventsParams(
        pool: pool,
        handlers: handlers,
        dataGenerators: paramGenerators,
      ));

  Future<Either<Failure, void>> add(EventInfo<EventData> event, String pool) =>
      _addEvent(AddEventParams(event: event, pool: pool));

  Future<Either<Failure, void>> deleteAllPoolCaches() async =>
      _clearCache(const ClearCacheParams());

  Future<Either<Failure, void>> deletePoolCache(String pool) async =>
      _clearCache(ClearCacheParams(pool: pool));

  Future<Either<Failure, List<EventStub>>> list(String pool) =>
      _listEvents(ListEventsParams(pool: pool));
}
