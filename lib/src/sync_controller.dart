import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/event_handler.dart';
import 'package:event_sync/src/event_params.dart';
import 'package:event_sync/src/event_sync_base.dart';
import 'package:event_sync/src/feature/domain/entities/event_info.dart';
import 'package:event_sync/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sync/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sync/src/feature/domain/use_cases/set_config.dart';
import 'package:event_sync/src/feature/domain/use_cases/sync_events.dart';

// this is sort of in the position of a bloc.
// So this should only interact directly with the use-cases.
class SyncController {
  final SyncEvents _syncEvents;
  final ApplyEvents _applyEvents;
  final AddEvent _addEvent;
  final SetConfig _setConfig;

  SyncController({
    required SyncEvents syncEvents,
    required ApplyEvents applyEvents,
    required AddEvent addEvent,
    required SetConfig setConfig,
  })  : _syncEvents = syncEvents,
        _applyEvents = applyEvents,
        _addEvent = addEvent,
        _setConfig = setConfig;

  Future<Either<Failure, void>> sync() => _syncEvents(const SyncEventsParams());

  Future<Either<Failure, void>> apply(Map<String, EventHandler> handlers,
          Map<String, EventParamsGenerator> paramGenerators) =>
      _applyEvents(ApplyEventsParams(
          handlers: handlers, paramGenerators: paramGenerators));

  Future<Either<Failure, void>> add(EventInfo<EventParams> event) =>
      _addEvent(AddEventParams(event: event));

  Future<Either<Failure, void>> setAuth(String token) =>
      _setConfig(SetConfigParams(option: ConfigOption.authToken, value: token));

  Future<Either<Failure, void>> setHost(String host) =>
      _setConfig(SetConfigParams(option: ConfigOption.serverHost, value: host));
}
