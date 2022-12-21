import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/error/failure.dart';

/// Defines the logic for processing an event locally.
/// [T] is the argument type passed into the command.
/// Subclasses must define a const constructor so that they can be used
/// in the annotation.
abstract class Command<T> {
  const Command();

  Future<Either<Failure, void>> call(String streamId, T params);
}
