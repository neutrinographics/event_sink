import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/domain/usecase.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';

class SyncEvents extends UseCase<void, SyncEventsParams> {
  final EventRepository eventRepository;

  Failure? _lastPushFailure;

  SyncEvents({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, void>> call(SyncEventsParams params) async {
    return await _syncWithRetry(params);
  }

  Future<Either<Failure, void>> _syncWithRetry(
    SyncEventsParams params, {
    int retryCount = 0,
    int allowedRetries = 3,
  }) async {
    if (retryCount >= allowedRetries) {
      return Left(_lastPushFailure ?? const ServerFailure());
    }

    // TODO: can be simplified by Either.chain extension

    // download events
    final failureOrDownload = await eventRepository.fetch(
      remoteAdapterName: params.remoteAdapterName,
      pool: params.pool,
    );

    // rebase events
    final failureOrRebase = await failureOrDownload.fold(
      (l) async => Left(l),
      (_) => eventRepository.rebase(params.pool),
    );

    // push events
    final failureOrPush = await failureOrRebase.fold(
      (l) async => Left(l),
      (_) => eventRepository.push(
        remoteAdapterName: params.remoteAdapterName,
        pool: params.pool,
      ),
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

    return _syncWithRetry(
      params,
      retryCount: retryCount + 1,
      allowedRetries: allowedRetries,
    );
  }
}

class SyncEventsParams extends Equatable {
  /// Remote adapter name
  final String remoteAdapterName;

  /// The pool of events that will be synced
  final String pool;

  const SyncEventsParams({
    required this.remoteAdapterName,
    required this.pool,
  });

  @override
  List<Object?> get props => [remoteAdapterName, pool];
}
