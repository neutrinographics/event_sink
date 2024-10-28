// Mocks generated by Mockito 5.4.4 from annotations
// in event_sink/test/feature/data/repositories/event_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:event_sink/event_sink.dart' as _i2;
import 'package:event_sink/src/core/data/id_generator.dart' as _i5;
import 'package:event_sink/src/core/time/time_info.dart' as _i7;
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEventModel_0 extends _i1.SmartFake implements _i2.EventModel {
  _FakeEventModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDateTime_1 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [EventRemoteAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventRemoteAdapter extends _i1.Mock
    implements _i2.EventRemoteAdapter {
  MockEventRemoteAdapter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i2.RemoteEventModel>> pull() => (super.noSuchMethod(
        Invocation.method(
          #pull,
          [],
        ),
        returnValue: _i3.Future<List<_i2.RemoteEventModel>>.value(
            <_i2.RemoteEventModel>[]),
      ) as _i3.Future<List<_i2.RemoteEventModel>>);

  @override
  _i3.Future<List<_i2.RemoteEventModel>> push(
          List<_i2.RemoteNewEventModel>? events) =>
      (super.noSuchMethod(
        Invocation.method(
          #push,
          [events],
        ),
        returnValue: _i3.Future<List<_i2.RemoteEventModel>>.value(
            <_i2.RemoteEventModel>[]),
      ) as _i3.Future<List<_i2.RemoteEventModel>>);
}

/// A class which mocks [EventLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventLocalDataSource extends _i1.Mock
    implements _i4.EventLocalDataSource {
  MockEventLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> addEvent(_i2.EventModel? model) => (super.noSuchMethod(
        Invocation.method(
          #addEvent,
          [model],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> addEvents(List<_i2.EventModel>? models) =>
      (super.noSuchMethod(
        Invocation.method(
          #addEvents,
          [models],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<bool> hasEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #hasEvent,
          [eventId],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<_i2.EventModel> getEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #getEvent,
          [eventId],
        ),
        returnValue: _i3.Future<_i2.EventModel>.value(_FakeEventModel_0(
          this,
          Invocation.method(
            #getEvent,
            [eventId],
          ),
        )),
      ) as _i3.Future<_i2.EventModel>);

  @override
  _i3.Future<void> removeEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #removeEvent,
          [eventId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i2.EventModel>> getAllEvents() => (super.noSuchMethod(
        Invocation.method(
          #getAllEvents,
          [],
        ),
        returnValue: _i3.Future<List<_i2.EventModel>>.value(<_i2.EventModel>[]),
      ) as _i3.Future<List<_i2.EventModel>>);

  @override
  _i3.Future<int> getPoolSize(String? poolId) => (super.noSuchMethod(
        Invocation.method(
          #getPoolSize,
          [poolId],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i2.EventModel>> getPooledEvents(String? poolId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPooledEvents,
          [poolId],
        ),
        returnValue: _i3.Future<List<_i2.EventModel>>.value(<_i2.EventModel>[]),
      ) as _i3.Future<List<_i2.EventModel>>);

  @override
  _i3.Future<List<String>> getPools() => (super.noSuchMethod(
        Invocation.method(
          #getPools,
          [],
        ),
        returnValue: _i3.Future<List<String>>.value(<String>[]),
      ) as _i3.Future<List<String>>);

  @override
  _i3.Future<void> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> clearPool(String? poolId) => (super.noSuchMethod(
        Invocation.method(
          #clearPool,
          [poolId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [IdGenerator].
///
/// See the documentation for Mockito's code generation for more information.
class MockIdGenerator extends _i1.Mock implements _i5.IdGenerator {
  MockIdGenerator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String generateId() => (super.noSuchMethod(
        Invocation.method(
          #generateId,
          [],
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #generateId,
            [],
          ),
        ),
      ) as String);
}

/// A class which mocks [TimeInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimeInfo extends _i1.Mock implements _i7.TimeInfo {
  MockTimeInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  DateTime now() => (super.noSuchMethod(
        Invocation.method(
          #now,
          [],
        ),
        returnValue: _FakeDateTime_1(
          this,
          Invocation.method(
            #now,
            [],
          ),
        ),
      ) as DateTime);
}
