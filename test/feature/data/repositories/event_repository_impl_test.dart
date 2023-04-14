import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/repositories/event_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../test_utils.dart';
import 'event_repository_impl_test.mocks.dart';

class MockEvent extends EventInfo<MockEventData> {
  MockEvent({required String streamId, required MockEventData params})
      : super(
          streamId: streamId,
          name: 'add_member',
          data: params,
        );
}

class MockEventData implements EventData {
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

@GenerateMocks([
  EventRemoteDataSource,
  EventLocalDataSource,
  IdGenerator,
  TimeInfo,
])
void main() {
  late EventRepositoryImpl repository;
  late MockEventRemoteDataSource mockEventRemoteDataSource;
  late MockEventLocalDataSource mockEventLocalDataSource;
  late MockIdGenerator mockIdGenerator;
  late MockTimeInfo mockTimeInfo;

  setUp(() {
    mockEventRemoteDataSource = MockEventRemoteDataSource();
    mockEventLocalDataSource = MockEventLocalDataSource();
    mockIdGenerator = MockIdGenerator();
    mockTimeInfo = MockTimeInfo();
    repository = EventRepositoryImpl(
      localDataSource: mockEventLocalDataSource,
      remoteDataSource: mockEventRemoteDataSource,
      idGenerator: mockIdGenerator,
      timeInfo: mockTimeInfo,
    );
  });

  final tHost = Uri.parse('https://example.com');
  const tToken = 'token';

  group('fetch', () {
    const tEventId = 'event-id';
    const tPool = 1;
    final tToday = DateTime.now();

    final baseRemoteEvent =
        RemoteEventModel.fromJson(json.decode(fixture('remote_event.json')));
    final baseLocalEvent =
        EventModel.fromRemote(remoteEvent: baseRemoteEvent, pool: 1)
            .copyWith(remoteId: null, createdAt: tToday);
    final tSyncedLocalEvent =
        baseLocalEvent.copyWith(eventId: 'synced', remoteId: 1);
    final List<EventModel> tLocalEvents = [
      tSyncedLocalEvent,
      baseLocalEvent.copyWith(eventId: 'un-synced'),
      baseLocalEvent.copyWith(
          eventId: 'synced', remoteId: 9, streamId: 'a-different-stream'),
    ];
    final List<RemoteEventModel> tRemoteEvents = [
      baseRemoteEvent.copyWith(id: 1, eventId: 'synced'),
      baseRemoteEvent.copyWith(id: 2, eventId: '2'),
    ];
    test(
      'should download events from the server',
      () async {
        // arrange
        when(mockEventRemoteDataSource.getEvents(
                host: anyNamed('host'), token: anyNamed('token')))
            .thenAnswer((_) async => tRemoteEvents);
        when(mockEventLocalDataSource.hasEvent('synced'))
            .thenAnswer((_) async => true);
        when(mockEventLocalDataSource.hasEvent('2'))
            .thenAnswer((_) async => false);
        when(mockTimeInfo.now()).thenReturn(tToday);
        when(mockEventLocalDataSource.getEvent('synced'))
            .thenAnswer((_) async => tSyncedLocalEvent);
        // act
        final result = await repository.fetch(tHost, tPool, authToken: tToken);
        // assert
        verify(mockEventRemoteDataSource.getEvents(
            host: anyNamed('host'), token: anyNamed('token')));
        // should only cache the new event
        final expectedNewEvent = baseLocalEvent.copyWith(
          eventId: '2',
          remoteId: 2,
        );
        verify(mockEventLocalDataSource.addEvent(expectedNewEvent));
        verify(mockEventLocalDataSource.hasEvent(any));
        verify(mockEventLocalDataSource.getEvent('synced'));
        verifyNoMoreInteractions(mockEventLocalDataSource);
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the events cannot be stored',
      () async {
        // arrange
        when(mockEventRemoteDataSource.getEvents(
                host: anyNamed('host'), token: anyNamed('token')))
            .thenAnswer((_) async => tRemoteEvents);
        when(mockEventLocalDataSource.hasEvent(any))
            .thenAnswer((_) async => false);
        when(mockTimeInfo.now()).thenReturn(tToday);
        when(mockEventLocalDataSource.addEvent(any))
            .thenThrow(CacheException());

        // act
        final result = await repository.fetch(tHost, tPool, authToken: tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      'should return ServerFailure if the download fails',
      () async {
        // arrange
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tLocalEvents);
        when(mockEventRemoteDataSource.getEvents(
                host: anyNamed('host'), token: anyNamed('token')))
            .thenThrow(ServerException());
        // act
        final result = await repository.fetch(tHost, tPool, authToken: tToken);
        // assert
        expect(result, equals(const Left(ServerFailure())));
        verify(mockEventRemoteDataSource.getEvents(host: tHost, token: tToken));
      },
    );
  });

  group('push', () {
    const tPool = 1;
    final tTime = DateTime.now();
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')))
        .copyWith(createdAt: tTime);
    final List<EventModel> tCachedEvents = [
      baseEvent,
      baseEvent.copyWith(remoteId: 1, streamId: "synced-stream"),
    ];
    final List<RemoteEventModel> tRemoteEvents = [
      RemoteEventModel(
        id: 2,
        eventId: 'event-id',
        streamId: baseEvent.streamId,
        version: baseEvent.version,
        name: baseEvent.name,
        data: baseEvent.data,
      ),
    ];

    test(
      'should upload events to the server',
      () async {
        // arrange
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEvents);
        final remoteEvents = [...tRemoteEvents];
        when(mockEventRemoteDataSource.createEvent(any,
                token: anyNamed('token'), host: anyNamed('host')))
            .thenAnswer((_) async => remoteEvents.removeAt(0));
        // act
        final result = await repository.push(tHost, tPool, authToken: tToken);
        // assert
        for (var e in tCachedEvents) {
          if (e.synced == true) {
            verifyNever(mockEventRemoteDataSource.createEvent(
              e.toNewRemote(),
              host: tHost,
              token: tToken,
            ));
          } else {
            verify(mockEventRemoteDataSource.createEvent(
              e.toNewRemote(),
              host: tHost,
              token: tToken,
            ));
          }
        }
        // verify events were updated with their remote id
        verify(mockEventLocalDataSource.addEvent(baseEvent.copyWith(
          remoteId: 2,
        )));
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the events cannot be read from the cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.push(tHost, tPool, authToken: tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return ServerFailure if the upload fails',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEvents);
        when(mockEventRemoteDataSource.createEvent(any,
                host: anyNamed('host'), token: anyNamed('token')))
            .thenThrow(ServerException());
        // act
        final result = await repository.push(tHost, tPool, authToken: tToken);
        // assert
        expect(result, equals(const Left(ServerFailure())));
      },
    );

    test(
      'should return CacheFailure if the synced events cannot be cached',
      () async {
        // arrange
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEvents);
        final remoteEvents = [...tRemoteEvents];
        when(mockEventRemoteDataSource.createEvent(any,
                token: anyNamed('token'), host: anyNamed('host')))
            .thenAnswer((_) async => remoteEvents.removeAt(0));
        when(mockEventLocalDataSource.addEvent(any))
            .thenThrow(CacheException());

        // act
        final result = await repository.push(tHost, tPool, authToken: tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return OutOfSyncFailure if the server has newer events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEvents);
        when(mockEventRemoteDataSource.createEvent(any,
                host: anyNamed('host'), token: anyNamed('token')))
            .thenThrow(OutOfSyncException());
        // act
        final result = await repository.push(tHost, tPool, authToken: tToken);
        // assert
        expect(result, equals(const Left(OutOfSyncFailure())));
      },
    );
  });

  group('rebase', () {
    const tPool = 1;
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')));
    final List<EventModel> tCachedEventsFirst = [
      // un-synced events
      baseEvent.copyWith(streamId: 'first', version: 1, eventId: '1.4'),
      baseEvent.copyWith(streamId: 'first', version: 2, eventId: '1.5'),
      baseEvent.copyWith(streamId: 'first', version: 3, eventId: '1.6'),

      // synced events
      baseEvent.copyWith(
          streamId: 'first', remoteId: 11, version: 1, eventId: '1.1'),
      baseEvent.copyWith(
          streamId: 'first', remoteId: 12, version: 2, eventId: '1.2'),
      baseEvent.copyWith(
          streamId: 'first', remoteId: 13, version: 3, eventId: '1.3'),
    ];
    tCachedEventsFirst.sort((a, b) => a.version - b.version);

    final List<EventModel> tCachedEventsSecond = [
      // un-synced events
      baseEvent.copyWith(streamId: 'second', version: 1, eventId: '2.4'),
      baseEvent.copyWith(streamId: 'second', version: 2, eventId: '2.5'),
      baseEvent.copyWith(streamId: 'second', version: 3, eventId: '2.6'),

      // synced events
      baseEvent.copyWith(
          streamId: 'second', remoteId: 21, version: 1, eventId: '2.1'),
      baseEvent.copyWith(
          streamId: 'second', remoteId: 22, version: 2, eventId: '2.2'),
      baseEvent.copyWith(
          streamId: 'second', remoteId: 23, version: 3, eventId: '2.3'),
    ];
    tCachedEventsSecond.sort((a, b) => a.version - b.version);

    void verifyEvent(EventModel e) =>
        verify(mockEventLocalDataSource.addEvent(e));

    test(
      'should rebase events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEventsFirst);
        // act
        final result = await repository.rebase(tPool);
        // assert
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 4, eventId: '1.4'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 5, eventId: '1.5'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 6, eventId: '1.6'));
        verifyNoMoreInteractions(mockEventLocalDataSource);
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should take stream id into consideration while rebasing',
      () async {
        // arrange
        final combinedEvents = tCachedEventsFirst + tCachedEventsSecond;
        combinedEvents.sort((a, b) => a.version - b.version);
        when(mockEventLocalDataSource.getPooledEvents(any)).thenAnswer(
          (_) async => combinedEvents,
        );
        // act
        final result = await repository.rebase(tPool);
        // assert
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 4, eventId: '1.4'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 5, eventId: '1.5'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 6, eventId: '1.6'));

        verifyEvent(
            baseEvent.copyWith(streamId: 'second', version: 4, eventId: '2.4'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'second', version: 5, eventId: '2.5'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'second', version: 6, eventId: '2.6'));

        expect(result, equals(const Right(null)));
      },
    );

