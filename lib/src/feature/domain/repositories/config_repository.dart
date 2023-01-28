import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/error/failure.dart';

abstract class ConfigRepository {
  /// Writes a typed config value to the repository.
  Future<Either<Failure, void>> write<T>(ConfigOption key, T value);

  /// Reads a typed config value from the repository.
  /// This will return null if the value does not exist.
  Future<Either<Failure, T?>> read<T>(ConfigOption key);

  /// Returns the typed config value from the repository.
  /// This will return a failure if the value does not exist.
  Future<Either<Failure, T>> require<T>(ConfigOption key);

  Future<Either<Failure, void>> delete(ConfigOption key);

  /// Empties all of the configurations.
  Future<Either<Failure, void>> clear();
}
