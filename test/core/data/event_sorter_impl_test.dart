import 'dart:convert';

import 'package:event_sink/src/annotations/params/remote_adapter.dart';
import 'package:event_sink/src/core/data/event_sorter.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

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
  Future<List<RemoteEventModel>> push(List<RemoteEventModel> events) {
    throw UnimplementedError();
  }
}

void main() {
  late EventSorter eventSorter;

  setUp(() {
    eventSorter = EventSorterImpl();
  });

  group('sort', () {
    final tBaseEvent = EventModel.fromJson(jsonDecode(fixture('event.json')));
    const tLoPriorityAdapter = 'first-adapter';
    const tHiPriorityAdapter = 'second-adapter';
    final tRemoteAdapters = {
      tLoPriorityAdapter: TestAdapter(priority: 1),
      tHiPriorityAdapter: TestAdapter(priority: 2),
    };

    test('should place synced event before un-synced event', () {
      // arrange
      final tExpectedEvents = <EventModel>[
        tBaseEvent.copyWith(
          eventId: 'A',
          order: 1,
          synced: {tHiPriorityAdapter: true},
        ),
        tBaseEvent.copyWith(
          eventId: 'B',
          order: 1,
        ),
      ];
      final tUnorderedEvents = tExpectedEvents.reversed.toList();
      // act
      final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);
      // assert
      expect(result, tExpectedEvents);
    });

    test(
        'should place higher priority synced event before lower priority synced event',
        () {
      // arrange
      final tExpectedEvents = <EventModel>[
        tBaseEvent.copyWith(
          eventId: 'A',
          order: 1,
          synced: {tHiPriorityAdapter: true},
        ),
        tBaseEvent.copyWith(
          eventId: 'B',
          order: 1,
          synced: {tLoPriorityAdapter: true},
        ),
      ];
      final tUnorderedEvents = tExpectedEvents.reversed.toList();
      // act
      final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);
      // assert
      expect(result, tExpectedEvents);
    });

    test('should sort synced events by order', () {
      // arrange
      final tExpectedEvents = <EventModel>[
        tBaseEvent.copyWith(
          eventId: 'A',
          order: 1,
          synced: {tHiPriorityAdapter: true},
        ),
        tBaseEvent.copyWith(
          eventId: 'B',
          order: 2,
          synced: {tHiPriorityAdapter: true},
        ),
      ];
      final tUnorderedEvents = tExpectedEvents.reversed.toList();
      // act
      final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);
      // assert
      expect(result, tExpectedEvents);
    });

    test('should sort un-synced events by order', () {
      // arrange
      final tExpectedEvents = <EventModel>[
        tBaseEvent.copyWith(
          eventId: 'A',
          order: 1,
        ),
        tBaseEvent.copyWith(
          eventId: 'B',
          order: 2,
        ),
      ];
      final tUnorderedEvents = tExpectedEvents.reversed.toList();
      // act
      final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);
      // assert
      expect(result, tExpectedEvents);
    });

    test(
        'should sort synced events by createdAt if all other properties are equal',
        () {
      // arrange
      final tExpectedEvents = <EventModel>[
        tBaseEvent.copyWith(
          eventId: 'A',
          order: 1,
          synced: {tHiPriorityAdapter: true},
          createdAt: DateTime(2022),
        ),
        tBaseEvent.copyWith(
          eventId: 'B',
          order: 1,
          synced: {tHiPriorityAdapter: true},
          createdAt: DateTime(2021),
        ),
      ];
      final tUnorderedEvents = tExpectedEvents.reversed.toList();
      // act
      final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);
      // assert
      expect(result, tExpectedEvents);
    });

    test(
        'should sort un-synced events by createdAt if all other properties are equal',
        () {
      // arrange
      final tExpectedEvents = <EventModel>[
        tBaseEvent.copyWith(
          eventId: 'A',
          order: 1,
          createdAt: DateTime(2022),
        ),
        tBaseEvent.copyWith(
          eventId: 'B',
          order: 1,
          createdAt: DateTime(2021),
        ),
      ];
      final tUnorderedEvents = tExpectedEvents.reversed.toList();
      // act
      final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);
      // assert
      expect(result, tExpectedEvents);
    });
  });
}
