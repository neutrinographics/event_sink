import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class AddEvent extends UseCase<void, AddEventParams> {
  EventRepository eventRepository;

  AddEvent({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(AddEventParams params) {
    return eventRepository.add(params.event, params.pool);
  }
}

class AddEventParams extends Equatable {
  final EventInfo<EventData> event;
  final int pool;

  const AddEventParams({required this.event, required this.pool});

  @override
  List<Object?> get props => [event, pool];
}
