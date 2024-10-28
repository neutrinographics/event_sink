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
    return await _recursiveRebase(
      remoteAdapter: params.remoteAdapter,
      pool: params.pool,
    );
  }

  Future<Either<Failure, void>> _recursiveRebase({
    required EventRemoteAdapter remoteAdapter,
    required String pool,
  }) async {
    // TODO: to be implemented with CU-868abtufj task in ClickUp
    throw UnimplementedError();
  }
}

class SyncEventsParams extends Equatable {
  /// Remote adapter instance
  final EventRemoteAdapter remoteAdapter;

  /// The pool of events that will be synced
  final String pool;

  const SyncEventsParams({
    required this.remoteAdapter,
    required this.pool,
  });

  @override
  List<Object?> get props => [remoteAdapter, pool];
}
