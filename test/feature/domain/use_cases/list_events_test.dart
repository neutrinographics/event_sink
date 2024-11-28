import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/list_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'list_events_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late ListEvents useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = ListEvents(
      eventRepository: mockEventRepository,
    );
  });

  test(
    'Should list events for a pool',
    () async {
      // arrange
      const tPool = '1';
      const tParams = ListEventsParams(pool: tPool);
      const tEvents = <EventModel>[];
      when(mockEventRepository.listEvents(tPool))
          .thenAnswer((_) async => const Right(tEvents));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(tEvents));
      verify(mockEventRepository.listEvents(tPool));
      verifyNoMoreInteractions(mockEventRepository);
    },
  );
}
