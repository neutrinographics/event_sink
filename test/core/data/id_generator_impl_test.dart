import 'package:event_sink/src/core/data/id_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'id_generator_impl_test.mocks.dart';

@GenerateMocks([Uuid])
void main() {
  late IdGeneratorImpl generator;
  late MockUuid mockUuid;

  setUp(() {
    mockUuid = MockUuid();
    generator = IdGeneratorImpl(
      mockUuid,
    );
  });

  group('generateId', () {
    String tResult = 'unique';
    test(
      'should create an id',
      () async {
        // arrange
        when(mockUuid.v4(options: anyNamed('options'))).thenAnswer(
          (_) => tResult,
        );
        // act
        final result = generator.generateId();
        // assert
        verify(mockUuid.v4(options: anyNamed('options')));
        verifyNoMoreInteractions(mockUuid);
        expect(result, equals(tResult));
      },
    );
  });
}
