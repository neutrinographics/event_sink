import 'dart:convert';

import 'package:clean_cache/clean_cache.dart';
import 'package:event_sink/src/annotations/params/remote_adapter.dart';
import 'package:event_sink/src/core/data/event_sorter.dart';
import 'package:event_sink/src/core/hash_generator.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/local/models/pool_model.dart';
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'event_local_data_source_test.mocks.dart';

class TestAdapter extends EventRemoteAdapter {
  @override
  int get priority => throw UnimplementedError();

  @override
  Future<List<RemoteEventModel>> pull(String pool, String stateHash) {
    throw UnimplementedError();
  }

  @override
  PullStrategy get pullStrategy => throw UnimplementedError();

  @override
  Future<List<RemoteEventModel>> push(
    String pool,
    String stateHash,
    List<RemoteEventModel> events,
  ) {
    throw UnimplementedError();
  }
}

@GenerateNiceMocks([
  MockSpec<CleanCache>(),
  MockSpec<EventSorter>(),
  MockSpec<HashGenerator>(),
])
void main() {
  late MockEventSorter mockEventSorter;
  late EventLocalDataSourceImpl dataSource;
  late MockCleanCache<String, EventModel> mockEventCache;
  late MockCleanCache<String, PoolModel> mockPoolCache;
  late MockHashGenerator mockHashGenerator;

  final tRemoteAdapters = <String, EventRemoteAdapter>{
    'adapter-1': TestAdapter(),
    'adapter-2': TestAdapter(),
  };

  setUp(() {
    mockEventSorter = MockEventSorter();
    mockEventCache = MockCleanCache<String, EventModel>();
    mockPoolCache = MockCleanCache<String, PoolModel>();
    mockHashGenerator = MockHashGenerator();
    dataSource = EventLocalDataSourceImpl(
      eventCache: mockEventCache,
      poolCache: mockPoolCache,
      eventSorter: mockEventSorter,
      remoteAdapters: tRemoteAdapters,
      hashGenerator: mockHashGenerator,
    );
  });

  group('getAllEvents', () {
    const tEventId = "eventId";

    final tEvent = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      order: 1,
      version: 1,
      name: "create-group",
      createdAt: DateTime.now(),
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: '1',
    );

    test('should return all events sorted by event version in ascending order',
        () async {
      // arrange
      final tEventModels = [
        tEvent.copyWith(version: 2, order: 2),
        tEvent,
        tEvent.copyWith(version: 3, order: 3),
      ];
      when(mockEventCache.values()).thenAnswer((_) async => tEventModels);
      when(mockEventSorter.sort(any, any)).thenAnswer((_) => tEventModels);

      // act
      final result = await dataSource.getAllEvents();
      // assert
      verify(mockEventCache.values());
      tEventModels.sort(((a, b) => a.version - b.version));
      expect(result, tEventModels);
    });
  });

  group('addEvent', () {
    const tEventId = 'event-1';
    final tModel = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: DateTime.now(),
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: '1',
    );

    test(
      'should add an event',
      () async {
        // nothing to arrange
        when(mockPoolCache.exists(any)).thenAnswer((_) async => false);
        await dataSource.addEvent(tModel);
        // assert
        verify(mockEventCache.write(tEventId, any));
        final expectedPoolState = PoolModel(
          id: tModel.pool,
          eventIds: [tEventId],
        );
        verify(mockPoolCache.write(any, expectedPoolState));
      },
    );

    test(
      'should add a second event',
      () async {
        // arrange
        const tExistingEventId = 'event-2';
        final PoolModel tExistingPool = PoolModel(
          id: tModel.pool,
          eventIds: [tExistingEventId],
        );
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read('1')).thenAnswer((_) async => tExistingPool);
        // act
        await dataSource.addEvent(tModel);
        // assert
        verify(mockEventCache.write(any, any));
        final expectedPoolState = PoolModel(
          id: tModel.pool,
          eventIds: [tExistingEventId, tEventId],
        );
        verify(mockPoolCache.write(any, expectedPoolState));
      },
    );
  });

  group('addEvents', () {
    final tEvents = [
      EventModel(
        eventId: 'event-1',
        streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
        version: 1,
        order: 1,
        name: "create-group",
        createdAt: DateTime.now(),
        data: {
          "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
        },
        pool: '1',
      ),
      EventModel(
        eventId: 'event-2',
        streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
        version: 2,
        order: 2,
        name: "create-group",
        createdAt: DateTime.now(),
        data: {
          "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
        },
        pool: '2',
      ),
    ];

    test(
      'should add a list of events',
      () async {
        // arrange
        when(mockPoolCache.exists(any)).thenAnswer((_) async => false);
        // act
        await dataSource.addEvents(tEvents);
        // assert
        final expectedPoolState = PoolModel(
          id: tEvents.last.pool,
          eventIds: [tEvents.last.eventId],
        );
        verify(mockPoolCache.write(tEvents.last.pool, expectedPoolState));

        final expectedEvents = {
          tEvents.first.eventId: tEvents.first,
          tEvents.last.eventId: tEvents.last,
        };

        verify(mockEventCache.writeAll(expectedEvents));
      },
    );
  });

  group('removeEvent', () {
    const tEventId = 'event-1';
    final createdAt = DateTime.now();
    final tModel = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: createdAt,
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: '1',
    );

    test(
      'should remove an event',
      () async {
        // arrange
        const tOtherEventId = 'other-event';
        final tPoolData = PoolModel(
            id: tModel.pool, eventIds: [tOtherEventId, tModel.eventId]);
        when(mockEventCache.read(any)).thenAnswer((_) async => tModel);
        when(mockPoolCache.keys()).thenAnswer((_) async => [tModel.pool]);
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read(any)).thenAnswer((_) async => tPoolData);
        // act
        await dataSource.removeEvent(tEventId);
        // assert
        verify(mockEventCache.delete(tEventId));
        final expectedPoolData = PoolModel(
          id: tModel.pool,
          eventIds: [tOtherEventId],
        );
        verify(mockPoolCache.write(tModel.pool, expectedPoolData));
      },
    );

    test(
      'should delete the pool if the last event is deleted',
      () async {
        // arrange
        final tPoolData = PoolModel(
          id: tModel.pool,
          eventIds: [tModel.eventId],
        );
        when(mockEventCache.read(any)).thenAnswer((_) async => tModel);
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read(any)).thenAnswer((_) async => tPoolData);
        // act
        await dataSource.removeEvent(tEventId);
        // assert
        verify(mockEventCache.delete(tEventId));
        verify(mockPoolCache.delete(tModel.pool));
      },
    );
  });

  group('getPoolSize', () {
    test("should return the number of events in the pool", () async {
      // arrange
      const tPoolId = '1';
      final tPool = PoolModel(
        id: tPoolId,
        eventIds: ['event-1', 'event-2'],
      );
      when(mockPoolCache.keys()).thenAnswer((_) async => [tPoolId]);
      when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
      when(mockPoolCache.read(any)).thenAnswer((_) async => tPool);
      // act
      final result = await dataSource.getPoolSize(tPoolId);
      // assert
      expect(result, tPool.eventIds.length);
    });

    test("should re-index the pools if the pool cache is empty", () async {
      // arrange
      const tPoolId = '1';
      final tEvent = EventModel.fromJson(json.decode(fixture('event.json')));
      final tPool = PoolModel(
        id: tPoolId,
        eventIds: [tEvent.eventId],
      );
      when(mockPoolCache.keys())
          .thenAnswer((_) async => []); // <-- Indicates the pool cache is empty
      when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
      when(mockEventCache.values()).thenAnswer((_) async => [tEvent]);
      when(mockPoolCache.read(any)).thenAnswer((_) async => tPool);
      // act
      await dataSource.getPoolSize(tPoolId);
      // assert
      verify(mockEventCache.values());
      verify(mockPoolCache.write(tPoolId, tPool));
    });
  });

  group('getPooledEvents', () {
    const tEventId = "event-1";
    const tPool = '1';
    final createdAt = DateTime.now();
    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: createdAt,
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: tPool,
    );

    test('should return the pooled events', () async {
      // arrange
      when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
      when(mockPoolCache.read(any)).thenAnswer((_) async => PoolModel(
            id: tPool,
            eventIds: [tEventId],
          ));
      when(mockEventCache.read(any)).thenAnswer((_) async => tEventModel);
      when(mockEventSorter.sort(any, any)).thenAnswer((_) => [tEventModel]);

      // act
      final result = await dataSource.getPooledEvents(tPool);
      // assert
      final expectedModels = [tEventModel];
      expect(result, expectedModels);
    });
  });

  group('clear', () {
    test(
      'should clear the events in all pools',
      () async {
        // nothing to arrange
        // act
        await dataSource.clear();
        // assert
        verify(mockPoolCache.clear());
        verify(mockEventCache.clear());
      },
    );
  });

  group('clearPool', () {
    test(
      'should clear the events in a single pool',
      () async {
        // arrange
        const tPoolId = '1';
        final tPool = PoolModel(
          id: tPoolId,
          eventIds: ['one', 'two'],
        );
        when(mockPoolCache.keys()).thenAnswer((_) async => [tPoolId]);
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read(any)).thenAnswer((_) async => tPool);
        // act
        await dataSource.clearPool(tPoolId);
        // assert
        verify(mockPoolCache.read(tPoolId));
        verify(mockPoolCache.delete(tPoolId));
        for (final id in tPool.eventIds) {
          verify(mockEventCache.delete(id));
        }
        verify(mockPoolCache.keys());
        verify(mockPoolCache.exists(tPoolId));
        verifyNoMoreInteractions(mockPoolCache);
        verifyNoMoreInteractions(mockEventCache);
      },
    );
  });

  group('getStreamRootHash', () {
    const tEventId = "event-1";
    const tPool = '1';
    const tStreamId = '175794e2-83a6-4f9a-b873-d43484e2c0b5';
    final createdAt = DateTime.now();
    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: tStreamId,
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: createdAt,
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: tPool,
    );

    test('should return a stream root hash', () async {
      // arrange
      const tHash = 'root-hash';
      when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
      when(mockPoolCache.read(any)).thenAnswer((_) async => PoolModel(
            id: tPool,
            eventIds: [tEventId],
          ));
      when(mockEventCache.read(any)).thenAnswer((_) async => tEventModel);
      when(mockEventSorter.sort(any, any)).thenAnswer((_) => [tEventModel]);
      when(mockHashGenerator.generateHash(any)).thenReturn(tHash);
      // act
      final result = await dataSource.getStreamRootHash(tPool, tStreamId);
      // assert
      final tExpectedHashParam = jsonEncode([
        {
          'eventId': tEventModel.eventId,
        }
      ]);
      expect(result, tHash);
      verify(mockHashGenerator.generateHash(tExpectedHashParam));
    });
  });

  group('listStreamHashes', () {
    const tHash = 'hash';
    const tEventId = "event-1";
    const tStreamId = 'open_door';
    const tPool = '1';
    final createdAt = DateTime.now();
    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: tStreamId,
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: createdAt,
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: tPool,
    );

    test('should return a list of stream hashes', () async {
      // arrange
      when(mockHashGenerator.generateHash(any)).thenReturn(tHash);
      when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
      when(mockPoolCache.read(any)).thenAnswer((_) async => PoolModel(
            id: tPool,
            eventIds: [tEventId],
          ));
      when(mockEventCache.read(any)).thenAnswer((_) async => tEventModel);
      when(mockEventSorter.sort(any, any)).thenAnswer((_) => [tEventModel]);
      // act
      final result = await dataSource.listStreamHashes(tPool, tStreamId);
      // assert
      expect(result, [const StreamHash(eventId: tEventId, hash: tHash)]);
    });
  });
}
