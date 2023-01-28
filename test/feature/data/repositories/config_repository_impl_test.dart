import 'package:dartz/dartz.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/error/exception.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/feature/data/local/data_sources/config_local_data_source.dart';
import 'package:event_sync/src/feature/data/local/models/config_model.dart';
import 'package:event_sync/src/feature/data/repositories/config_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './config_repository_impl_test.mocks.dart';

@GenerateMocks([ConfigLocalDataSource])
void main() {
  late ConfigRepositoryImpl repository;
  late MockConfigLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockConfigLocalDataSource();
    repository = ConfigRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  group('write', () {
    test(
      'should write a string config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = 'value';
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        const tExpectedConfig = ConfigModel.string(key: tKey, value: tValue);
        expect(result, const Right(null));
        verify(mockLocalDataSource.write(tExpectedConfig));
      },
    );

    test(
      'should write an int config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const int tValue = 1;
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        const tExpectedConfig = ConfigModel.int(key: tKey, value: tValue);
        expect(result, const Right(null));
        verify(mockLocalDataSource.write(tExpectedConfig));
      },
    );

    test(
      'should write a double config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const double tValue = 1.1;
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        const tExpectedConfig = ConfigModel.double(key: tKey, value: tValue);
        expect(result, const Right(null));
        verify(mockLocalDataSource.write(tExpectedConfig));
      },
    );

    test(
      'should write a bool config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const bool tValue = true;
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        const tExpectedConfig = ConfigModel.bool(key: tKey, value: tValue);
        expect(result, const Right(null));
        verify(mockLocalDataSource.write(tExpectedConfig));
      },
    );

    test(
      'should write a date config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        final tValue = DateTime.now();
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        final tExpectedConfig = ConfigModel.date(key: tKey, value: tValue);
        expect(result, const Right(null));
        verify(mockLocalDataSource.write(tExpectedConfig));
      },
    );

    test(
      'should return CacheFailure if the type is not supported',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const Object tValue = {'my': 'object'};
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        expect(
            result,
            const Left(
                CacheFailure(message: "Unsupported config type 'Object'")));
        verifyNever(mockLocalDataSource.write(any));
      },
    );

    test(
      'should return CacheFailure if the config cannot be written',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = 'value';
        when(mockLocalDataSource.write(any)).thenThrow(CacheException());
        // act
        final result = await repository.write(tKey, tValue);
        // assert
        expect(result, const Left(CacheFailure()));
        verify(mockLocalDataSource.write(any));
      },
    );
  });

  group('require', () {
    test(
      'should return a failure if the value does not exist',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        when(mockLocalDataSource.read(any)).thenThrow(CacheException());
        // act
        final result = await repository.require<String>(tKey);
        // assert
        expect(
            result,
            equals(Left(CacheFailure(
                message: "The config '$tKey' does not have a value."))));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    // TRICKY: we only need to test reading one type to make sure it's properly connected to the read code.
    test(
      'should return an int config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = 1;
        const tConfig = ConfigModel.int(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.require<int>(tKey);
        // assert
        expect(result, equals(const Right(tValue)));
        verify(mockLocalDataSource.read(tKey));
      },
    );
  });

  group('read', () {
    test(
      'should return a string config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = 'value';
        const tConfig = ConfigModel.string(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.read<String>(tKey);
        // assert
        expect(result, equals(const Right(tValue)));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    test(
      'should return a bool config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = true;
        const tConfig = ConfigModel.bool(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.read<bool>(tKey);
        // assert
        expect(result, equals(const Right(tValue)));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    test(
      'should return a double config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = 1.1;
        const tConfig = ConfigModel.double(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.read<double>(tKey);
        // assert
        expect(result, equals(const Right(tValue)));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    test(
      'should return an int config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = 1;
        const tConfig = ConfigModel.int(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.read<int>(tKey);
        // assert
        expect(result, equals(const Right(tValue)));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    test(
      'should return a date config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        final tValue = DateTime.now();
        final tConfig = ConfigModel.date(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.read<DateTime>(tKey);
        // assert
        expect(result, equals(Right(tValue)));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    test(
      'should return a null value if the type does not match',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        const tValue = true;
        const tConfig = ConfigModel.bool(key: tKey, value: tValue);
        when(mockLocalDataSource.read(any)).thenAnswer((_) async => tConfig);
        // act
        final result = await repository.read<String>(tKey);
        // assert
        expect(result, equals(const Right(null)));
        verify(mockLocalDataSource.read(tKey));
      },
    );

    test(
      'should return a null value if the config does not exist',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        when(mockLocalDataSource.read(any)).thenThrow(CacheException());
        // act
        final result = await repository.read<String>(tKey);
        // assert
        expect(result, equals(const Right(null)));
        verify(mockLocalDataSource.read(tKey));
      },
    );
  });

  group('clear', () {
    test(
      'should clear the data',
      () async {
        // arrange
        // act
        final result = await repository.clear();
        // assert
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the data cannot be cleared',
      () async {
        // arrange
        when(mockLocalDataSource.clear()).thenThrow(CacheException());
        // act
        final result = await repository.clear();
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );
  });

  group('delete', () {
    test(
      'should delete the config',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        // act
        final result = await repository.delete(tKey);
        // assert
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the config cannot be deleted',
      () async {
        // arrange
        const tKey = ConfigOption.serverHost;
        when(mockLocalDataSource.delete(any)).thenThrow(CacheException());
        // act
        final result = await repository.delete(tKey);
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );
  });
}
