import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class ClearCache extends UseCase<void, ClearCacheParams> {
  final EventRepository eventRepository;

  ClearCache({required this.eventRepository});

  @override
  Future<Either<Failure, void>> call(ClearCacheParams params) {
    final pool = params.pool;
    if (pool != null) {
      return eventRepository.clearPoolCache(pool);
    } else {
      return eventRepository.clearCache();
    }
  }
}

class ClearCacheParams extends Equatable {
  /// Optionally specify which pool should be cleared, otherwise all pools will be cleared.
  final String? pool;

  const ClearCacheParams({this.pool});

  @override
  List<Object?> get props => [pool];
}
