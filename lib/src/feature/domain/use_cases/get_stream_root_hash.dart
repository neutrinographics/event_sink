import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class GetStreamRootHash extends UseCase<String, GetStreamRootHashParams> {
  final EventRepository eventRepository;

  GetStreamRootHash({required this.eventRepository});

  @override
  Future<Either<Failure, String>> call(GetStreamRootHashParams params) {
    return eventRepository.getStreamRootHash(params.pool, params.streamId);
  }
}

class GetStreamRootHashParams extends Equatable {
  final String pool;
  final String streamId;

  const GetStreamRootHashParams({
    required this.pool,
    required this.streamId,
  });

  @override
  List<Object?> get props => [pool, streamId];
}
