import 'package:event_sync/event_sync.dart';
import 'package:event_sync/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sync/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sync/src/feature/domain/repositories/event_repository.dart';
import 'package:event_sync/src/sync_controller.dart';
import 'package:meta/meta.dart';
import 'injection_container.dart' as ic;

/// Defines the logic for interacting with the event controller.
abstract class EventSyncBase {
  Map<String, EventHandler> get eventHandlersMap;
  late SyncController _controller;

  List<EventInfo> events = [];

  EventSyncBase() {
    ic.init();
    _controller = ic.sl<SyncController>();
  }

  /// Uploads events to the server that have been generated on this device.
  Future<void> sync() => _controller.sync();

  /// Adds an event to the queue.
  void add(EventInfo event) => _controller.add(event);

  /// Applies any un-processed events.
  /// This executes the event command.
  Future<void> apply() => _controller.apply(eventHandlersMap);

  /// Compacts all of the event streams.
  /// This will attempt to combine and deduplicate events
  /// within individual streams.
  Future<void> compact() async {
    // TODO: implement this
    throw UnimplementedError();
  }
}
