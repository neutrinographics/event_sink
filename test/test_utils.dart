import 'package:dartz/dartz.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/core/error/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

/// Tests that the result is a failure of type [T].
/// Failures are always passed to the [Left] side of an [Either] object,
/// so this will check that result is a [Left] and that it's value is a [T].
///
/// Example:
///
/// `expectFailure<ServerFailure>(result);`
///
void expectFailure<F extends Failure>(Either result) {
  expect(result, isA<Left>());
  late dynamic failure;
  result.fold((l) => failure = l, (r) => null);
  expect(failure, isA<F>());
}

/// Tests for deep equality in an [Either] that contains a [List].
///
/// Dart cannot accurately test equality if the [Either] contains a list
/// because it will compare the list address,
/// which causes the test to fail even if the lists contain the same data.
/// This method gets around that be testing the equality of the [Either]
/// separately from it's list contents.
expectEitherEqualsList<T extends Either>(
    Either<dynamic, dynamic> result, List<dynamic> expected) {
  result.fold(
    (left) {
      expect(result, isA<T>());
      expect(listEquals(left, expected), equals(true));
    },
    (right) {
      expect(result, isA<T>());
      expect(listEquals(right, expected), equals(true));
    },
  );
}

/// Tests for [events] to be created in the order given.
///
/// This ensures that no other events have been generated.
verifyEventsInOrder(mockEventRepository, List<EventInfo> events) {
  verifyInOrder(events.map((e) => mockEventRepository.add(e)).toList());
  verifyNoMoreInteractions(mockEventRepository);
}
