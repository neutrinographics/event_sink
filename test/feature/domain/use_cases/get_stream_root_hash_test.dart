import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/get_stream_root_hash.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_stream_root_hash_test.mocks.dart';

@GenerateMocks([
  EventRepository,
])
void main() {
  late MockEventRepository mockEventRepository;
  late GetStreamRootHash useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = GetStreamRootHash(
      eventRepository: mockEventRepository,
    );
  });

  test(
    'Should return a stream root hash',
    () async {
      // arrange
      const tHash = 'hash';
      const tPool = '1';
      const tStreamId = '1';
      const tParams = GetStreamRootHashParams(pool: tPool, streamId: tStreamId);
      when(mockEventRepository.getStreamRootHash(any, any))
          .thenAnswer((_) async => const Right(tHash));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right<Failure, String>(tHash));
      verify(mockEventRepository.getStreamRootHash(tPool, tStreamId));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );
}
