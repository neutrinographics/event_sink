import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sync/src/core/domain/usecase.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';

class SyncEvents extends UseCase<void, SyncEventsParams> {
  EventRepository eventRepository;

  Failure? _lastPushFailure;

  SyncEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(SyncEventsParams params) async {
    final rebaseFailureOrSuccess = await _recursiveRebase(params.maxRetryCount);
    if (rebaseFailureOrSuccess.isLeft()) {
      return rebaseFailureOrSuccess;
    }
    return const Right(null);
  }

  Future<Either<Failure, void>> _recursiveRebase(
    int allowedRetries, {
    int retryCount = 0,
  }) async {
    if (retryCount >= allowedRetries) {
      // TRICKY: respond with the last push failure so we can report the proper error
      final failure = _lastPushFailure;
      if (failure != null) {
        return Left(failure);
      } else {
        return const Left(ServerFailure());
      }
    }
    final downloadFailureOrSuccess = await eventRepository.fetch();

    // if fetch fails then we can return
    if (downloadFailureOrSuccess.isLeft()) {
      return downloadFailureOrSuccess;
    }

    final rebaseFailureOrSuccess = await eventRepository.rebase();

    // if rebase fails then we can return
    if (rebaseFailureOrSuccess.isLeft()) {
      return rebaseFailureOrSuccess;
    }

    final pushFailureOrSuccess = await eventRepository.push();

    // if push is successful then we can return
    if (pushFailureOrSuccess.isRight()) {
      return pushFailureOrSuccess;
    }

    // if push is failing because of errors other than OutOfSync,
    // then we can return
    late final Failure pushFailure;
    pushFailureOrSuccess.fold((l) => pushFailure = l, (r) => null);
    if (pushFailure is! OutOfSyncFailure) {
      return pushFailureOrSuccess;
    }
    _lastPushFailure = pushFailure;

    return _recursiveRebase(allowedRetries, retryCount: retryCount + 1);
  }
}

class SyncEventsParams extends Equatable {
  final int maxRetryCount;

  const SyncEventsParams({
    int retryCount = 4,
  }) : maxRetryCount = retryCount;

  @override
  List<Object?> get props => [maxRetryCount];
}
