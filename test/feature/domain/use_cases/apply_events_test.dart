import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/event_handler.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sink/src/feature/domain/use_cases/apply_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_events_test.mocks.dart';

class TestEventHandler implements EventHandler<TestEventData> {
  @override
  Future<void> call(String streamId, int pool, TestEventData data) async {}
}

class TestEventData extends Equatable implements EventData {
  final String hello;
  final Map<String, dynamic> fields;

  const TestEventData({
    required this.hello,
    this.fields = const {},
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'hello': hello,
    };
  }

  @override
  factory TestEventData.fromJson(Map<String, dynamic> json) {
    return TestEventData(hello: json['hello']);
  }

  @override
  List<Object?> get props => [];
}

@GenerateMocks([EventRepository, TestEventHandler])
void main() {
  late MockEventRepository mockEventRepository;
  MockTestEventHandler mockTestEventHandler = MockTestEventHandler();
  late ApplyEvents useCase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = ApplyEvents(eventRepository: mockEventRepository);
  });

  const tEventName = 'event';
  final tParams = ApplyEventsParams(
    handlers: {
      tEventName: mockTestEventHandler,
    },
    dataGenerators: {
      tEventName: (Map<String, dynamic> json) => TestEventData.fromJson(json),
    },
    pool: 1,
  );

  const tStream = 'stream';
  const tPool = 1;
  const Map<String, dynamic> tRawData = {
    'hello': 'world',
  };
  final tData = TestEventData.fromJson(tRawData);
  final tEvent = EventStub(
    eventId: 'eventId',
    streamId: tStream,
    name: tEventName,
    pool: tPool,
    version: 1,
    applied: false,
    data: tRawData,
  );
  final List<EventStub> tEvents = [
    tEvent,
    EventStub(
      eventId: 'eventId-merged',
      streamId: 'something',
      name: tEventName,
      pool: 1,
      version: 1,
      applied: true,
      data: {},
    )
  ];

  test(
    'should apply an event',
    () async {
      // arrange
      when(mockEventRepository.list(any))
          .thenAnswer((_) async => Right(tEvents));
      when(mockEventRepository.markAppliedList(any))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.markAppliedList([tEvent]));
      verify(mockTestEventHandler(tStream, tPool, tData));
      verifyNoMoreInteractions(mockTestEventHandler);
    },
  );

  test(
    'should return failure if event cannot be marked as applied',
    () async {
      // arrange
      when(mockEventRepository.list(any))
          .thenAnswer((_) async => Right(tEvents));
      when(mockEventRepository.markAppliedList(any))
          .thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockEventRepository.markAppliedList([tEvent]));
    },
  );

  test(
    'should return failure if the event handler raises and exception',
    () async {
      // arrange

      when(mockEventRepository.list(any))
          .thenAnswer((_) async => Right(tEvents));
      when(mockTestEventHandler(any, any, any)).thenThrow(Exception());
      // act
      final result = await useCase(tParams);
      // assert
      expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
      verify(mockTestEventHandler(tStream, tPool, tData));
      verifyNever(mockEventRepository.markApplied(tEvent));
    },
  );
}
