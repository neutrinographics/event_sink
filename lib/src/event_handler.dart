import 'package:event_sync/src/event_params.dart';

/// This defines a new event handler.
abstract class EventHandler<P extends EventParams> {
  const EventHandler();

  Future<void> call(String streamId, P params);
}
