import 'package:dartz/dartz.dart';
import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sync/src/feature/domain/use_cases/add_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_event_test.mocks.dart';

class MockEvent extends EventInfo<MockEventParams> {
  MockEvent(
      {required super.streamId, required super.data, required super.name});
}

class MockEventParams implements EventParams {
  const MockEventParams();

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  factory MockEventParams.fromJson(Map<String, dynamic> json) {
    return const MockEventParams();
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
    data: const MockEventParams(),
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