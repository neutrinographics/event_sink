import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/error/failure.dart';

abstract class ConfigRepository {
  /// Writes a typed config value to the repository.
  Future<Either<Failure, void>> write<T>(ConfigOption option, T value);

  /// Reads a typed config value from the repository.
  /// This will return null if the value does not exist.
  Future<Either<Failure, T?>> read<T>(ConfigOption option);

  /// Returns the typed config value from the repository.
  /// This will return a failure if the value does not exist.
  Future<Either<Failure, T>> require<T>(ConfigOption option);

  Future<Either<Failure, void>> delete(ConfigOption option);

  /// Empties all of the configurations.
  Future<Either<Failure, void>> clear();
}
