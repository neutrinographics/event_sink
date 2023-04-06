import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_event_test.mocks.dart';

class MockEvent extends EventInfo<MockEventData> {
  MockEvent(
      {required super.streamId, required super.data, required super.name});
}

class MockEventData implements EventData {
  const MockEventData();

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  factory MockEventData.fromJson(Map<String, dynamic> json) {
    return const MockEventData();
  }
}

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late AddEvent useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();

    useCase = AddEvent(eventRepository: mockEventRepository);
  });

  final tEvent = MockEvent(
    streamId: 'streamId',
    data: const MockEventData(),
    name: 'name',
  );

  test(
    'should add an event',
    () async {
      // arrange
      when(mockEventRepository.add(any))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(AddEventParams(event: tEvent));
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.add(tEvent));
    },
  );
}
