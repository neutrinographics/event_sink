import 'package:clean_cache/clean_cache.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'event_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CleanCache>()])
void main() {
  late EventLocalDataSourceImpl dataSource;
  late MockCleanCache<String, EventModel> mockEventCache;
  late MockCleanCache<int, List<String>> mockPoolCache;

  setUp(() {
    mockEventCache = MockCleanCache<String, EventModel>();
    mockPoolCache = MockCleanCache<int, List<String>>();
    dataSource = EventLocalDataSourceImpl(
      eventCache: mockEventCache,
      poolCache: mockPoolCache,
    );
  });

  group('getAllEvents', () {
    const tEventId = "eventId";

    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      order: 1,
      version: 1,
      name: "create-group",
      createdAt: DateTime.now(),
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: 1,
    );

    test('should return all events sorted by event version in ascending order',
        () async {
      // arrange
      final tEventModels = [
        tEventModel.copyWith(version: 2, order: 2),
        tEventModel,
        tEventModel.copyWith(version: 3, order: 3),
      ];
      when(mockEventCache.values()).thenAnswer((_) async => tEventModels);

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
      pool: 1,
    );

    test(
      'should add an event',
      () async {
        // nothing to arrange
        when(mockPoolCache.exists(any)).thenAnswer((_) async => false);
        await dataSource.addEvent(tModel);
        // assert
        verify(mockEventCache.write(tEventId, any));
        final expectedPoolState = [tEventId];
        verify(mockPoolCache.write(any, expectedPoolState));
      },
    );

    test(
      'should add a second event',
      () async {
        // arrange
        const tExistingEventId = 'event-2';
        const List<String> tExistingEvents = [tExistingEventId];
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read(1)).thenAnswer((_) async => tExistingEvents);
        // act
        await dataSource.addEvent(tModel);
        // assert
        verify(mockEventCache.write(any, any));
        final expectedPoolState = [tExistingEventId, tEventId];
        verify(mockPoolCache.write(any, expectedPoolState));
      },
    );
  });

  group('removeEvent', () {
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
      pool: 1,
    );

    test(
      'should remove an event',
      () async {
        // arrange
        const tOtherEventId = 'other-event';
        final tPoolData = [tOtherEventId, tModel.eventId];
        when(mockEventCache.read(any)).thenAnswer((_) async => tModel);
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read(any)).thenAnswer((_) async => tPoolData);
        // act
        await dataSource.removeEvent(tEventId);
        // assert
        verify(mockEventCache.delete(tEventId));
        final expectedPoolData = [tOtherEventId];
        verify(mockPoolCache.write(tModel.pool, expectedPoolData));
      },
    );

    test(
      'should delete the pool if the last event is deleted',
      () async {
        // arrange
        final tPoolData = [tModel.eventId];
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
    const tPool = 1;

    test(
      'should return the number of events in a pool',
      () async {
        // arrange
        const tEventIds = ['1', '2'];
        when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
        when(mockPoolCache.read(any)).thenAnswer((_) async => tEventIds);
        // act
        final result = await dataSource.getPoolSize(tPool);
        // assert
        expect(result, tEventIds.length);
        verify(mockPoolCache.exists(tPool));
        verify(mockPoolCache.read(tPool));
      },
    );
  });

  group('getPooledEvents', () {
    const tEventId = "event-1";
    const tPool = 1;

    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: DateTime.now(),
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
      pool: tPool,
    );

    test('should return the pooled events', () async {
      // arrange
      when(mockPoolCache.exists(any)).thenAnswer((_) async => true);
      when(mockPoolCache.read(any)).thenAnswer((_) async => [tEventId]);
      when(mockEventCache.read(any)).thenAnswer((_) async => tEventModel);
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
        const tPoolEvents = [
          'one',
          'two',
        ];
        const tPool = 1;
        when(mockPoolCache.read(any)).thenAnswer((_) async => tPoolEvents);
        // act
        await dataSource.clearPool(tPool);
        // assert
        verify(mockPoolCache.read(tPool));
        verify(mockPoolCache.delete(tPool));
        for (final id in tPoolEvents) {
          verify(mockEventCache.delete(id));
        }
        verifyNoMoreInteractions(mockPoolCache);
        verifyNoMoreInteractions(mockEventCache);
      },
    );
  });

  group('sort', () {
    final tEventModel = EventModel(
      eventId: 'event-id',
      streamId: 'stream-1',
      version: 1,
      order: 1,
      name: "create-group",
      createdAt: DateTime.now(),
      data: {
        "group_stream_id": 'group-id',
      },
      pool: 1,
    );

    test(
      'should sort a list of events',
      () async {
        // arrange
        final tModels = [
          tEventModel,
          tEventModel.copyWith(streamId: 'stream-2'),
          tEventModel.copyWith(version: 3, order: 3),
          tEventModel.copyWith(version: 2, order: 2),
        ];
        // act
        EventLocalDataSourceImpl.sort(tModels);
        // assert
        final expectedModels = [
          tEventModel,
          tEventModel.copyWith(streamId: 'stream-2'),
          tEventModel.copyWith(version: 2, order: 2),
          tEventModel.copyWith(version: 3, order: 3),
        ];
        expect(tModels, expectedModels);
      },
    );
  });
}
