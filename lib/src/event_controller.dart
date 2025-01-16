import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/event_handler.dart';
import 'package:event_sink/src/event_sink.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sink/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/clear_cache.dart';
import 'package:event_sink/src/feature/domain/use_cases/get_event.dart';
import 'package:event_sink/src/feature/domain/use_cases/get_stream_root_hash.dart';
import 'package:event_sink/src/feature/domain/use_cases/list_events.dart';
import 'package:event_sink/src/feature/domain/use_cases/list_stream_hashes.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';

// this is sort of in the position of a bloc.
// So this should only interact directly with the use-cases.
class EventController {
  final SyncEvents _syncEvents;
  final ApplyEvents _applyEvents;
  final AddEvent _addEvent;
  final ClearCache _clearCache;
  final ListEvents _listEvents;
  final GetEvent _getEvent;
  final GetStreamRootHash _getStreamRootHash;
  final ListStreamHashes _listStreamHashes;

  EventController({
    required SyncEvents syncEvents,
    required ApplyEvents applyEvents,
    required AddEvent addEvent,
    required ClearCache clearCache,
    required ListEvents listEvents,
    required GetEvent getEvent,
    required GetStreamRootHash getStreamRootHash,
    required ListStreamHashes listStreamHashes,
  })  : _syncEvents = syncEvents,
        _applyEvents = applyEvents,
        _addEvent = addEvent,
        _clearCache = clearCache,
        _listEvents = listEvents,
        _getEvent = getEvent,
        _getStreamRootHash = getStreamRootHash,
        _listStreamHashes = listStreamHashes;

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

  Future<Either<Failure, List<EventModel>>> listEvents(String pool) =>
      _listEvents(ListEventsParams(pool: pool));

  Future<Either<Failure, String>> getStreamRootHash(
    String pool,
    String streamId,
  ) =>
      _getStreamRootHash(
          GetStreamRootHashParams(pool: pool, streamId: streamId));

  Future<Either<Failure, List<StreamHash>>> listStreamHashes(
          String pool, String streamId) =>
      _listStreamHashes(ListStreamHashesParams(pool: pool, streamId: streamId));

  Future<Either<Failure, EventModel>> getEvent(String eventId) =>
      _getEvent(GetEventParams(eventId: eventId));
}
