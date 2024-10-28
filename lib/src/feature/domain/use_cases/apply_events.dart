import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class ApplyEvents extends UseCase<void, ApplyEventsParams> {
  EventRepository eventRepository;

  ApplyEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(ApplyEventsParams params) async {
    final failureOrEvents = await eventRepository.list(params.pool);

    if (failureOrEvents.isLeft()) {
      return failureOrEvents;
    }

    List<EventStub> eventStubsToApply = [];

    final eventStubs = failureOrEvents.getOrElse(() => []);

    for (final event in eventStubs) {
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
        eventStubsToApply.add(event);
      } catch (e, stack) {
        return Left(CacheFailure(message: '$e\n\n$stack'));
      }
    }

    return eventRepository.markAppliedList(eventStubsToApply);
  }
}

class ApplyEventsParams {
  final String pool;
  final Map<String, EventHandler> handlers;
  final Map<String, EventDataGenerator> dataGenerators;

  ApplyEventsParams({
    required this.handlers,
    required this.dataGenerators,
    required this.pool,
  });
}
