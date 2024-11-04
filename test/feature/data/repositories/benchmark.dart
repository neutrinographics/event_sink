import 'dart:convert';
import 'dart:io';

import 'package:clean_cache/cache/memory_cache.dart';
import 'package:clock/clock.dart';
import 'package:event_sink/src/core/data/cache.dart';
import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/local/models/pool_model.dart';
import 'package:event_sink/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/repositories/event_repository_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import '../../../fixtures/fixture_reader.dart';
import 'benchmark.mocks.dart';

/// This benchmark is used to measure the performance of the EventRepositoryImpl.fetch method.
/// You need to provide a large number of events in the fixture file, fixtures/ephemeral/many-events.json.
@GenerateMocks([EventRemoteDataSource])
void main() {
  late List<RemoteEventModel> events;
  late EventRepositoryImpl repository;
  late EventLocalDataSourceImpl localDataSource;
  late MockEventRemoteDataSource mockRemoteDataSource;

  setUp(() async {
    final stagingDir = Directory('test/staging/hive_testing_path');
    if (stagingDir.existsSync()) {
      stagingDir.deleteSync(recursive: true);
    }
    Hive
      ..init('test/staging/hive_testing_path')
      ..registerAdapter(EventModelImplAdapter())
      ..registerAdapter(PoolModelImplAdapter());
    final rawEvents =
        json.decode(fixture('ephemeral/many-events.json'))['events']
            as List<dynamic>;
    events = rawEvents.map((e) => RemoteEventModel.fromJson(e)).toList();

    final eventCache =
        await buildHybridHiveCache<String, EventModel>('event_sink-events');
    localDataSource = EventLocalDataSourceImpl(
      eventCache: eventCache,
      poolCache: MemoryCache(),
    );
    mockRemoteDataSource = MockEventRemoteDataSource();
    IdGeneratorImpl idGenerator = IdGeneratorImpl(const Uuid());
    TimeInfoImpl timeInfo = TimeInfoImpl(const Clock());
    repository = EventRepositoryImpl(
      localDataSource: localDataSource,
      idGenerator: idGenerator,
      timeInfo: timeInfo,
    );
  });

  group('fetch', () {
    const tPool = '1';

    test('should fetch and record the remote events', () async {
      // arrange
      when(mockRemoteDataSource.getEvents(
        host: anyNamed('host'),
        token: anyNamed('token'),
      )).thenAnswer((_) async => events);
      // act
      final stopwatch = Stopwatch()..start();
      await repository.fetch(
        remoteAdapterName: 'test',
        pool: tPool,
      );
      stopwatch.stop();
      // assert
      debugPrint("Fetch finished after ${stopwatch.elapsedMilliseconds}ms");
    });
  });
}
