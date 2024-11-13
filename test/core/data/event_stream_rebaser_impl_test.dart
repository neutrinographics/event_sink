import 'dart:convert';

import 'package:event_sink/src/annotations/params/remote_adapter.dart';
import 'package:event_sink/src/core/data/event_stream_rebaser.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'event_stream_rebaser_impl_test.mocks.dart';

class TestAdapter extends EventRemoteAdapter {
  final int _priority;

  // not needed for this test.
  final PullStrategy _pullStrategy = PullStrategy.rebase;

  TestAdapter({
    required int priority,
  }) : _priority = priority;

  @override
  int get priority => _priority;

  @override
  PullStrategy get pullStrategy => _pullStrategy;

  @override
  Future<List<RemoteEventModel>> pull() {
    throw UnimplementedError();
  }

  @override
  Future<List<RemoteEventModel>> push(List<RemoteNewEventModel> events) {
    throw UnimplementedError();
  }
}

@GenerateMocks([EventLocalDataSource])
void main() {
  late MockEventLocalDataSource mockEventLocalDataSource;
  late EventStreamRebaser eventRebaser;

  setUp(() {
    mockEventLocalDataSource = MockEventLocalDataSource();
    eventRebaser = EventStreamRebaserImpl(mockEventLocalDataSource);
  });

  group('rebase', () {
    final baseEvent = EventModel.fromJson(jsonDecode(fixture('event.json')));
    const firstAdapter = 'first_adapter';
    const secondAdapter = 'second_adapter';
    final tRemoteAdapters = {
      firstAdapter: TestAdapter(priority: 1),
      secondAdapter: TestAdapter(priority: 2),
    };

    test('should not change un-synced events', () async {
      // arrange
      final tUnSyncedEvents = [
        baseEvent.copyWith(eventId: 'id_1.1', version: 1),
        baseEvent.copyWith(eventId: 'id_1.2', version: 2),
      ];

      // act
      await eventRebaser.rebase(tUnSyncedEvents, tRemoteAdapters);

      // assert
      verify(mockEventLocalDataSource.addEvents(tUnSyncedEvents));
      verifyNoMoreInteractions(mockEventLocalDataSource);
    });

    test('should rebase un-synced events with correct versioning', () {
      // arrange
      final tFirstUnSyncedEvent = baseEvent.copyWith(
        eventId: 'id_1.1',
        version: 1,
      );
      final tSecondUnSyncedEvent = baseEvent.copyWith(
        eventId: 'id_1.2',
        version: 2,
      );
      final tUnSyncedEvents = <EventModel>[
        tFirstUnSyncedEvent,
        tSecondUnSyncedEvent,
      ];
      final tSyncedEvents = [
        baseEvent.copyWith(
          eventId: 'id_1.1',
          version: 1,
          synced: {firstAdapter: true},
        ),
      ];
      final tPoolEvents = [
        ...tUnSyncedEvents,
        ...tSyncedEvents,
      ];

      // act
      eventRebaser.rebase(tPoolEvents, tRemoteAdapters);

      // assert
      final tExpectedEvents = <EventModel>[
        tFirstUnSyncedEvent.copyWith(version: 2),
        tSecondUnSyncedEvent.copyWith(version: 3),
      ];
      verify(mockEventLocalDataSource.addEvents([
        ...tSyncedEvents,
        ...tExpectedEvents,
      ]));
      verifyNoMoreInteractions(mockEventLocalDataSource);
    });

    test('event with the highest adapter priority should win version conflicts',
        () {
      // arrange
      final tLoPrioritySyncedEvent = baseEvent.copyWith(
        eventId: 'id_1.1',
        version: 1,
        synced: {firstAdapter: true},
      );
      final tHiPrioritySyncedEvent = baseEvent.copyWith(
        eventId: 'id_2.1',
        version: 1,
        synced: {secondAdapter: true},
      );
      final tSyncedEvents = <EventModel>[
        tLoPrioritySyncedEvent,
        tHiPrioritySyncedEvent,
      ];

      // act
      eventRebaser.rebase(tSyncedEvents, tRemoteAdapters);

      // assert
      final tExpectedEvents = <EventModel>[
        tHiPrioritySyncedEvent,
        tLoPrioritySyncedEvent.copyWith(
          version: tHiPrioritySyncedEvent.version + 1,
        ),
      ];
      verify(mockEventLocalDataSource.addEvents(tExpectedEvents));
      verifyNoMoreInteractions(mockEventLocalDataSource);
    });

    test(
      'should throws an exception if the events cannot be saved to cache',
      () async {
        // arrange
        when(mockEventLocalDataSource.addEvents(any)).thenThrow(Exception());
        // act & assert
        expect(
          eventRebaser.rebase([], tRemoteAdapters),
          throwsA(isA<Exception>()),
        );
      },
    );
  });
}
