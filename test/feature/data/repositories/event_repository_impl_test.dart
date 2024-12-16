import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_sink/src/core/data/event_resolver.dart';
import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:event_sink/src/core/hash_generator.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/event_data.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/repositories/event_repository_impl.dart';
import 'package:event_sink/src/feature/domain/entities/event_info.dart';
import 'package:event_sink/src/feature/extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../test_utils.dart';
import 'event_repository_impl_test.mocks.dart';

class MockEvent extends EventInfo<MockEventData> {
  const MockEvent({
    required super.streamId,
    required MockEventData super.data,
    super.name = 'add_member',
  });

  @override
  List<Object?> get props => [streamId, name, data];
}

class MockEventData implements EventData {
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

@GenerateMocks([
  EventRemoteAdapter,
  EventLocalDataSource,
  EventResolver,
  IdGenerator,
  HashGenerator,
  TimeInfo,
])
void main() {
  late EventRepositoryImpl repository;
  late MockEventResolver mockEventResolver;
  late MockEventRemoteAdapter mockEventRemoteAdapter;
  late MockEventLocalDataSource mockEventLocalDataSource;
  late MockIdGenerator mockIdGenerator;
  late MockHashGenerator mockHashGenerator;
  late MockTimeInfo mockTimeInfo;

  const String tFirstAdapter = 'first-adapter';
  const String tSecondAdapter = 'second-adapter';

  setUp(() {
    mockEventResolver = MockEventResolver();
    mockEventRemoteAdapter = MockEventRemoteAdapter();
    mockEventLocalDataSource = MockEventLocalDataSource();
    mockIdGenerator = MockIdGenerator();
    mockHashGenerator = MockHashGenerator();
    mockTimeInfo = MockTimeInfo();
    repository = EventRepositoryImpl(
      localDataSource: mockEventLocalDataSource,
      eventResolver: mockEventResolver,
      idGenerator: mockIdGenerator,
      hashGenerator: mockHashGenerator,
      timeInfo: mockTimeInfo,
      remoteAdapters: {
        tFirstAdapter: mockEventRemoteAdapter,
        tSecondAdapter: mockEventRemoteAdapter,
      },
    );

    when(mockHashGenerator.generateHash(any)).thenReturn('hash');
  });

  group('fetch', () {
    const tEventId = 'event-id';
    const tPool = '1';
    final tToday = DateTime.now();

    final baseRemoteEvent =
        RemoteEventModel.fromJson(json.decode(fixture('remote_event.json')));
    final baseLocalEvent = EventModel.fromRemote(
      remoteEvent: baseRemoteEvent,
      pool: '1',
      synced: {tFirstAdapter},
    ).copyWith(createdAt: tToday);
    final tSyncedLocalEvent = baseLocalEvent
        .copyWith(eventId: 'synced', order: 1, synced: [tFirstAdapter]);
    final List<EventModel> tLocalEvents = [
      tSyncedLocalEvent,
      baseLocalEvent.copyWith(eventId: 'un-synced'),
      baseLocalEvent.copyWith(
        eventId: 'another-synced',
        order: 9,
        synced: [tFirstAdapter],
        streamId: 'a-different-stream',
      ),
    ];
    final List<RemoteEventModel> tRemoteEvents = [
      baseRemoteEvent.copyWith(order: 1, eventId: 'synced'),
      baseRemoteEvent.copyWith(order: 2, eventId: 'un-synced'),
      baseRemoteEvent.copyWith(order: 3, eventId: 'another-synced'),
    ];

    test(
      'should download events from remote adapter',
      () async {
        // arrange
        when(mockEventRemoteAdapter.pull(any, any))
            .thenAnswer((_) async => tRemoteEvents);
        when(mockEventLocalDataSource.hasEvent(any))
            .thenAnswer((_) async => false);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tLocalEvents);
        when(mockTimeInfo.now()).thenReturn(tToday);
        // act
        final result = await repository.fetch(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        verify(mockEventRemoteAdapter.pull(any, any));
        expect(result, equals(const Right(null)));
      },
    );

    test('should cache remote event if it doesn\'t exists in the cache',
        () async {
      // arrange
      when(mockEventRemoteAdapter.pull(any, any))
          .thenAnswer((_) async => tRemoteEvents);
      when(mockEventLocalDataSource.hasEvent(any))
          .thenAnswer((_) async => false);
      when(mockEventLocalDataSource.getPooledEvents(any))
          .thenAnswer((_) async => tLocalEvents);
      when(mockTimeInfo.now()).thenReturn(tToday);
      when(mockIdGenerator.generateId()).thenReturn(tEventId);
      // act
      final result = await repository.fetch(
        remoteAdapterName: tFirstAdapter,
        pool: tPool,
      );
      // assert
      final tExpectedEvents = tRemoteEvents.map<EventModel>(
        (e) {
          return EventModel.fromRemote(
            remoteEvent: e,
            pool: tPool,
            synced: {tFirstAdapter},
          ).copyWith(createdAt: tToday);
        },
      ).toList();
      verify(mockEventLocalDataSource.addEvents(tExpectedEvents));
      expect(result, equals(const Right(null)));
    });

    test('should resolve conflicts if the event exists in the cache', () async {
      // arrange
      final tCachedEvent = baseLocalEvent.copyWith(eventId: '1');
      final tRemoteEvent = baseRemoteEvent.copyWith(eventId: '1');
      final tExpectedEvent = EventModel.fromRemote(
        remoteEvent: tRemoteEvent,
        pool: tPool,
        synced: {tFirstAdapter},
      );

      when(mockEventRemoteAdapter.pull(any, any))
          .thenAnswer((_) async => [tRemoteEvent]);
      when(mockEventLocalDataSource.hasEvent(any))
          .thenAnswer((_) async => true);
      when(mockEventLocalDataSource.getEvent(any))
          .thenAnswer((_) async => tCachedEvent);
      when(mockEventLocalDataSource.getPooledEvents(any))
          .thenAnswer((_) async => tLocalEvents);
      when(mockEventResolver.resolve(
        existingEvent: anyNamed('existingEvent'),
        eventFromAdapter: anyNamed('eventFromAdapter'),
        remoteAdapterName: anyNamed('remoteAdapterName'),
        remoteAdapters: anyNamed('remoteAdapters'),
      )).thenReturn(tExpectedEvent);
      when(mockTimeInfo.now()).thenReturn(tToday);

      // act
      final result = await repository.fetch(
        remoteAdapterName: tFirstAdapter,
        pool: tPool,
      );

      // assert
      verify(mockEventResolver.resolve(
        existingEvent: anyNamed('existingEvent'),
        eventFromAdapter: anyNamed('eventFromAdapter'),
        remoteAdapterName: anyNamed('remoteAdapterName'),
        remoteAdapters: anyNamed('remoteAdapters'),
      ));
      verify(mockEventLocalDataSource.addEvents([tExpectedEvent]));
      expect(result, equals(const Right(null)));
    });

    test(
      'should return CacheFailure if the events cannot be stored',
      () async {
        // arrange
        when(mockEventRemoteAdapter.pull(any, any))
            .thenAnswer((_) async => tRemoteEvents);
        when(mockEventLocalDataSource.hasEvent(any))
            .thenAnswer((_) async => false);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tLocalEvents);
        when(mockTimeInfo.now()).thenReturn(tToday);
        when(mockEventLocalDataSource.addEvents(any)).thenThrow(Exception());

        // act
        final result = await repository.fetch(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.addEvents(any));
      },
    );

    test(
      'should return ServerFailure if the download fails',
      () async {
        // arrange
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => tLocalEvents);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tLocalEvents);
        when(mockEventRemoteAdapter.pull(any, any))
            .thenThrow(ServerException());
        // act
        final result = await repository.fetch(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        expect(result, equals(const Left(ServerFailure())));
        verify(mockEventRemoteAdapter.pull(any, any));
      },
    );

    test('should return CacheFailure if the events cannot be read from cache',
        () async {
      // arrange
      when(mockEventLocalDataSource.getPooledEvents(any))
          .thenThrow(CacheException());
      // act
      final result = await repository.fetch(
        remoteAdapterName: tFirstAdapter,
        pool: tPool,
      );
      // assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });

  group('push', () {
    const tPool = '1';
    final tTime = DateTime.now();
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')))
        .copyWith(createdAt: tTime);
    final List<EventModel> tCachedEvents = [
      baseEvent,
      baseEvent.copyWith(
          synced: [tFirstAdapter], order: 1, streamId: "synced-stream"),
    ];
    final List<RemoteEventModel> tRemoteEvents = [
      RemoteEventModel(
        order: 2,
        createdAt: tTime,
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
        when(mockEventRemoteAdapter.push(any, any))
            .thenAnswer((_) async => [remoteEvents.removeAt(0)]);
        // act
        final result = await repository.push(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        for (var e in tCachedEvents) {
          if (e.isSyncedWith(tFirstAdapter) == true) {
            verifyNever(mockEventRemoteAdapter.push(any, [e.toRemote()]));
          } else {
            verify(mockEventRemoteAdapter.push(any, [e.toRemote()]));
          }
        }
        // verify events were updated with their remote id
        verify(
          mockEventLocalDataSource.addEvents(
            [
              baseEvent.copyWith(order: 2, synced: [tFirstAdapter])
            ],
          ),
        );
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return CacheFailure if the events cannot be read from the cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenThrow(Exception());
        // act
        final result = await repository.push(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
      },
    );

    test(
      'should return ServerFailure if the upload fails',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEvents);
        when(mockEventRemoteAdapter.push(any, any))
            .thenThrow(ServerException());
        // act
        final result = await repository.push(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
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
        when(mockEventRemoteAdapter.push(any, any))
            .thenAnswer((_) async => [remoteEvents.removeAt(0)]);
        when(mockEventLocalDataSource.addEvents(any)).thenThrow(Exception());

        // act
        final result = await repository.push(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
      },
    );

    test(
      'should return OutOfSyncFailure if the server has newer events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEvents);
        when(mockEventRemoteAdapter.push(any, any))
            .thenThrow(OutOfSyncException());
        // act
        final result = await repository.push(
          remoteAdapterName: tFirstAdapter,
          pool: tPool,
        );
        // assert
        expect(result, equals(const Left(OutOfSyncFailure())));
      },
    );
  });

  group('rebase', () {
    const tPool = '1';
    final baseEvent = EventModel.fromJson(json.decode(fixture('event.json')));
    final List<EventModel> tCachedEventsFirst = [
      // un-synced events
      baseEvent.copyWith(streamId: 'first', version: 1, eventId: '1.4'),
      baseEvent.copyWith(streamId: 'first', version: 2, eventId: '1.5'),
      baseEvent.copyWith(streamId: 'first', version: 3, eventId: '1.6'),

      // synced events
      baseEvent.copyWith(
          streamId: 'first',
          order: 11,
          synced: [tFirstAdapter],
          version: 1,
          eventId: '1.1'),
      baseEvent.copyWith(
          streamId: 'first',
          order: 12,
          synced: [tFirstAdapter],
          version: 2,
          eventId: '1.2'),
      baseEvent.copyWith(
          streamId: 'first',
          order: 13,
          synced: [tFirstAdapter],
          version: 3,
          eventId: '1.3'),
    ];
    tCachedEventsFirst.sort((a, b) => a.version - b.version);

    final List<EventModel> tCachedEventsSecond = [
      // un-synced events
      baseEvent.copyWith(streamId: 'second', version: 1, eventId: '2.4'),
      baseEvent.copyWith(streamId: 'second', version: 2, eventId: '2.5'),
      baseEvent.copyWith(streamId: 'second', version: 3, eventId: '2.6'),

      // synced events
      baseEvent.copyWith(
          streamId: 'second',
          order: 21,
          synced: [tFirstAdapter],
          version: 1,
          eventId: '2.1'),
      baseEvent.copyWith(
          streamId: 'second',
          order: 22,
          synced: [tFirstAdapter],
          version: 2,
          eventId: '2.2'),
      baseEvent.copyWith(
          streamId: 'second',
          order: 23,
          synced: [tFirstAdapter],
          version: 3,
          eventId: '2.3'),
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
        verify(
          mockEventLocalDataSource.addEvents([
            baseEvent.copyWith(streamId: 'first', version: 4, eventId: '1.4'),
            baseEvent.copyWith(streamId: 'first', version: 5, eventId: '1.5'),
            baseEvent.copyWith(streamId: 'first', version: 6, eventId: '1.6')
          ]),
        );
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
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verify(
          mockEventLocalDataSource.addEvents([
            baseEvent.copyWith(streamId: 'first', version: 4, eventId: '1.4'),
            baseEvent.copyWith(streamId: 'first', version: 5, eventId: '1.5'),
            baseEvent.copyWith(streamId: 'first', version: 6, eventId: '1.6'),
          ]),
        );

        verify(
          mockEventLocalDataSource.addEvents([
            baseEvent.copyWith(streamId: 'second', version: 4, eventId: '2.4'),
            baseEvent.copyWith(streamId: 'second', version: 5, eventId: '2.5'),
            baseEvent.copyWith(streamId: 'second', version: 6, eventId: '2.6'),
          ]),
        );

        verifyNoMoreInteractions(mockEventLocalDataSource);

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
            order: 1,
            synced: [tFirstAdapter],
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
            .thenThrow(Exception());
        // act
        final result = await repository.rebase(tPool);
        // assert
        verify(mockEventLocalDataSource.getPooledEvents(any));
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
      },
    );

    test(
      'should return CacheFailure if the events cannot be saved to cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tCachedEventsFirst);
        when(mockEventLocalDataSource.addEvents(any)).thenThrow(Exception());
        // act
        final result = await repository.rebase(tPool);
        // assert
        verify(mockEventLocalDataSource.getPooledEvents(any));
        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
      },
    );
  });

  group('add', () {
    const tPoolSize = 99;
    const tEventId = 'eventId';
    const tPool = '1';
    final tTime = DateTime.now();
    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: 'first',
      createdAt: tTime,
      pool: tPool,
      order: tPoolSize + 1,
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
          data: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => []);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getPoolSize(any))
            .thenAnswer((_) async => tPoolSize);
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
          data: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tEvents);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getPoolSize(any))
            .thenAnswer((_) async => tPoolSize);
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
          data: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenThrow(Exception());
        // act
        final result = await repository.add(event, tPool);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verifyNever(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      "Should return CacheFailure if event cannot be saved in cache",
      () async {
        // arrange
        final event = MockEvent(
          data: MockEventData(),
          streamId: tEventModel.streamId,
        );
        when(mockTimeInfo.now()).thenReturn(tTime);
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tEvents);
        when(mockIdGenerator.generateId()).thenReturn(tEventId);
        when(mockEventLocalDataSource.getPoolSize(any))
            .thenAnswer((_) async => tPoolSize);
        when(mockEventLocalDataSource.addEvent(any)).thenThrow(Exception());
        // act
        final result = await repository.add(event, tPool);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.getPooledEvents(any));
        verify(mockEventLocalDataSource.addEvent(any));
      },
    );
  });

  group('list', () {
    const tPool = '1';
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
            .thenThrow(Exception());
        // act
        final result = await repository.list(tPool);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
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

  group('listEvents', () {
    const tPool = '1';
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
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenThrow(Exception());
        // act
        final result = await repository.listEvents(tPool);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.getPooledEvents(tPool));
        verifyNever(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      'Should return a list of events',
      () async {
        // arrange
        when(mockEventLocalDataSource.getPooledEvents(any))
            .thenAnswer((_) async => tEvents);
        // act
        final result = await repository.listEvents(tPool);
        // assert
        expect(result, equals(Right(tEvents)));
        verify(mockEventLocalDataSource.getPooledEvents(tPool));
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
        when(mockEventLocalDataSource.getEvent(any)).thenThrow(Exception());
        // act
        final result = await repository.markApplied(tEvent);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
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
        when(mockEventLocalDataSource.addEvent(any)).thenThrow(Exception());
        // act
        final result = await repository.markApplied(tEvent);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.addEvent(any));
      },
    );
  });

  group('markAppliedList', () {
    final tEventModel = EventModel.fromJson(json.decode(fixture('event.json')))
        .copyWith(applied: false);
    final tEvent = tEventModel.toDomain();

    test(
      "Should return CacheFailure if events cannot be read from cache",
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents()).thenThrow(Exception());
        // act
        final result = await repository.markAppliedList([tEvent]);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.getAllEvents());
        verifyNever(mockEventLocalDataSource.addEvent(any));
      },
    );

    test(
      'Should mark a list of events as applied',
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => [tEventModel]);
        // act
        final result = await repository.markAppliedList([tEvent]);
        // assert
        expect(result, equals(const Right(null)));
        final expectedEventModel = tEventModel.copyWith(applied: true);
        verify(mockEventLocalDataSource.addEvents([expectedEventModel]));
      },
    );

    test(
      "Should return CacheFailure if events cannot be marked as applied",
      () async {
        // arrange
        when(mockEventLocalDataSource.getAllEvents())
            .thenAnswer((_) async => [tEventModel]);
        when(mockEventLocalDataSource.addEvents(any)).thenThrow(Exception());
        // act
        final result = await repository.markAppliedList([tEvent]);

        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.addEvents(any));
      },
    );
  });

  group('clearPoolCache', () {
    test(
      'should clear cache',
      () async {
        // arrange
        const tPool = '1';
        // act
        final result = await repository.clearPoolCache(tPool);
        // assert
        expect(result, const Right(null));
        verify(mockEventLocalDataSource.clearPool(tPool));
        verifyNoMoreInteractions(mockEventLocalDataSource);
      },
    );

    test(
      'should return CacheFailure if clearing cache fails',
      () async {
        // arrange
        const tPool = '1';
        when(mockEventLocalDataSource.clearPool(tPool)).thenThrow(Exception());
        // act
        final result = await repository.clearPoolCache(tPool);
        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.clearPool(tPool));
        verifyNoMoreInteractions(mockEventLocalDataSource);
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
        when(mockEventLocalDataSource.clear()).thenThrow(Exception());
        // act
        final result = await repository.clearCache();
        // assert
        expect(result.swap().toOption().toNullable(), isA<CacheFailure>());
        verify(mockEventLocalDataSource.clear());
        verifyNoMoreInteractions(mockEventLocalDataSource);
      },
    );
  });
}
