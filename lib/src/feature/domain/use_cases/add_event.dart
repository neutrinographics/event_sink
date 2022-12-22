import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sync/src/core/domain/usecase.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/feature/domain/entities/event_info.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';

class AddEvent extends UseCase<void, AddEventParams> {
  EventRepository eventRepository;

  AddEvent({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(AddEventParams params) {
    return eventRepository.add(params.event);
  }
}

class AddEventParams extends Equatable {
  final EventInfo event;

  const AddEventParams({required this.event});

  @override
  List<Object?> get props => [event];
}
