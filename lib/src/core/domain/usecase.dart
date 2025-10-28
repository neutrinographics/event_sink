import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';

/// [TReturn] is the return type of a successful use case call.
/// [TParams] are the parameters that are required to call the use case.
abstract class UseCase<TReturn, TParams> {
  Future<Either<Failure, TReturn>> call(TParams params);
}
