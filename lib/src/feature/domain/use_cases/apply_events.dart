import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/usecase.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/event_handler.dart';
import 'package:event_sync/src/event_sync_base.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';

class ApplyEvents extends UseCase<void, ApplyEventsParams> {
  EventRepository eventRepository;

  ApplyEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(ApplyEventsParams params) async {
    // TODO: just get the events that haven't been applied yet.
    final failureOrEvents = await eventRepository.list();
    return failureOrEvents.fold((failure) => Left(failure), (events) async {
      for (final event in events) {
        // TODO: skip if the event has already been merged.
        final eventHandler = params.handlers[event.name];
        if (eventHandler == null) {
          return Left(CacheFailure(
              message:
                  'No handler was found for ${event.name}. This is likely a bug in the code generator.'));
        }
        final paramGenerator = params.paramGenerators[event.name];
        if (paramGenerator == null) {
          return Left(CacheFailure(
              message:
                  'Missing event params generator for ${event.name}. This is likely a problem with the generator.'));
        }

        try {
          final eventParams = paramGenerator(event.data);
          await eventHandler(event.streamId, eventParams);
          await eventRepository.markReduced(event);
        } catch (e, stack) {
          return Left(CacheFailure(message: '$e\n\n$stack'));
        }
      }
      return const Right(null);
    });
  }
}

class ApplyEventsParams {
  final Map<String, EventHandler> handlers;
  final Map<String, EventParamsGenerator> paramGenerators;

  ApplyEventsParams({required this.handlers, required this.paramGenerators});
}
