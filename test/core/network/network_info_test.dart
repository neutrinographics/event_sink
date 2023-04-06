import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_sink/src/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.checkConnectivity',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(ConnectivityResult.mobile);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = await networkInfo.isConnected();
        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, true);
      },
    );

    test(
      'should return false if not connected to any network',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(ConnectivityResult.none);
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = await networkInfo.isConnected();
        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, false);
      },
    );
  });
}
