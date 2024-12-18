import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils.dart';
import 'sync_events_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late SyncEvents useCase;

  late String tPool;
  late String tRemoteAdapterName;
  late SyncEventsParams tParams;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = SyncEvents(
      eventRepository: mockEventRepository,
    );

    tPool = '1';
    tRemoteAdapterName = 'test';
    tParams = SyncEventsParams(
      remoteAdapterName: tRemoteAdapterName,
      pool: tPool,
    );
  });

  test(
    'should sync the events',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      ));
    },
  );

  test(
    'should return failure when the fetch fails with ServerFailure',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(ServerFailure()));
      verify(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      ));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when the fetch fails with CacheFailure',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      ));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when the rebase fails with CacheFailure',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      ));
      verify(mockEventRepository.rebase(tPool));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when push fails with ServerFailure',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(ServerFailure()));
    },
  );

  test(
    'should return failure when push fails with CacheException',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
    },
  );

  test(
    'should retry when push fails with OutOfSyncFailure',
    () async {
      // arrange
      int pushCallCount = 0;

      final resultList = <Either<Failure, void>>[
        const Left(OutOfSyncFailure()),
        const Right(null),
      ];
      when(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer(
        (_) async => resultList[pushCallCount++],
      );
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).called(2);
      verify(mockEventRepository.rebase(tPool)).called(2);
      verify(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).called(2);
    },
  );

  test(
    'should return ServerFailure after max retries',
    () async {
      // arrange
      when(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      )).thenAnswer((_) async => const Left(OutOfSyncFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expectFailure<ServerFailure>(result);
      verify(mockEventRepository.push(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      ));
      verify(mockEventRepository.fetch(
        remoteAdapterName: tRemoteAdapterName,
        pool: tPool,
      ));
      verify(mockEventRepository.rebase(tPool));
    },
  );
}