    test(
      "should skip rebasing event if the event's streamId doesn't have any "
      "synced event",
      () async {
        // arrange
        final combinedEvents = [
          baseEvent.copyWith(
            streamId: 'third',
            version: 32,
          )
        ];
        when(mockEventLocalDataSource.getPooledEvents(any)).thenAnswer(
          (_) async => combinedEvents,
        );
        // act
        final result = await repository.rebase(tPool);
        // assert
        verifyNever(mockEventLocalDataSource
            .addEvent(combinedEvents.first.copyWith(version: 33)));
        expect(result, equals(const Right(null)));
      },
    );

    test(
      "should skip rebasing event if the event's streamId doesn't have any "
      "un-synced event",
      () async {
        // arrange
        final syncedEvents = [
          baseEvent.copyWith(
            version: 32,
            remoteId: 1,
          )
        ];
        when(mockEventLocalDataSource.getPooledEvents(any)).thenAnswer(
          (_) async => syncedEvents,
        );
        // act
        final result = await repository.rebase(tPool);
        // assert
        verifyNever(mockEventLocalDataSource
            .addEvent(syncedEvents.first.copyWith(version: 33)));
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the events cannot be loaded from cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.rebase(tPool);
        // assert
        verify(mockEventLocalDataSource.getPooledEvents(any));
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return CacheFailure if the events cannot be saved to cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEventsFirst);
        when(mockEventLocalDataSource.addEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.rebase(tPool);
        // assert
        verify(mockEventLocalDataSource.getPooledEvents(any));
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );
  });

  group('add', () {
    const tEventId = 'eventId';
    const tPool = 1;
    final tTime = DateTime.now();
    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: 'first',
      createdAt: tTime,
      pool: tPool,
      version: 1,
      name: "add_member",
      data: {},
    );

    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')));

    final tEvents = [
      baseEvent.copyWith(streamId: 'first', version: 1),
      baseEvent.copyWith(streamId: 'first', version: 2),
      baseEvent.copyWith(streamId: 'second', version: 1),
      baseEvent.copyWith(streamId: 'second', version: 2),
      baseEvent.copyWith(streamId: 'second', version: 3),
    ];

    test(
      "Should cache new event model from the event",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => []);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        // act
        final result = await repository.add(event, tPool);

        // assert
        expect(result, equals(const Right(null)));
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verify(mockEventLocalDataSource.addEvent(tEventModel));
      },
    );

    test(
      "Should use highest version if available",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tEvents);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        // act
        final result = await repository.add(event, tPool);

        // assert
        expect(result, equals(const Right(null)));
        verify(mockEventLocalDataSource.getPooledEvents(any));
        final newEvent = tEventModel.copyWith(version: 3);
        verify(mockEventLocalDataSource.addEvent(newEvent));
      },
    );

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.add(event, tPool);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verifyNever(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      "Should return CacheFailure if event cannot be saved in cache",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tEvents);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.addEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.add(event, tPool);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verify(mockEventLocalDataSource.addEvent(any));
      },
    );
  });

  group('list', () {
    const int tPool = 1;
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')));

    final tEvents = [
      baseEvent.copyWith(streamId: 'first', version: 8),
      baseEvent.copyWith(streamId: 'first', version: 9),
      baseEvent.copyWith(streamId: 'first', version: 10),
      baseEvent.copyWith(streamId: 'first', version: 11, applied: true),
    ];

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(tPool))
            .thenThrow(CacheException());
        // act
        final result = await repository.list(tPool);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verifyNever(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      'Should return a list of events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(tPool))
            .thenAnswer((_) async => tEvents);
        // act
        final result = await repository.list(tPool);
        // assert
        expectEitherEqualsList(
            result, tEvents.map((e) => e.toDomain()).toList());
        verify(mockEventLocalDataSource.getPooledEvents(any));
      },
    );
  });

  group('markReduced', () {
    final tEventModel = EventModel.fromJson(json.decode(fixture('event.json')))
        .copyWith(applied: false);
    final tEvent = tEventModel.toDomain();

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        when(mockEventLocalDataSource.getEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.markApplied(tEvent);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getEvent(any));
        verifyNever(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      'Should mark an event as reduced',
      () async {
        // arrange
        when(mockEventLocalDataSource.getEvent(any))
            .thenAnswer((_) async => tEventModel);
        // act
        final result = await repository.markApplied(tEvent);
        // assert
        expect(result, equals(const Right(null)));
        final expectedEventModel = tEventModel.copyWith(applied: true);
        verify(mockEventLocalDataSource.addEvent(expectedEventModel));
      },
    );

    test(
      "Should return CacheFailure if events cannot be marked as reduced",
      () async {
        // arrange
        when(mockEventLocalDataSource.getEvent(any))
            .thenAnswer((_) async => tEventModel);
        when(mockEventLocalDataSource.addEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.markApplied(tEvent);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.addEvent(any));
      },
    );
  });

  group('clearCache', () {
    test(
      'should clear cache',
      () async {
        // arrange
        // act
        final result = await repository.clearCache();
        // assert
        expect(result, const Right(null));
        verify(mockEventLocalDataSource.clear());
        verifyNoMoreInteractions(mockEventLocalDataSource);
      },
    );

    test(
      'should return CacheFailure if clearing cache fails',
      () async {
        // arrange
        when(mockEventLocalDataSource.clear()).thenThrow(CacheException());
        // act
        final result = await repository.clearCache();
        // assert
        expect(result, const Left(CacheFailure()));
        verify(mockEventLocalDataSource.clear());
        verifyNoMoreInteractions(mockEventLocalDataSource);
      },
    );
  });
}
