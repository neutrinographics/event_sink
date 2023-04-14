import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/core/network/network_info.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/sync_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils.dart';
import 'sync_events_test.mocks.dart';

@GenerateMocks([EventRepository, NetworkInfo])
void main() {
  late MockEventRepository mockEventRepository;
  late MockNetworkInfo mockNetworkInfo;
  late SyncEvents useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = SyncEvents(
      eventRepository: mockEventRepository,
    );
  });

  const tPool = 1;
  final tHost = Uri.parse('https://google.com');
  final tParams = SyncEventsParams(
    host: tHost,
    pool: tPool,
  );

  test(
    'should sync the events',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.push(tHost, tPool));
      verify(mockNetworkInfo.isConnected());
    },
  );

  test(
    'should not sync the events if the device is offline',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockNetworkInfo.isConnected());
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when the fetch fails with ServerFailure',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(ServerFailure()));
      verify(mockEventRepository.fetch(tHost, tPool));
      verify(mockNetworkInfo.isConnected());
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when the fetch fails with CacheFailure',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockEventRepository.fetch(tHost, tPool));
      verify(mockNetworkInfo.isConnected());
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when the rebase fails with CacheFailure',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockEventRepository.fetch(tHost, tPool));
      verify(mockEventRepository.rebase(tPool));
      verify(mockNetworkInfo.isConnected());
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'should return failure when push fails with ServerFailure',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(tHost, tPool))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(ServerFailure()));
      verify(mockNetworkInfo.isConnected());
    },
  );

  test(
    'should return failure when push fails with CacheException',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(tHost, tPool))
          .thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockNetworkInfo.isConnected());
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
      when(mockEventRepository.push(tHost, tPool)).thenAnswer(
        (_) async => resultList[pushCallCount++],
      );
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.fetch(tHost, tPool)).called(2);
      verify(mockEventRepository.rebase(tPool)).called(2);
      verify(mockEventRepository.push(tHost, tPool)).called(2);
      verify(mockNetworkInfo.isConnected());
    },
  );

  test(
    'should return ServerFailure after max retries',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      when(mockEventRepository.fetch(tHost, tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.rebase(tPool))
          .thenAnswer((_) async => const Right(null));
      when(mockEventRepository.push(tHost, tPool))
          .thenAnswer((_) async => const Left(OutOfSyncFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expectFailure<ServerFailure>(result);
      verify(mockEventRepository.push(tHost, tPool))
          .called(tParams.maxRetryCount);
      verify(mockEventRepository.fetch(tHost, tPool))
          .called(tParams.maxRetryCount);
      verify(mockEventRepository.rebase(tPool)).called(tParams.maxRetryCount);
      verify(mockNetworkInfo.isConnected());
    },
  );
}
