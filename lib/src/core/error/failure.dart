import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({message = ''}) : super(message: message);
}

// Failure occurring when the server has new events
class OutOfSyncFailure extends ServerFailure {
  const OutOfSyncFailure({message = ''}) : super(message: message);
}

// Failure occurring in the cache layer
class CacheFailure extends Failure {
  const CacheFailure({message = ''}) : super(message: message);
}

// Failure occurring in the use case layer
class IllegalArgumentFailure extends Failure {
  const IllegalArgumentFailure({message = ''}) : super(message: message);
}

// Failure occurring when an event is not formed properly
class EventFormatFailure extends Failure {
  const EventFormatFailure({message = ''}) : super(message: message);
}

// Failure occurring when user enters wrong pin
class InvalidPinFailure extends Failure {
  const InvalidPinFailure({message = ''}) : super(message: message);
}

// Failure occurring when user enters invalid or expired password reset token
class PasswordResetFailure extends Failure {
  const PasswordResetFailure({message = ''}) : super(message: message);
}
