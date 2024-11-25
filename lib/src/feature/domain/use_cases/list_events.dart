import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class ListEvents extends UseCase<List<EventStub>, ListEventsParams> {
  ListEvents({
    required this.eventRepository,
  });

  final EventRepository eventRepository;

  @override
  Future<Either<Failure, List<EventStub>>> call(ListEventsParams params) {
    return eventRepository.list(params.pool);
  }
}

class ListEventsParams extends Equatable {
  const ListEventsParams({
    required this.pool,
  });

  final String pool;

  @override
  List<Object?> get props => [pool];
}
