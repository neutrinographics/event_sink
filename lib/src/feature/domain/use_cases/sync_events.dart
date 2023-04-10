import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/domain/config_options.dart';
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
    // fetch the server config
    final failureOrConfig = await _getServerConfig();
    if (failureOrConfig.isLeft()) {
      return failureOrConfig;
    }
    late _ServerConfig config;
    failureOrConfig.fold((_) => null, (c) => config = c);

    // download events
    // TODO: download events from all pools
    int pool = 1;
    final failureOrDownload =
        await eventRepository.fetch(config.host, pool, config.token);

    // rebase events
    final failureOrRebase = await failureOrDownload.fold(
      (l) async => Left(l),
      (_) => eventRepository.rebase(),
    );

    // push events
    // TODO: push events from all pools
    final failureOrPush = await failureOrRebase.fold(
      (l) async => Left(l),
      (_) => eventRepository.push(config.host, pool, config.token),
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

    return _recursiveRebase(allowedRetries, retryCount: retryCount + 1);
  }

  /// Loads the server settings and combines them into a convenient object.
  Future<Either<Failure, _ServerConfig>> _getServerConfig() async {
    final failureOrHost =
        await configRepository.require<String>(ConfigOption.serverHost);

    return failureOrHost.fold(
      (l) => Left(l),
      (host) async {
        final failureOrToken = await configRepository.require<String>(
          ConfigOption.authToken,
        );
        return failureOrToken.fold(
          (l) => Left(l),
          (token) => Right(_ServerConfig(host: host, token: token)),
        );
      },
    );
  }
}

class _ServerConfig {
  final String host;
  final String token;

  _ServerConfig({required this.host, required this.token});
}

class SyncEventsParams extends Equatable {
  final int maxRetryCount;

  const SyncEventsParams({
    int retryCount = 4,
  }) : maxRetryCount = retryCount;

  @override
  List<Object?> get props => [maxRetryCount];
}
