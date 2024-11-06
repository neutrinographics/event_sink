import 'dart:convert';

import 'package:event_sink/src/annotations/params/remote_adapter.dart';
import 'package:event_sink/src/core/data/event_sorter.dart';
import 'package:event_sink/src/event_remote_adapter.dart';
import 'package:event_sink/src/feature/data/local/models/event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';
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
  Future<List<RemoteEventModel>> push(List<RemoteNewEventModel> events) {
    throw UnimplementedError();
  }
}

void main() {
  late EventSorter eventSorter;

  setUp(() {
    eventSorter = EventSorterImpl();
  });

  test('should sort events', () {
    // arrange
    final tBaseEvent = EventModel.fromJson(jsonDecode(fixture('event.json')));
    const tLoPriorityAdapter = 'first-adapter';
    const tHiPriorityAdapter = 'second-adapter';
    final tRemoteAdapters = {
      tLoPriorityAdapter: TestAdapter(priority: 1),
      tHiPriorityAdapter: TestAdapter(priority: 2),
    };
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
      tBaseEvent.copyWith(
        eventId: 'C',
        order: 1,
        synced: {tLoPriorityAdapter: true},
      ),
      tBaseEvent.copyWith(
        eventId: 'D',
        order: 2,
        synced: {tLoPriorityAdapter: true},
      ),
      tBaseEvent.copyWith(eventId: 'E', order: 1),
      tBaseEvent.copyWith(eventId: 'F', order: 2),
    ];
    final tUnorderedEvents = List<EventModel>.from(tExpectedEvents)
      ..shuffle()
      ..shuffle();

    // act
    final result = eventSorter.sort(tUnorderedEvents, tRemoteAdapters);

    // assert
    expect(result, tExpectedEvents);
  });
}
