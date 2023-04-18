import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/add_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_event_test.mocks.dart';

class MockEvent extends EventInfo<MockEventData> {
  const MockEvent({
    required super.streamId,
    required super.data,
    required super.name,
  });

  @override
  List<Object?> get props => [streamId, name, data];
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

  const tPool = 1;
  const tEvent = MockEvent(
    streamId: 'streamId',
    data: MockEventData(),
    name: 'name',
  );

  test(
    'should add an event',
    () async {
      // arrange
      when(mockEventRepository.add(any, any))
          .thenAnswer((_) async => const Right(null));
      // act
      final result =
          await useCase(const AddEventParams(event: tEvent, pool: tPool));
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.add(tEvent, tPool));
    },
  );
}
