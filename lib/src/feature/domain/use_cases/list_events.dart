import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class ListEvents extends UseCase<List<EventModel>, ListEventsParams> {
  ListEvents({
    required this.eventRepository,
  });

  final EventRepository eventRepository;

  @override
  Future<Either<Failure, List<EventModel>>> call(ListEventsParams params) {
    return eventRepository.listEvents(params.pool);
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
