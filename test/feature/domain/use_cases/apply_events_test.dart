import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
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

  const TestEventData({required this.hello});

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
    merged: false,
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
      merged: true,
      data: {},
    )
  ];

  test(
    'should apply an event',
    () async {
      // arrange
      when(mockEventRepository.list(any))
          .thenAnswer((_) async => Right(tEvents));
      when(mockEventRepository.markApplied(any))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Right(null));
      verify(mockEventRepository.markApplied(tEvent));
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
      when(mockEventRepository.markApplied(any))
          .thenAnswer((_) async => const Left(CacheFailure()));
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockEventRepository.markApplied(tEvent));
    },
  );

  test(
    'should return failure if the event handler raises and exception',
    () async {
      // arrange

      when(mockEventRepository.list(any))
          .thenAnswer((_) async => Right(tEvents));
      when(mockTestEventHandler(any, any, any)).thenThrow(CacheException());
      // act
      final result = await useCase(tParams);
      // assert
      expect(result, const Left(CacheFailure()));
      verify(mockTestEventHandler(tStream, tPool, tData));
      verifyNever(mockEventRepository.markApplied(tEvent));
    },
  );
}
