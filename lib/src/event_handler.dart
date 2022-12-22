import 'package:event_sync/src/event_params.dart';

/// Defines how an event should be handled locally.
/// For example, after creating a new event, the local database can be updated
/// to reflect the changes in the event.
abstract class EventHandler<P extends EventParams> {
  const EventHandler();

  Future<void> call(String streamId, P params);
}
