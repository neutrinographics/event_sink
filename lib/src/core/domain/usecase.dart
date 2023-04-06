import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';

/// [Type] is the return type of a successful use case call.
/// [Params] are the parameters that are required to call the use case.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
