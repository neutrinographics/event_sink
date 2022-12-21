import 'dart:async';
import 'dart:convert';
import 'package:event_sync/src/core/network/network_utils.dart';
import 'package:http/http.dart' as http;
import 'package:event_sync/src/core/network/response.dart';

abstract class Network {
  Future<Response> head(
      Uri url, {
        Map<String, String>? headers,
        Duration timeout,

        /// Raises an [NetworkAuthException] if the response code is 403
        bool strictAuth,
      });

  Future<Response> get(
      Uri url, {
        Map<String, String>? headers,
        Duration timeout,

        /// Raises an [NetworkAuthException] if the response code is 403
        bool strictAuth,
      });

  Future<Response> post(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout,

        /// Raises an [NetworkAuthException] if the response code is 403
        bool strictAuth,
      });

  Future<Response> put(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout,

        /// Raises an [NetworkAuthException] if the response code is 403
        bool strictAuth,
      });

  Future<Response> patch(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout,

        /// Raises an [NetworkAuthException] if the response code is 403
        bool strictAuth,
      });

  Future<Response> delete(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout,

        /// Raises an [NetworkAuthException] if the response code is 403
        bool strictAuth,
      });

  Future<String> read(
      Uri url, {
        Map<String, String>? headers,
        Duration timeout,
      });
}

/// This is thrown when a network request fails.
class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() {
    return message;
  }
}

/// This is thrown when the network request is not authorized.
class NetworkAuthException extends NetworkException {
  NetworkAuthException({super.message = ''});

  static NetworkAuthException fromResponse(Response response) {
    return NetworkAuthException(
      message: "${response.statusCode} ${responseMessage(response)}",
    );
  }
}

class NetworkImpl implements Network {
  static const defaultTimeout = Duration(seconds: 10);
  final http.Client client;

  NetworkImpl(this.client);

  @override
  Future<Response> head(
      Uri url, {
        Map<String, String>? headers,
        Duration timeout = defaultTimeout,
        strictAuth = true,
      }) =>
      _requestHandler(
        requester: () => client
            .head(url, headers: headers)
            .timeout(timeout, onTimeout: _timeoutHandler(url, timeout)),
        strictAuth: strictAuth,
      );

  @override
  Future<Response> get(
      Uri url, {
        Map<String, String>? headers,
        Duration timeout = defaultTimeout,
        strictAuth = true,
      }) =>
      _requestHandler(
        requester: () => client
            .get(url, headers: headers)
            .timeout(timeout, onTimeout: _timeoutHandler(url, timeout)),
        strictAuth: strictAuth,
      );

  @override
  Future<Response> post(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout = defaultTimeout,
        strictAuth = true,
      }) =>
      _requestHandler(
        requester: () => client
            .post(url, headers: headers, body: body, encoding: encoding)
            .timeout(timeout, onTimeout: _timeoutHandler(url, timeout)),
        strictAuth: strictAuth,
      );

  @override
  Future<Response> put(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout = defaultTimeout,
        strictAuth = true,
      }) =>
      _requestHandler(
        requester: () => client
            .put(url, headers: headers, body: body, encoding: encoding)
            .timeout(timeout, onTimeout: _timeoutHandler(url, timeout)),
        strictAuth: strictAuth,
      );

  @override
  Future<Response> patch(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout = defaultTimeout,
        strictAuth = true,
      }) =>
      _requestHandler(
        requester: () => client
            .patch(url, headers: headers, body: body, encoding: encoding)
            .timeout(timeout, onTimeout: _timeoutHandler(url, timeout)),
        strictAuth: strictAuth,
      );

  @override
  Future<Response> delete(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        Duration timeout = defaultTimeout,
        strictAuth = true,
      }) =>
      _requestHandler(
        requester: () => client
            .delete(url, headers: headers, body: body, encoding: encoding)
            .timeout(timeout, onTimeout: _timeoutHandler(url, timeout)),
        strictAuth: strictAuth,
      );

  @override
  Future<String> read(
      Uri url, {
        Map<String, String>? headers,
        Duration timeout = defaultTimeout,
      }) {
    // TRICKY: `read` will process the response and return a string result if
    // the response status code is successful. If the response doesn't have a
    // success status code, an exception is raised.
    try {
      return client
          .read(url, headers: headers)
          .timeout(timeout, onTimeout: _timeoutHandler(url, timeout));
    } catch (e, trace) {
      throw NetworkException(message: '$e\n\n$trace');
    }
  }

  _timeoutHandler(Uri url, Duration timeout) {
    return () => throw TimeoutException(
        'Request timed out after ${timeout.inSeconds} seconds while requesting $url.');
  }

  /// Wraps a network request with some standard error handling.
  Future<Response> _requestHandler({
    required Future<http.Response> Function() requester,
    required bool strictAuth,
  }) async {
    final Response response;
    try {
      response = ResponseImpl.fromHttpResponse(await requester());
    } catch (e, trace) {
      // There was a problem performing the network request.
      throw NetworkException(message: '$e\n\n$trace');
    }

    if (strictAuth && response.statusCode == 403) {
      // The request was not authorized.
      throw NetworkAuthException.fromResponse(response);
    }
    return response;
  }
}
