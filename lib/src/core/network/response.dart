import 'package:http/http.dart' as http;

abstract class Response {
  /// The headers returned from the server.
  late final Map<String, String> headers;

  /// The reason phrase associated with the status code.
  late final String? reasonPhrase;

  /// The HTTP status code for this response.
  late final int statusCode;

  /// The body of the response as a string.
  late final String body;

  /// The url that was requested
  late final Uri? url;
}

class ResponseImpl implements Response {
  ResponseImpl(
      this.body,
      this.statusCode, {
        this.headers = const {},
        this.reasonPhrase,
        this.url,
      });

  static ResponseImpl fromHttpResponse(http.Response response) {
    final contentType = response.headers['content-type'];

    // TRICKY: if the server returns empty string content type,
    // we set it to null to get default encoding
    if (contentType != null && contentType.isEmpty) {
      response.headers.remove('content-type');
    }
    return ResponseImpl(
      response.body,
      response.statusCode,
      url: response.request?.url,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    );
  }

  @override
  String body;

  @override
  Map<String, String> headers;

  @override
  String? reasonPhrase;

  @override
  int statusCode;

  @override
  Uri? url;
}
