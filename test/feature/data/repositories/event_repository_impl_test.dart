import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/core/data/id_generator.dart';
import 'package:event_sync/src/core/domain/config_options.dart';
import 'package:event_sync/src/core/error/exception.dart';
import 'package:event_sync/src/core/error/failure.dart';
import 'package:event_sync/src/core/time/time_info.dart';
import 'package:event_sync/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sync/src/feature/data/local/models/config_model.dart';
import 'package:event_sync/src/feature/data/local/models/event_model.dart';
import 'package:event_sync/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sync/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sync/src/feature/data/repositories/event_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../test_utils.dart';
import 'event_repository_impl_test.mocks.dart';

class MockEvent extends EventInfo<MockEventParams> {
  MockEvent({required String streamId, required MockEventParams params})
      : super(
          streamId: streamId,
          name: 'add_member',
          data: params,
        );
}

class MockEventParams implements EventParams {
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

  const tHost = 'https://example.com';
  const tToken = 'token';
  const tHostConfig =
      ConfigModel.string(option: ConfigOption.serverHost, value: tHost);
  const tTokenConfig =
      ConfigModel.string(option: ConfigOption.authToken, value: tToken);

  group('fetch', () {
    const tEventId = 'event-id';
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final tToday = DateTime.now();

    final baseRemoteEvent =
        RemoteEventModel.fromJson(json.decode(fixture('remote_event.json')));
    final baseLocalEvent =
        EventModel.fromRemote(remoteEvent: baseRemoteEvent, id: 'id')
            .copyWith(remoteId: null, remoteCreatedAt: null, createdAt: tToday);
    final List<EventModel> tLocalEvents = [
      baseLocalEvent.copyWith(
          id: 'synced', remoteId: 1, remoteCreatedAt: yesterday),
      baseLocalEvent.copyWith(id: 'un-synced'),
      baseLocalEvent.copyWith(
          id: 'synced',
          remoteId: 9,
          remoteCreatedAt: yesterday,
          streamId: 'a-different-stream'),
    ];
    final List<RemoteEventModel> tRemoteEvents = [
      baseRemoteEvent.copyWith(id: 1, createdAt: yesterday),
      baseRemoteEvent.copyWith(id: 2, createdAt: tToday),
    ];
    test(
      'should download events from the server',
      () async {
        // arrange
        when(mockTimeInfo.now()).thenReturn(tToday);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tLocalEvents);
        when(mockEventRemoteDataSource.getEvents(
                host: anyNamed('host'), token: anyNamed('token')))
            .thenAnswer((_) async => tRemoteEvents);
        // act
        final result = await repository.fetch(tHost, tToken);
        // assert
        verify(mockEventLocalDataSource.getAllEvents());
        verify(mockEventRemoteDataSource.getEvents(
            host: Uri.parse(tHostConfig.value.toString()),
            token: tTokenConfig.value.toString()));
        // should only cache the new event
        final expectedNewEvent = baseLocalEvent.copyWith(
            id: tEventId, remoteId: 2, remoteCreatedAt: tToday);
        verify(mockEventLocalDataSource.cacheEvent(expectedNewEvent));
        verifyNoMoreInteractions(mockEventLocalDataSource);
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if local events cannot be read',
      () async {
        // arrange
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getAllEvents())
            .thenThrow(CacheException());
        // act
        final result = await repository.fetch(tHost, tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return CacheFailure if the events cannot be stored',
      () async {
        // arrange
        when(mockTimeInfo.now()).thenReturn(tToday);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tLocalEvents);
        when(mockEventRemoteDataSource.getEvents(
                host: anyNamed('host'), token: anyNamed('token')))
            .thenAnswer((_) async => tRemoteEvents);
        when(mockEventLocalDataSource.cacheEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.fetch(tHost, tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.cacheEvent(any));
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
        final result = await repository.fetch(tHost, tToken);
        // assert
        expect(result, equals(const Left(ServerFailure())));
        verify(mockEventRemoteDataSource.getEvents(
            host: Uri.parse(tHost), token: tToken));
      },
    );
  });

  group('push', () {
    final tTime = DateTime.now();
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')))
        .copyWith(createdAt: tTime);
    final List<EventModel> tCachedEvents = [
      baseEvent,
      baseEvent.copyWith(remoteId: 1, streamId: "synced-stream"),
    ];
    final List<RemoteEventModel> tRemoteEvents = [
      // second graph
      baseEvent.toRemote().copyWith(id: 3),
    ];

    test(
      'should upload events to the server',
      () async {
        // arrange
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tCachedEvents);
        final remoteEvents = [...tRemoteEvents];
        when(mockEventRemoteDataSource.createEvent(any,
                token: anyNamed('token'), host: anyNamed('host')))
            .thenAnswer((_) async => remoteEvents.removeAt(0));
        // act
        final result = await repository.push(tHost, tToken);
        // assert
        verify(mockEventLocalDataSource.getAllEvents());
        for (var e in tCachedEvents) {
          if (e.synced == true) {
            verifyNever(mockEventRemoteDataSource.createEvent(
              e.toRemote(),
              host: Uri.parse(tHost),
              token: tToken,
            ));
          } else {
            verify(mockEventRemoteDataSource.createEvent(
              e.toRemote(),
              host: Uri.parse(tHost),
              token: tToken,
            ));
          }
        }
        // verify events were updated with their remote id
        verify(mockEventLocalDataSource
            .cacheEvent(baseEvent.copyWith(remoteId: 3)));
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the events cannot be read from the cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenThrow(CacheException());
        // act
        final result = await repository.push(tHost, tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return ServerFailure if the upload fails',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tCachedEvents);
        when(mockEventRemoteDataSource.createEvent(any,
                host: anyNamed('host'), token: anyNamed('token')))
            .thenThrow(ServerException());
        // act
        final result = await repository.push(tHost, tToken);
        // assert
        expect(result, equals(const Left(ServerFailure())));
      },
    );

    test(
      'should return CacheFailure if the synced events cannot be cached',
      () async {
        // arrange
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tCachedEvents);
        final remoteEvents = [...tRemoteEvents];
        when(mockEventRemoteDataSource.createEvent(any,
                token: anyNamed('token'), host: anyNamed('host')))
            .thenAnswer((_) async => remoteEvents.removeAt(0));
        when(mockEventLocalDataSource.cacheEvent(any))
            .thenThrow(CacheException());

        // act
        final result = await repository.push(tHost, tToken);
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return OutOfSyncFailure if the server has newer events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tCachedEvents);
        when(mockEventRemoteDataSource.createEvent(any,
                host: anyNamed('host'), token: anyNamed('token')))
            .thenThrow(OutOfSyncException());
        // act
        final result = await repository.push(tHost, tToken);
        // assert
        expect(result, equals(const Left(OutOfSyncFailure())));
      },
    );
  });

  group('rebase', () {
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')));
    final List<EventModel> tCachedEventsFirst = [
      // un-synced events
      baseEvent.copyWith(streamId: 'first', version: 1, id: '1.4'),
      baseEvent.copyWith(streamId: 'first', version: 2, id: '1.5'),
      baseEvent.copyWith(streamId: 'first', version: 3, id: '1.6'),

      // synced events
      baseEvent.copyWith(
          streamId: 'first', remoteId: 11, version: 1, id: '1.1'),
      baseEvent.copyWith(
          streamId: 'first', remoteId: 12, version: 2, id: '1.2'),
      baseEvent.copyWith(
          streamId: 'first', remoteId: 13, version: 3, id: '1.3'),
    ];
    tCachedEventsFirst.sort((a, b) => a.version - b.version);

    final List<EventModel> tCachedEventsSecond = [
      // un-synced events
      baseEvent.copyWith(streamId: 'second', version: 1, id: '2.4'),
      baseEvent.copyWith(streamId: 'second', version: 2, id: '2.5'),
      baseEvent.copyWith(streamId: 'second', version: 3, id: '2.6'),

      // synced events
      baseEvent.copyWith(
          streamId: 'second', remoteId: 21, version: 1, id: '2.1'),
      baseEvent.copyWith(
          streamId: 'second', remoteId: 22, version: 2, id: '2.2'),
      baseEvent.copyWith(
          streamId: 'second', remoteId: 23, version: 3, id: '2.3'),
    ];
    tCachedEventsSecond.sort((a, b) => a.version - b.version);

    void verifyEvent(EventModel e) =>
        verify(mockEventLocalDataSource.cacheEvent(e));

    test(
      'should rebase events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tCachedEventsFirst);
        // act
        final result = await repository.rebase();
        // assert
        verify(mockEventLocalDataSource.getAllEvents());
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 4, id: '1.4'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 5, id: '1.5'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 6, id: '1.6'));
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
        when(mockEventLocalDataSource.getAllEvents()).thenAnswer(
          (_) async => combinedEvents,
        );
        // act
        final result = await repository.rebase();
        // assert
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 4, id: '1.4'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 5, id: '1.5'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'first', version: 6, id: '1.6'));

        verifyEvent(
            baseEvent.copyWith(streamId: 'second', version: 4, id: '2.4'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'second', version: 5, id: '2.5'));
        verifyEvent(
            baseEvent.copyWith(streamId: 'second', version: 6, id: '2.6'));

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
        when(mockEventLocalDataSource.getAllEvents()).thenAnswer(
          (_) async => combinedEvents,
        );
        // act
        final result = await repository.rebase();
        // assert
        verifyNever(mockEventLocalDataSource
            .cacheEvent(combinedEvents.first.copyWith(version: 33)));
        expect(result, equals(const Right(null)));
      },
    );

    test(
      "should skip rebasing event if the event's streamId doesn't have any "
      "unsynced event",
      () async {
        // arrange
        final syncedEvents = [
          baseEvent.copyWith(
            version: 32,
            remoteId: 1,
          )
        ];
        when(mockEventLocalDataSource.getAllEvents()).thenAnswer(
          (_) async => syncedEvents,
        );
        // act
        final result = await repository.rebase();
        // assert
        verifyNever(mockEventLocalDataSource
            .cacheEvent(syncedEvents.first.copyWith(version: 33)));
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the events cannot be loaded from cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenThrow(CacheException());
        // act
        final result = await repository.rebase();
        // assert
        verify(mockEventLocalDataSource.getAllEvents());
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );

    test(
      'should return CacheFailure if the events cannot be saved to cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tCachedEventsFirst);
        when(mockEventLocalDataSource.cacheEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.rebase();
        // assert
        verify(mockEventLocalDataSource.getAllEvents());
        // assert
        expect(result, equals(const Left(CacheFailure())));
      },
    );
  });

  group('add', () {
    const tEventId = 'eventId';
    final tTime = DateTime.now();
    final tEventModel = EventModel(
      id: tEventId,
      streamId: 'first',
      createdAt: tTime,
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
          params: MockEventParams(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => []);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        // act
        final result = await repository.add(event);

        // assert
        expect(result, equals(const Right(null)));
        verify(mockEventLocalDataSource.getAllEvents());
        verify(mockEventLocalDataSource.cacheEvent(tEventModel));
      },
    );

    test(
      "Should use highest version if available",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventParams(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tEvents);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        // act
        final result = await repository.add(event);

        // assert
        expect(result, equals(const Right(null)));
        verify(mockEventLocalDataSource.getAllEvents());
        final newEvent = tEventModel.copyWith(version: 3);
        verify(mockEventLocalDataSource.cacheEvent(newEvent));
      },
    );

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventParams(),
          streamId: tEventModel.streamId,
        );
        when(mockEventLocalDataSource.getAllEvents())
            .thenThrow(CacheException());
        // act
        final result = await repository.add(event);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getAllEvents());
        verifyNever(mockEventLocalDataSource.cacheEvent(any));
      },
    );

    test(
      "Should return CacheFailure if event cannot be saved in cache",
      () async {
        // arrange
        final event = MockEvent(
          params: MockEventParams(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tEvents);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.cacheEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.add(event);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getAllEvents());
        verify(mockEventLocalDataSource.cacheEvent(any));
      },
    );
  });

  group('list', () {
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')));

    final tEvents = [
      baseEvent.copyWith(streamId: 'first', version: 8),
      baseEvent.copyWith(streamId: 'first', version: 9),
      baseEvent.copyWith(streamId: 'first', version: 10),
      baseEvent.copyWith(streamId: 'first', version: 11, merged: true),
    ];

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenThrow(CacheException());
        // act
        final result = await repository.list();

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getAllEvents());
        verifyNever(mockEventLocalDataSource.cacheEvent(any));
      },
    );

    test(
      'Should return a list of events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tEvents);
        // act
        final result = await repository.list();
        // assert
        expectEitherEqualsList(
            result, tEvents.map((e) => e.toDomain()).toList());
        verify(mockEventLocalDataSource.getAllEvents());
      },
    );
  });

  group('markReduced', () {
    final tEventModel = EventModel.fromJson(json.decode(fixture('event.json')))
        .copyWith(merged: false);
    final tEvent = tEventModel.toDomain();

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenThrow(CacheException());
        // act
        final result = await repository.markReduced(tEvent);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.getAllEvents());
        verifyNever(mockEventLocalDataSource.cacheEvent(any));
      },
    );

    test(
      'Should mark an event as reduced',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => [tEventModel]);
        // act
        final result = await repository.markReduced(tEvent);
        // assert
        expect(result, equals(const Right(null)));
        final expectedEventModel = tEventModel.copyWith(merged: true);
        verify(mockEventLocalDataSource.cacheEvent(expectedEventModel));
      },
    );

    test(
      "Should return CacheFailure if events cannot be marked as reduced",
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => [tEventModel]);
        when(mockEventLocalDataSource.cacheEvent(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.markReduced(tEvent);

        // assert
        expect(result, equals(const Left(CacheFailure())));
        verify(mockEventLocalDataSource.cacheEvent(any));
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
