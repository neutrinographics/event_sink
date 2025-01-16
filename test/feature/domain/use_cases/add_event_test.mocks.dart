// Mocks generated by Mockito 5.4.5 from annotations
// in event_sink/test/feature/domain/use_cases/add_event_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:event_sink/src/core/error/failure.dart' as _i5;
import 'package:event_sink/src/event_data.dart' as _i7;
import 'package:event_sink/src/feature/data/local/models/event_model.dart'
    as _i9;
import 'package:event_sink/src/feature/data/local/models/stream_hash.dart'
    as _i10;
import 'package:event_sink/src/feature/domain/entities/event_info.dart' as _i6;
import 'package:event_sink/src/feature/domain/entities/event_stub.dart' as _i8;
import 'package:event_sink/src/feature/domain/repositories/event_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [EventRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventRepository extends _i1.Mock implements _i3.EventRepository {
  MockEventRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> fetch({
    required String? remoteAdapterName,
    required String? pool,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [],
          {
            #remoteAdapterName: remoteAdapterName,
            #pool: pool,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #fetch,
            [],
            {
              #remoteAdapterName: remoteAdapterName,
              #pool: pool,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> push({
    required String? remoteAdapterName,
    required String? pool,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #push,
          [],
          {
            #remoteAdapterName: remoteAdapterName,
            #pool: pool,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #push,
            [],
            {
              #remoteAdapterName: remoteAdapterName,
              #pool: pool,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> rebase(String? pool) =>
      (super.noSuchMethod(
        Invocation.method(
          #rebase,
          [pool],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #rebase,
            [pool],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> add(
    _i6.EventInfo<_i7.EventData>? event,
    String? pool,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [
            event,
            pool,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #add,
            [
              event,
              pool,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.EventStub>>> list(String? pool) =>
      (super.noSuchMethod(
        Invocation.method(
          #list,
          [pool],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i8.EventStub>>>.value(
                _FakeEither_0<_i5.Failure, List<_i8.EventStub>>(
          this,
          Invocation.method(
            #list,
            [pool],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.EventStub>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.EventModel>>> listEvents(
          String? pool) =>
      (super.noSuchMethod(
        Invocation.method(
          #listEvents,
          [pool],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.EventModel>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.EventModel>>(
          this,
          Invocation.method(
            #listEvents,
            [pool],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.EventModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i9.EventModel>> get(String? eventId) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [eventId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i9.EventModel>>.value(
            _FakeEither_0<_i5.Failure, _i9.EventModel>(
          this,
          Invocation.method(
            #get,
            [eventId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i9.EventModel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> markApplied(_i8.EventStub? event) =>
      (super.noSuchMethod(
        Invocation.method(
          #markApplied,
          [event],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #markApplied,
            [event],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> markAppliedList(
          List<_i8.EventStub>? events) =>
      (super.noSuchMethod(
        Invocation.method(
          #markAppliedList,
          [events],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #markAppliedList,
            [events],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> clearCache() => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #clearCache,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> clearPoolCache(String? pool) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearPoolCache,
          [pool],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #clearPoolCache,
            [pool],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> getStreamRootHash(
    String? pool,
    String? streamId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStreamRootHash,
          [
            pool,
            streamId,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #getStreamRootHash,
            [
              pool,
              streamId,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i10.StreamHash>>> listStreamHashes(
    String? pool,
    String? streamId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #listStreamHashes,
          [
            pool,
            streamId,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i10.StreamHash>>>.value(
                _FakeEither_0<_i5.Failure, List<_i10.StreamHash>>(
          this,
          Invocation.method(
            #listStreamHashes,
            [
              pool,
              streamId,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i10.StreamHash>>>);
}
