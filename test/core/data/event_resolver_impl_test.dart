import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/data/event_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

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
  Future<List<RemoteEventModel>> pull(String pool) {
    throw UnimplementedError();
  }

  @override
  Future<List<RemoteEventModel>> push(
    String pool,
    List<RemoteEventModel> events,
  ) {
    throw UnimplementedError();
  }
}

void main() {
  late EventResolver eventResolver;

  setUp(() {
    eventResolver = EventResolverImpl();
  });

  group("resolve", () {
    const firstAdapter = 'first_adapter';
    const secondAdapter = 'second_adapter';
    final event = EventModel(
      eventId: '1',
      order: 1,
      streamId: '1',
      version: 1,
      name: 'name',
      data: {},
      createdAt: DateTime.now(),
      pool: 'pool',
    );

    test(
        'should return the event from the adapter if the existing event has not been synced',
        () {
      // arrange
      final existingEvent = event.copyWith(
        synced: {}, // <-- not synced
        version: 1,
      );
      final eventFromAdapter = event.copyWith(
        synced: {firstAdapter: true},
        version: 2,
      );
      final remoteAdapters = {
        firstAdapter: TestAdapter(priority: 1),
      };
      // act
      final result = eventResolver.resolve(
        existingEvent: existingEvent,
        eventFromAdapter: eventFromAdapter,
        remoteAdapterName: firstAdapter,
        remoteAdapters: remoteAdapters,
      );
      // assert
      expect(result, eventFromAdapter);
    });

    test(
        'should return the remote event if it\'s adapter has a higher priority than the existing event',
        () {
      // arrange
      final existingEvent = event.copyWith(
        synced: {
          secondAdapter: true, // <-- a lower priority adapter
        },
        version: 1,
      );
      final eventFromAdapter = event.copyWith(
        synced: {
          firstAdapter: true,
        },
        version: 2,
      );
      final remoteAdapters = {
        firstAdapter: TestAdapter(priority: 1),
        // a lower priority adapter
        secondAdapter: TestAdapter(priority: 0),
      };
      // act
      final result = eventResolver.resolve(
        existingEvent: existingEvent,
        eventFromAdapter: eventFromAdapter,
        remoteAdapterName: firstAdapter,
        remoteAdapters: remoteAdapters,
      );
      // assert
      expect(result, eventFromAdapter);
    });

    test('should throw an error if the adapter for the new event was not found',
        () {
      // arrange
      const nonExistedAdapter = 'non-existed';
      final existingEvent = event.copyWith(
        synced: {
          nonExistedAdapter: true,
        },
        version: 1,
      );
      final remoteAdapters = {
        firstAdapter: TestAdapter(priority: 1),
        secondAdapter: TestAdapter(priority: 0),
      };
      // act
      // assert
      expect(
        () => eventResolver.resolve(
          existingEvent: existingEvent,
          eventFromAdapter: event,
          remoteAdapterName: nonExistedAdapter,
          remoteAdapters: remoteAdapters,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
        'should throw an error if the adapter for the existing event was not found',
        () {
      // arrange
      const nonExistedAdapter = 'non-existed';
      final existingEvent = event.copyWith(
        synced: {
          nonExistedAdapter: true,
        },
        version: 1,
      );
      final remoteAdapters = {
        firstAdapter: TestAdapter(priority: 0),
      };
      // act
      // assert
      expect(
        () => eventResolver.resolve(
          existingEvent: existingEvent,
          eventFromAdapter: event,
          remoteAdapterName: firstAdapter,
          remoteAdapters: remoteAdapters,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
        'should return the existing event if it was synced to a higher priority adapter',
        () {
      // arrange
      final existingEvent = event.copyWith(
        synced: {
          firstAdapter: true, // <-- a higher priority adapter
        },
        version: 1,
      );
      final eventFromAdapter = event.copyWith(
        synced: {
          secondAdapter: true,
        },
        version: 2,
      );
      final remoteAdapters = {
        firstAdapter: TestAdapter(priority: 1),
        secondAdapter: TestAdapter(priority: 0),
      };
      // act
      final result = eventResolver.resolve(
        existingEvent: existingEvent,
        eventFromAdapter: eventFromAdapter,
        remoteAdapterName: firstAdapter,
        remoteAdapters: remoteAdapters,
      );
      // assert
      expect(result, existingEvent);
    });

    test(
        'should return the remote event if it\'s adapters has an equal priority',
        () {
      // arrange
      final existingEvent = event.copyWith(
        synced: {
          firstAdapter: true,
        },
        version: 1,
      );
      final eventFromAdapter = event.copyWith(
        synced: {
          secondAdapter: true,
        },
        version: 2,
      );
      final remoteAdapters = {
        firstAdapter: TestAdapter(priority: 1),
        secondAdapter: TestAdapter(priority: 1),
      };
      // act
      final result = eventResolver.resolve(
        existingEvent: existingEvent,
        eventFromAdapter: eventFromAdapter,
        remoteAdapterName: secondAdapter,
        remoteAdapters: remoteAdapters,
      );
      // assert
      expect(result, eventFromAdapter);
    });
  });
}
