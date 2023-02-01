// Mocks generated by Mockito 5.3.2 from annotations
// in event_sync/test/feature/domain/use_cases/add_event_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:event_sync/event_sync.dart' as _i6;
import 'package:event_sync/src/core/error/failure.dart' as _i5;
import 'package:event_sync/src/feature/domain/entities/event_stub.dart' as _i7;
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
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
  _i4.Future<_i2.Either<_i5.Failure, void>> fetch(
    String? host,
    String? authToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [
            host,
            authToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #fetch,
            [
              host,
              authToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> push(
    String? host,
    String? authToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #push,
          [
            host,
            authToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #push,
            [
              host,
              authToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> rebase() => (super.noSuchMethod(
        Invocation.method(
          #rebase,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #rebase,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> add(
          _i6.EventInfo<_i6.EventParams>? event) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #add,
            [event],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.EventStub>>> list() =>
      (super.noSuchMethod(
        Invocation.method(
          #list,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i7.EventStub>>>.value(
                _FakeEither_0<_i5.Failure, List<_i7.EventStub>>(
          this,
          Invocation.method(
            #list,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.EventStub>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> markReduced(_i7.EventStub? event) =>
      (super.noSuchMethod(
        Invocation.method(
          #markReduced,
          [event],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #markReduced,
            [event],
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
}