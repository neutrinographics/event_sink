import 'package:dartz/dartz.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/clear_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'clear_cache_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late ClearCache useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = ClearCache(
      eventRepository: mockEventRepository,
    );
  });

  test(
    'Should clear the cache for all pools',
    () async {
      // arrange
      const tParams = ClearCacheParams();
      when(mockEventRepository.clearCache())
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.clearCache());
      verifyNoMoreInteractions(mockEventRepository);
    },
  );

  test(
    'Should clear the cache for a single pool',
    () async {
      // arrange
      const tPool = 1;
      const tParams = ClearCacheParams(pool: tPool);
      when(mockEventRepository.clearPoolCache(tPool))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.clearPoolCache(tPool));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );
}
