import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/sync_controller.dart';
import 'injection_container.dart' as ic;

typedef EventParamsGenerator = EventParams Function(Map<String, dynamic>);

/// Defines the logic for interacting with the event controller.
abstract class EventSyncBase {
  Map<String, EventHandler> get eventHandlersMap;

  Map<String, EventParamsGenerator> get eventParamsGeneratorMap;

  late SyncController _controller;

  List<EventInfo> events = [];

  EventSyncBase({String? host}) {
    ic.init();
    _controller = ic.sl<SyncController>();
  }

  /// Configures the auth token used for API requests.
  Future<void> setAuth(String token) => throw UnimplementedError();

  /// Uploads events to the server that have been generated on this device.
  Future<void> sync() => _controller.sync();

  /// Adds an event to the queue.
  Future<void> add(EventInfo<EventParams> event) => _controller.add(event);

  /// Applies any un-processed events.
  /// This executes the event command.
  Future<void> apply() =>
      _controller.apply(eventHandlersMap, eventParamsGeneratorMap);

  /// Compacts all of the event streams.
  /// This will attempt to combine and deduplicate events
  /// within individual streams.
  Future<void> compact() async {
    // TODO: implement this
    throw UnimplementedError();
  }
}
