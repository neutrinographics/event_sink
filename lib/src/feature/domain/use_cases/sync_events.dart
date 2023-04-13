import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/domain/repositories/config_repository.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class SyncEvents extends UseCase<void, SyncEventsParams> {
  EventRepository eventRepository;
  ConfigRepository configRepository;

  Failure? _lastPushFailure;

  SyncEvents({
    required this.eventRepository,
    required this.configRepository,
  });

  @override
  Future<Either<Failure, void>> call(SyncEventsParams params) async {
    final rebaseFailureOrSuccess = await _recursiveRebase(
      host: params.host,
      authToken: params.authToken,
      allowedRetries: params.maxRetryCount,
      pool: params.pool,
    );
    if (rebaseFailureOrSuccess.isLeft()) {
      return rebaseFailureOrSuccess;
    }
    return const Right(null);
  }

  Future<Either<Failure, void>> _recursiveRebase({
    int retryCount = 0,
    required Uri host,
    required String? authToken,
    required int allowedRetries,
    required int pool,
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

    // download events
    final failureOrDownload =
        await eventRepository.fetch(host, pool, authToken);

    // rebase events
    final failureOrRebase = await failureOrDownload.fold(
      (l) async => Left(l),
      (_) => eventRepository.rebase(pool),
    );

    // push events
    // TODO: push events from all pools
    final failureOrPush = await failureOrRebase.fold(
      (l) async => Left(l),
      (_) => eventRepository.push(host, pool, authToken),
    );

    // if push is successful then we can return
    if (failureOrPush.isRight()) {
      return failureOrPush;
    }

    // if push is failing because of errors other than OutOfSync,
    // then we can return
    late final Failure pushFailure;
    failureOrPush.fold((l) => pushFailure = l, (r) => null);
    if (pushFailure is! OutOfSyncFailure) {
      return failureOrPush;
    }
    _lastPushFailure = pushFailure;

    return _recursiveRebase(
      host: host,
      authToken: authToken,
      allowedRetries: allowedRetries,
      pool: pool,
      retryCount: retryCount + 1,
    );
  }
}

class SyncEventsParams extends Equatable {
  /// The maximum number of times to retry syncing before giving up.
  final int maxRetryCount;

  /// The pool of events that will be synced
  final int pool;

  /// The remote host where the pool of events will be synced.
  final Uri host;

  /// The authentication token used to authenticate requests to the remote [host].
  final String? authToken;

  const SyncEventsParams({
    int retryCount = 4,
    required this.authToken,
    required this.pool,
    required this.host,
  }) : maxRetryCount = retryCount;

  @override
  List<Object?> get props => [maxRetryCount, pool, host, authToken];
}
