import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class SyncEvents extends UseCase<void, SyncEventsParams> {
  final EventRepository eventRepository;

  Failure? _lastPushFailure;

  SyncEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(SyncEventsParams params) async {
    // TODO: it would be good to check if we have a network connection first,
    // but using connectivity_plus breaks the generator because dart:ui cannot
    // be used on the platform.
    return await _recursiveRebase(
      dataSource: params.dataSource,
      authToken: params.authToken,
      allowedRetries: params.maxRetryCount,
      pool: params.pool,
    );
  }

  Future<Either<Failure, void>> _recursiveRebase({
    int retryCount = 0,
    required EventRemoteDataSource dataSource,
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
    final failureOrDownload = await eventRepository.fetch(
      dataSource,
      pool,
      authToken: authToken,
    );

    // rebase events
    final failureOrRebase = await failureOrDownload.fold(
      (l) async => Left(l),
      (_) => eventRepository.rebase(pool),
    );

    // push events
    final failureOrPush = await failureOrRebase.fold(
      (l) async => Left(l),
      (_) => eventRepository.push(dataSource, pool, authToken: authToken),
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
      dataSource: dataSource,
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
  // final Uri host;

  final EventRemoteDataSource dataSource;

  /// The authentication token used to authenticate requests to the remote [host].
  final String? authToken;

  const SyncEventsParams({
    int retryCount = 4,
    this.authToken,
    required this.pool,
    required this.dataSource,
  }) : maxRetryCount = retryCount;

  @override
  List<Object?> get props => [maxRetryCount, pool, dataSource, authToken];
}
