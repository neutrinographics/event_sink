import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/error/failure.dart';

/// [T] is the argument type passed into the command.
abstract class Command<T> {
  Future<Either<Failure, void>> call(String streamId, T params);
}
