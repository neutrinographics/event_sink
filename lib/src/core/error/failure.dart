import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message = ''});
}

// Failure occurring when the server has new events
class OutOfSyncFailure extends ServerFailure {
  const OutOfSyncFailure({super.message = ''});
}

// Failure occurring in the cache layer
class CacheFailure extends Failure {
  const CacheFailure({super.message = ''});
}
