import 'dart:convert';

import 'package:event_sync/src/core/network/network.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NetworkImpl network;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    network = NetworkImpl(mockClient);
  });

  group('http', () {
    final tUrl = Uri.parse('https://example.com');

    const tSentHeaders = {'hello': 'world'};
    const tSentBody = 'sent';
    final tSentEncoding = Encoding.getByName('utf-8');

    const tResponseBody = 'body';
    const tResponseCode = 200;
    const tResponseHeaders = {'key': 'value'};
    const tReasonPhrase = 'no reason';

    final tResponseFuture = Future.value(http.Response(
      tResponseBody,
      tResponseCode,
      headers: tResponseHeaders,
      reasonPhrase: tReasonPhrase,
    ));

    final tResponseFutureAuthFailure = Future.value(http.Response(
      'Not Authorized',
      403,
    ));

    /// Util to test the result
    void expectRequest(result) {
      expect(result.body, tResponseBody);
      expect(result.statusCode, tResponseCode);
      expect(result.headers, tResponseHeaders);
      expect(result.reasonPhrase, tReasonPhrase);
    }

    group('post', () {
      test(
        'should forward the call to Client.post',
        () async {
          // arrange
          when(mockClient.post(tUrl,
                  body: anyNamed('body'),
                  headers: anyNamed('headers'),
                  encoding: anyNamed('encoding')))
              .thenAnswer((_) => tResponseFuture);
          // act
          final result = await network.post(tUrl,
              headers: tSentHeaders, body: tSentBody, encoding: tSentEncoding);
          // assert
          verify(mockClient.post(
            tUrl,
            headers: tSentHeaders,
            body: tSentBody,
            encoding: tSentEncoding,
          ));
          expectRequest(result);
        },
      );

      test(
        'should throw AuthException if the request is not authorized',
        () async {
          // arrange
          when(mockClient.post(tUrl))
              .thenAnswer((_) => tResponseFutureAuthFailure);
          // act
          final call = network.post;
          // assert
          expect(() => call(tUrl),
              throwsA(const TypeMatcher<NetworkAuthException>()));
          verify(mockClient.post(tUrl));
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // arrange
          when(mockClient.post(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.post;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.post(tUrl));
        },
      );
    });

    group('head', () {
      test(
        'should forward the call to Client.head',
        () async {
          // arrange
          when(mockClient.head(tUrl, headers: anyNamed('headers')))
              .thenAnswer((_) => tResponseFuture);
          // act
          final result = await network.head(tUrl, headers: tSentHeaders);
          // assert
          verify(mockClient.head(tUrl, headers: tSentHeaders));
          expectRequest(result);
        },
      );

      test(
        'should throw AuthException if the request is not authorized',
        () async {
          // arrange
          when(mockClient.head(tUrl))
              .thenAnswer((_) => tResponseFutureAuthFailure);
          // act
          final call = network.head;
          // assert
          expect(() => call(tUrl),
              throwsA(const TypeMatcher<NetworkAuthException>()));
          verify(mockClient.head(tUrl));
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // arrange
          when(mockClient.head(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.head;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.head(tUrl));
        },
      );
    });

    group('get', () {
      test(
        'should forward the call to Client.get',
        () async {
          // arrange
          when(mockClient.get(tUrl, headers: anyNamed('headers')))
              .thenAnswer((_) => tResponseFuture);
          // act
          final result = await network.get(tUrl, headers: tSentHeaders);
          // assert
          verify(mockClient.get(tUrl, headers: tSentHeaders));
          expectRequest(result);
        },
      );
      test(
        'should throw AuthException if the request is not authorized',
        () async {
          // arrange
          when(mockClient.get(tUrl))
              .thenAnswer((_) => tResponseFutureAuthFailure);
          // act
          final call = network.get;
          // assert
          expect(() => call(tUrl),
              throwsA(const TypeMatcher<NetworkAuthException>()));
          verify(mockClient.get(tUrl));
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // arrange
          when(mockClient.get(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.get;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.get(tUrl));
        },
      );
    });

    group('put', () {
      test(
        'should forward the call to Client.put',
        () async {
          // arrange
          when(mockClient.put(tUrl,
                  body: anyNamed('body'),
                  headers: anyNamed('headers'),
                  encoding: anyNamed('encoding')))
              .thenAnswer((_) => tResponseFuture);
          // act
          final result = await network.put(tUrl,
              headers: tSentHeaders, body: tSentBody, encoding: tSentEncoding);
          // assert
          verify(mockClient.put(tUrl,
              body: tSentBody, headers: tSentHeaders, encoding: tSentEncoding));
          expectRequest(result);
        },
      );
      test(
        'should throw AuthException if the request is not authorized',
        () async {
          // arrange
          when(mockClient.put(tUrl))
              .thenAnswer((_) => tResponseFutureAuthFailure);
          // act
          final call = network.put;
          // assert
          expect(() => call(tUrl),
              throwsA(const TypeMatcher<NetworkAuthException>()));
          verify(mockClient.put(tUrl));
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // arrange
          when(mockClient.put(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.put;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.put(tUrl));
        },
      );
    });

    group('patch', () {
      test(
        'should forward the call to Client.patch',
        () async {
          // arrange
          when(mockClient.patch(tUrl,
                  body: anyNamed('body'),
                  headers: anyNamed('headers'),
                  encoding: anyNamed('encoding')))
              .thenAnswer((_) => tResponseFuture);
          // act
          final result = await network.patch(tUrl,
              headers: tSentHeaders, body: tSentBody, encoding: tSentEncoding);
          // assert
          verify(mockClient.patch(tUrl,
              headers: tSentHeaders, body: tSentBody, encoding: tSentEncoding));
          expectRequest(result);
        },
      );
      test(
        'should throw AuthException if the request is not authorized',
        () async {
          // arrange
          when(mockClient.patch(tUrl))
              .thenAnswer((_) => tResponseFutureAuthFailure);
          // act
          final call = network.patch;
          // assert
          expect(() => call(tUrl),
              throwsA(const TypeMatcher<NetworkAuthException>()));
          verify(mockClient.patch(tUrl));
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // arrange
          when(mockClient.patch(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.patch;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.patch(tUrl));
        },
      );
    });

    group('delete', () {
      test(
        'should forward the call to Client.delete',
        () async {
          // arrange
          when(mockClient.delete(tUrl,
                  body: anyNamed('body'),
                  headers: anyNamed('headers'),
                  encoding: anyNamed('encoding')))
              .thenAnswer((_) => tResponseFuture);
          // act
          final result = await network.delete(tUrl,
              headers: tSentHeaders, body: tSentBody, encoding: tSentEncoding);
          // assert
          verify(mockClient.delete(tUrl,
              headers: tSentHeaders, body: tSentBody, encoding: tSentEncoding));
          expectRequest(result);
        },
      );
      test(
        'should throw AuthException if the request is not authorized',
        () async {
          // arrange
          when(mockClient.delete(tUrl))
              .thenAnswer((_) => tResponseFutureAuthFailure);
          // act
          final call = network.delete;
          // assert
          expect(() => call(tUrl),
              throwsA(const TypeMatcher<NetworkAuthException>()));
          verify(mockClient.delete(tUrl));
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // arrange
          when(mockClient.delete(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.delete;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.delete(tUrl));
        },
      );
    });

    group('read', () {
      test(
        'should forward the call to Client.read',
        () async {
          // arrange
          final tFuture = Future.value(tResponseBody);
          when(mockClient.read(tUrl, headers: anyNamed('headers')))
              .thenAnswer((_) => tFuture);
          // act
          final result = await network.read(tUrl, headers: tSentHeaders);
          // assert
          verify(mockClient.read(tUrl, headers: tSentHeaders));
          expect(result, tResponseBody);
        },
      );

      test(
        'should throw NetworkException if the request fails',
        () async {
          // TRICKY: `read` will return a string, and any non-successful
          // response code will raise an exception.

          // arrange
          when(mockClient.read(tUrl)).thenThrow((_) => Exception());
          // act
          final call = network.read;
          // assert
          expect(
            () => call(tUrl),
            throwsA(const TypeMatcher<NetworkException>()),
          );
          verify(mockClient.read(tUrl));
        },
      );
    });
  });
}
