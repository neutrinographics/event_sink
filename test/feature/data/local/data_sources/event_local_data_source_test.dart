import 'package:event_sync/src/core/data/local_cache.dart';
import 'package:event_sync/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sync/src/feature/data/local/models/event_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'event_local_data_source_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<Box>(), MockSpec<LocalCache<String, EventModel>>()])
void main() {
  late EventLocalDataSourceImpl dataSource;
  late MockLocalCache mockLocalCache;

  setUp(() {
    mockLocalCache = MockLocalCache();
    dataSource = EventLocalDataSourceImpl(
      cache: mockLocalCache,
    );
  });

  group('getAllEvents', () {
    const tEventId = "eventId";

    final tEventModel = EventModel(
      id: tEventId,
      streamId: '175794e2-83a6-4f9a-b873-d43484e2c0b5',
      version: 1,
      name: "create-group",
      createdAt: DateTime.now(),
      data: {
        "group_stream_id": "3304ABE8-D744-48CE-8FC6-2FEA19E6B4D8",
      },
    );

    test('should return all events sorted by event version in ascending order',
        () async {
      // arrange
      final tEventModels = [
        tEventModel.copyWith(version: 2),
        tEventModel,
        tEventModel.copyWith(version: 3),
      ];
      when(mockLocalCache.values()).thenAnswer((_) async => tEventModels);

      // act
      final result = await dataSource.getAllEvents();
      // assert
      verify(mockLocalCache.values());
      tEventModels.sort(((a, b) => a.version - b.version));
      expect(result, tEventModels);
    });
  });
}
