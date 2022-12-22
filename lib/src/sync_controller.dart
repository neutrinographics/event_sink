import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/params.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/event_handler.dart';
import 'package:event_sync/src/feature/domain/entities/event_info.dart';
import 'package:event_sync/src/feature/domain/use_cases/add_event.dart';
import 'package:event_sync/src/feature/domain/use_cases/apply_events.dart';
import 'package:event_sync/src/feature/domain/use_cases/sync_events.dart';

// this is sort of in the position of a bloc.
// So this should only interact directly with the use-cases.
class SyncController {
  final SyncEvents _syncEvents;
  final ApplyEvents _applyEvents;
  final AddEvent _addEvent;

  SyncController({
    required SyncEvents syncEvents,
    required ApplyEvents applyEvents,
    required AddEvent addEvent,
  })  : _syncEvents = syncEvents,
        _applyEvents = applyEvents,
        _addEvent = addEvent;

  Future<Either<Failure, void>> sync() => _syncEvents(const SyncEventsParams());

  Future<Either<Failure, void>> apply(Map<String, EventHandler> handlers) =>
      _applyEvents(ApplyEventsParams(handlers: handlers));

  Future<void> add(EventInfo event) => _addEvent(AddEventParams(event: event));
}
