import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/get_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'get_event_test.mocks.dart';

@GenerateMocks([
  EventRepository,
])
void main() {
  late MockEventRepository mockEventRepository;
  late GetEvent useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = GetEvent(eventRepository: mockEventRepository);
  });

  test('should get event from the repository', () async {
    // arrange
    final tEventModel = EventModel.fromJson(json.decode(fixture('event.json')));
    when(mockEventRepository.get(any))
        .thenAnswer((_) async => Right(tEventModel));
    // act
    final result = await useCase(GetEventParams(eventId: tEventModel.eventId));
    // assert
    expect(result, Right(tEventModel));
    verify(mockEventRepository.get(tEventModel.eventId));
  });
}
