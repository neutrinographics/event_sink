import 'package:event_sync/src/core/network/network_utils.dart';
import 'package:event_sync/src/core/network/response.dart';

/// These exceptions occur when there is a problem in the local data source.
class CacheException implements Exception {
  final String message;

  CacheException({this.message = ''});

  @override
  String toString() {
    return message;
  }
}

/// These exceptions occur when there is a problem with the response from the server.
class ServerException implements Exception {
  final String message;

  ServerException({this.message = ''});

  static ServerException fromResponse(Response response) {
    return ServerException(
      message: "${response.statusCode} ${responseMessage(response)}",
    );
  }

  @override
  String toString() {
    return message;
  }
}
