import 'package:event_sink/src/core/error/exception.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';

abstract class EventRemoteDataSource {
  /// Returns a sorted list of events from the server.
  ///
  /// Throws a [ServerException] if the download fails.
  Future<List<RemoteEventModel>> getEvents({
    required String? token,
  });

  /// Uploads a [RemoteNewEventModel] to the server.
  /// Returns the newly created remote event.
  ///
  /// Throws [ServerException] if the upload fails.
  Future<RemoteEventModel> createEvent(
    RemoteNewEventModel event, {
    required String? token,
  });
}
