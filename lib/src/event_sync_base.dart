import 'package:event_sync/event_sync.dart';
import 'package:meta/meta.dart';
import 'injection_container.dart' as ic;

/// Defines the logic for interacting with the event controller.
abstract class EventSyncBase {
  Map<String, EventHandler> get eventHandlersMap;

  late NetworkController _networkController;

  List<EventInfo> events = [];

  @mustCallSuper
  EventSyncBase({NetworkController? networkController}) {
    ic.init();
    _networkController = networkController ?? ic.sl<NetworkController>();
    print('The event sync base is ready');
    // TODO: create the sync controller here
  }

  /// Adds an event to the queue.
  void add(EventInfo event) {
    // TODO: finish implementing this
    events.add(event);
  }

  /// Applies any un-processed events.
  /// This executes the event command.
  Future<void> apply() async {
    // TODO: get a list of the un-processed events
    // final List<EventInfo> events = [];

    for (final event in events) {
      await eventHandlersMap[event.name]!(event.streamId, event.data);
    }
  }

  /// Compacts all of the event streams.
  /// This will attempt to combine and deduplicate events
  /// within individual streams.
  Future<void> compact() async {
    // TODO: implement this
    throw UnimplementedError();
  }
}
