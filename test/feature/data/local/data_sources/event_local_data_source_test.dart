import 'package:event_sink/src/core/data/local_cache.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'event_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalCache>()])
void main() {
  late EventLocalDataSourceImpl dataSource;
  late MockLocalCache<String, EventModel> mockEventCache;
  late MockLocalCache<int, List<String>> mockPoolCache;

  setUp(() {
    mockEventCache = MockLocalCache<String, EventModel>();
    mockPoolCache = MockLocalCache<int, List<String>>();
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
        tEventModel.copyWith(version: 2),
        tEventModel,
        tEventModel.copyWith(version: 3),
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

  group('getPooledEvents', () {
    const tEventId = "event-1";
    const tPool = 1;

    final tEventModel = EventModel(
      eventId: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      version: 1,
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

  group('sort', () {
    final tEventModel = EventModel(
      eventId: 'event-id',
      streamId: 'stream-1',
      version: 1,
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
          tEventModel.copyWith(version: 3),
          tEventModel.copyWith(version: 2),
        ];
        // act
        EventLocalDataSourceImpl.sort(tModels);
        // assert
        final expectedModels = [
          tEventModel,
          tEventModel.copyWith(streamId: 'stream-2'),
          tEventModel.copyWith(version: 2),
          tEventModel.copyWith(version: 3),
        ];
        expect(tModels, expectedModels);
      },
    );
  });
}
