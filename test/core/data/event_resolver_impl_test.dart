import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/data/event_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

class TestAdapter extends EventRemoteAdapter {
  final int _priority;
  final PullStrategy _pullStrategy =
      PullStrategy.rebase; // <-- not needed for this test.

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
  late EventResolver eventResolver;

  setUp(() {
    eventResolver = EventResolverImpl();
  });

  group("resolve", () {
    test(
        'should return the event from the adapter if the existing event has not been synced',
        () async {
      // arrange
      final existingEvent = EventModel(
        eventId: '1',
        order: 1,
        synced: {},
        // <-- not synced
        streamId: '1',
        version: 1,
        name: 'name',
        data: {},
        createdAt: DateTime.now(),
        pool: 'pool',
      );

      const remoteAdapterName = 'adapter';
      final eventFromAdapter = EventModel(
        eventId: '1',
        order: 1,
        synced: {
          'adapter': true,
        },
        streamId: '1',
        version: 2,
        name: 'name',
        data: {},
        createdAt: DateTime.now(),
        pool: 'pool',
      );
      final remoteAdapters = {'adapter': TestAdapter(priority: 1)};
      // act
      final result = eventResolver.resolve(
          existingEvent, eventFromAdapter, remoteAdapterName, remoteAdapters);
      // assert
      expect(result, eventFromAdapter);
    });

    test(
        'should return the event from the adapter if it was synced to a higher priority adapter',
        () async {
      // arrange
      final existingEvent = EventModel(
        eventId: '1',
        order: 1,
        synced: {
          'other-adapter': true, // <-- a lower priority adapter
        },
        streamId: '1',
        version: 1,
        name: 'name',
        data: {},
        createdAt: DateTime.now(),
        pool: 'pool',
      );

      const remoteAdapterName = 'adapter';
      final eventFromAdapter = EventModel(
        eventId: '1',
        order: 1,
        synced: {
          'adapter': true,
        },
        streamId: '1',
        version: 2,
        name: 'name',
        data: {},
        createdAt: DateTime.now(),
        pool: 'pool',
      );
      final remoteAdapters = {
        'adapter': TestAdapter(priority: 1),
        'other-adapter': TestAdapter(priority: 0),
        // <-- a lower priority adapter
      };
      // act
      final result = eventResolver.resolve(
          existingEvent, eventFromAdapter, remoteAdapterName, remoteAdapters);
      // assert
      expect(result, eventFromAdapter);
    });

    test('should throw an error if the adapter for the new event was not found',
        () async {});

    test(
        'should throw an error if the adapter for the existing event was not found',
        () async {});

    test(
        'should return the existing event if it was synced to a higher priority adapter',
        () async {
      // arrange
      // final existingEvent = EventModel(
      //   eventId: '1',
      //   order: 1,
      //   synced: {
      //     'adapter': true,
      //   },
      //   streamId: '1',
      //   version: 1,
      //   name: 'name',
      //   data: {},
      //   createdAt: DateTime.now(),
      //   pool: 'pool',
      // );
      //
      // const remoteAdapterName = 'other-adapter';
      // final eventFromAdapter = EventModel(
      //   eventId: '1',
      //   order: 1,
      //   synced: {
      //     'other-adapter': true, // <-- a lower priority adapter
      //   },
      //   streamId: '1',
      //   version: 2,
      //   name: 'name',
      //   data: {},
      //   createdAt: DateTime.now(),
      //   pool: 'pool',
      // );
      // final remoteAdapters = {
      //   'adapter': TestAdapter(priority: 1),
      //   'other-adapter': TestAdapter(priority: 0),
      //   // <-- a lower priority adapter
      // };
      // // act
      // final result = eventResolver.resolve(
      //     existingEvent, eventFromAdapter, remoteAdapterName, remoteAdapters);
      // // assert
      // expect(result, existingEvent);
    });
  });
}
