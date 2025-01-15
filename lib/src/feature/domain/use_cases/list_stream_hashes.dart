import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class ListStreamHashes
    extends UseCase<List<StreamHash>, ListStreamHashesParams> {
  final EventRepository eventRepository;

  ListStreamHashes({required this.eventRepository});

  @override
  Future<Either<Failure, List<StreamHash>>> call(
    ListStreamHashesParams params,
  ) {
    return eventRepository.listStreamHashes(params.pool, params.streamId);
  }
}

class ListStreamHashesParams extends Equatable {
  final String pool;
  final String streamId;

  const ListStreamHashesParams({
    required this.pool,
    required this.streamId,
  });

  @override
  List<Object?> get props => [pool, streamId];
}
