import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/list_stream_hashes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'list_events_test.mocks.dart';

@GenerateMocks([
  EventRepository,
])
void main() {
  late MockEventRepository mockEventRepository;
  late ListStreamHashes useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = ListStreamHashes(
      eventRepository: mockEventRepository,
    );
  });

  test(
    'Should return a list of stream hashes',
    () async {
      // arrange
      const tPool = '1';
      const tStreamId = '1';
      const tParams = ListStreamHashesParams(pool: tPool, streamId: tStreamId);
      when(mockEventRepository.listStreamHashes(any, any))
          .thenAnswer((_) async => const Right([]));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right<Failure, List<StreamHash>>([]));
      verify(mockEventRepository.listStreamHashes(tPool, tStreamId));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );
}
