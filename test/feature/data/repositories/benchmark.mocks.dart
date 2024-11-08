// Mocks generated by Mockito 5.4.4 from annotations
// in event_sink/test/feature/data/repositories/benchmark.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:event_sink/event_sink.dart' as _i2;
import 'package:event_sink/src/feature/data/remote/data_sources/event_remote_data_source.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeRemoteEventModel_0 extends _i1.SmartFake
    implements _i2.RemoteEventModel {
  _FakeRemoteEventModel_0(
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

/// A class which mocks [EventRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventRemoteDataSource extends _i1.Mock
    implements _i4.EventRemoteDataSource {
  MockEventRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i2.RemoteEventModel>> getEvents({
    required Uri? host,
    required String? token,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEvents,
          [],
          {
            #host: host,
            #token: token,
          },
        ),
        returnValue: _i3.Future<List<_i2.RemoteEventModel>>.value(
            <_i2.RemoteEventModel>[]),
      ) as _i3.Future<List<_i2.RemoteEventModel>>);

  @override
  _i3.Future<_i2.RemoteEventModel> createEvent(
    _i2.RemoteNewEventModel? event, {
    required Uri? host,
    required String? token,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createEvent,
          [event],
          {
            #host: host,
            #token: token,
          },
        ),
        returnValue:
            _i3.Future<_i2.RemoteEventModel>.value(_FakeRemoteEventModel_0(
          this,
          Invocation.method(
            #createEvent,
            [event],
            {
              #host: host,
              #token: token,
            },
          ),
        )),
      ) as _i3.Future<_i2.RemoteEventModel>);
}
