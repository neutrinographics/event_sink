import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class GetEvent extends UseCase<EventModel, GetEventParams> {
  final EventRepository eventRepository;

  GetEvent({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, EventModel>> call(GetEventParams params) {
    return eventRepository.get(params.eventId);
  }
}

class GetEventParams extends Equatable {
  final String eventId;

  const GetEventParams({
    required this.eventId,
  });

  @override
  List<Object?> get props => [eventId];
}
