// Mocks generated by Mockito 5.4.4 from annotations
// in event_sink/test/core/data/event_stream_rebaser_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart'
    as _i3;
import 'package:event_sink/src/feature/data/local/models/event_model.dart'
    as _i2;
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

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

/// A class which mocks [EventLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventLocalDataSource extends _i1.Mock
    implements _i3.EventLocalDataSource {
  MockEventLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> addEvent(_i2.EventModel? model) => (super.noSuchMethod(
        Invocation.method(
          #addEvent,
          [model],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> addEvents(List<_i2.EventModel>? models) =>
      (super.noSuchMethod(
        Invocation.method(
          #addEvents,
          [models],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<bool> hasEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #hasEvent,
          [eventId],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<_i2.EventModel> getEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #getEvent,
          [eventId],
        ),
        returnValue: _i4.Future<_i2.EventModel>.value(_FakeEventModel_0(
          this,
          Invocation.method(
            #getEvent,
            [eventId],
          ),
        )),
      ) as _i4.Future<_i2.EventModel>);

  @override
  _i4.Future<void> removeEvent(String? eventId) => (super.noSuchMethod(
        Invocation.method(
          #removeEvent,
          [eventId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.EventModel>> getAllEvents() => (super.noSuchMethod(
        Invocation.method(
          #getAllEvents,
          [],
        ),
        returnValue: _i4.Future<List<_i2.EventModel>>.value(<_i2.EventModel>[]),
      ) as _i4.Future<List<_i2.EventModel>>);

  @override
  _i4.Future<int> getPoolSize(String? poolId) => (super.noSuchMethod(
        Invocation.method(
          #getPoolSize,
          [poolId],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<List<_i2.EventModel>> getPooledEvents(String? poolId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPooledEvents,
          [poolId],
        ),
        returnValue: _i4.Future<List<_i2.EventModel>>.value(<_i2.EventModel>[]),
      ) as _i4.Future<List<_i2.EventModel>>);

  @override
  _i4.Future<List<String>> getPools() => (super.noSuchMethod(
        Invocation.method(
          #getPools,
          [],
        ),
        returnValue: _i4.Future<List<String>>.value(<String>[]),
      ) as _i4.Future<List<String>>);

  @override
  _i4.Future<void> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> clearPool(String? poolId) => (super.noSuchMethod(
        Invocation.method(
          #clearPool,
          [poolId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String> getStreamRootHash(
    String? poolId,
    String? streamId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStreamRootHash,
          [
            poolId,
            streamId,
          ],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #getStreamRootHash,
            [
              poolId,
              streamId,
            ],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<List<_i6.StreamHash>> listStreamHashes(
    String? poolId,
    String? streamId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #listStreamHashes,
          [
            poolId,
            streamId,
          ],
        ),
        returnValue: _i4.Future<List<_i6.StreamHash>>.value(<_i6.StreamHash>[]),
      ) as _i4.Future<List<_i6.StreamHash>>);
}
