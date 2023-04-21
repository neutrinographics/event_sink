import 'dart:convert';

import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/core/network/network.dart';
import 'package:event_sink/src/core/network/network_utils.dart';
import 'package:event_sink/src/core/network/response.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';

abstract class EventRemoteDataSource {
  /// Returns a sorted list of events from the server.
  ///
  /// Throws a [ServerException] if the download fails.
  Future<List<RemoteEventModel>> getEvents({
    required Uri host,
    required String? token,
  });

  /// Uploads a [RemoteNewEventModel] to the server.
  /// Returns the newly created remote event.
  ///
  /// Throws [ServerException] if the upload fails.
  Future<RemoteEventModel> createEvent(
    RemoteNewEventModel event, {
    required Uri host,
    required String? token,
  });
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final Network network;

  EventRemoteDataSourceImpl({
    required this.network,
  });

  @override
  Future<RemoteEventModel> createEvent(
    RemoteNewEventModel event, {
    required Uri host,
    required String? token,
  }) async {
    try {
      Response response = await network.post(
        host,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(
          {
            // TODO: support syncing multiple events at a time.
            'events': [event.toJson()]
          },
        ),
      );
      if (response.statusCode != 201) {
        if (_containsVersionError(response)) {
          throw OutOfSyncException(
              message:
                  "${response.statusCode} Error. ${responseMessage(response)}");
        } else {
          throw ServerException(
              message:
                  "${response.statusCode} Error. ${responseMessage(response)}");
        }
      }
      // TRICKY: since we send a single event, we only get one back
      return RemoteEventModel.fromJson(json.decode(response.body)["events"][0]);
    } on ServerException {
      rethrow;
    } catch (e, trace) {
      throw ServerException(message: '$e\n\n$trace');
    }
  }

  @override
  Future<List<RemoteEventModel>> getEvents({
    required Uri host,
    required String? token,
  }) async {
    try {
      Response response = await network.get(
        host,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode != 200) {
        throw ServerException(
            message:
                "${response.statusCode} Error. ${responseMessage(response)}");
      }
      final responseJson = json.decode(response.body);
      final List<dynamic> events = responseJson['events'] as List<dynamic>;
      final remoteEvents =
          events.map((e) => RemoteEventModel.fromJson(e)).toList();
      remoteEvents.sort((a, b) => a.order.compareTo(b.order));
      return remoteEvents;
    } on ServerException {
      rethrow;
    } catch (e, trace) {
      throw ServerException(message: '$e\n\n$trace');
    }
  }

  // Checks if the response contains a version error
  bool _containsVersionError(Response response) {
    try {
      final data = json.decode(response.body);
      return data['param'] == 'version';
    } on Error {
      return false;
    }
  }
}
