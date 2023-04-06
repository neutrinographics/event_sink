import 'package:clock/clock.dart';
import 'package:event_sink/src/core/time/time_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'time_info_test.mocks.dart';

@GenerateMocks([Clock])
main() {
  late TimeInfoImpl timeInfo;
  late MockClock mockClock;

  setUp(() {
    mockClock = MockClock();
    timeInfo = TimeInfoImpl(mockClock);
  });

  group('now', () {
    test(
      'should forward the call to DateTime.now',
      () async {
        // arrange
        final tTime = DateTime.now();
        when(mockClock.now()).thenReturn(tTime);
        // act
        final result = timeInfo.now();
        // assert
        verify(mockClock.now());
        expect(result, tTime);
      },
    );
  });
}
