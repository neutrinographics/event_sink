import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/domain/config_options.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/data/local/data_sources/config_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/config_model.dart';
import 'package:event_sink/src/feature/domain/repositories/config_repository.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  ConfigLocalDataSource localDataSource;

  ConfigRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, T?>> read<T>(ConfigOption option) async {
    ConfigModel model;
    try {
      model = await localDataSource.read(option);
    } on CacheException {
      return const Right(null);
    }
    switch (T) {
      case String:
        return Right(model.whenOrNull(string: (_, value) => value as T));
      case bool:
        return Right(model.whenOrNull(bool: (_, value) => value as T));
      case double:
        return Right(model.whenOrNull(double: (_, value) => value as T));
      case int:
        return Right(model.whenOrNull(int: (_, value) => value as T));
      case DateTime:
        return Right(model.whenOrNull(date: (_, value) => value as T));
      default:
        return Left(CacheFailure(message: "Unsupported config type '$T'"));
    }
  }

  @override
  Future<Either<Failure, void>> write<T>(ConfigOption option, T value) async {
    ConfigModel config;

    switch (T) {
      case String:
        config = ConfigModel.string(option: option, value: value as String);
        break;
      case bool:
        config = ConfigModel.bool(option: option, value: value as bool);
        break;
      case double:
        config = ConfigModel.double(option: option, value: value as double);
        break;
      case int:
        config = ConfigModel.int(option: option, value: value as int);
        break;
      case DateTime:
        config = ConfigModel.date(option: option, value: value as DateTime);
        break;
      default:
        return Left(CacheFailure(message: "Unsupported config type '$T'"));
    }
    try {
      await localDataSource.write(config);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clear() async {
    try {
      await localDataSource.clear();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, T>> require<T>(ConfigOption option) async {
    final failureOrValue = await read<T>(option);
    return failureOrValue.fold(
      (failure) => Left(failure),
      (value) {
        if (value == null) {
          return Left(CacheFailure(
              message: "The config '$option' does not have a value."));
        } else {
          return Right(value);
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> delete(ConfigOption option) async {
    try {
      await localDataSource.delete(option);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
