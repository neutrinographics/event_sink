import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/event_handler.dart';
import 'package:event_sink/src/event_sink_base.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class ApplyEvents extends UseCase<void, ApplyEventsParams> {
  EventRepository eventRepository;

  ApplyEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(ApplyEventsParams params) async {
    final failureOrEvents = await eventRepository.list(params.pool);
    return failureOrEvents.fold((failure) => Left(failure), (events) async {
      for (final event in events) {
        if (event.applied) continue;
        final eventHandler = params.handlers[event.name];
        if (eventHandler == null) {
          return Left(CacheFailure(
              message:
                  'No handler was found for ${event.name}. This is likely a bug in the code generator.'));
        }
        final paramGenerator = params.dataGenerators[event.name];
        if (paramGenerator == null) {
          return Left(CacheFailure(
              message:
                  'Missing event params generator for ${event.name}. This is likely a problem with the generator.'));
        }

        try {
          final eventData = paramGenerator(event.data);
          // TODO: allow returning a failure from the event handler
          await eventHandler(event.streamId, event.pool, eventData);
          final failureOrApplied = await eventRepository.markApplied(event);
          if (failureOrApplied.isLeft()) {
            return failureOrApplied;
          }
        } catch (e, stack) {
          if (e is CacheException) {
            return Left(CacheFailure(message: e.message));
          } else {
            return Left(CacheFailure(message: '$e\n\n$stack'));
          }
        }
      }
      return const Right(null);
    });
  }
}

class ApplyEventsParams {
  final int pool;
  final Map<String, EventHandler> handlers;
  final Map<String, EventDataGenerator> dataGenerators;

  ApplyEventsParams({
    required this.handlers,
    required this.dataGenerators,
    required this.pool,
  });
}
