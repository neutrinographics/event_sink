import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/data/local/data_sources/event_local_data_source.dart';
import 'package:event_sink/src/feature/extensions.dart';

abstract class EventStreamRebaseHelper {
  /// Rebase the local event stream with the remote event stream.
  /// This is akin to a git rebase.
  /// The rebase operation will apply the changes from the remote event stream
  /// onto the local event cache.
  Future<void> rebase(
    List<EventModel> events,
    Map<String, EventRemoteAdapter> remoteAdapters,
  );
}

class EventStreamRebaseHelperImpl implements EventStreamRebaseHelper {
  EventStreamRebaseHelperImpl(
    this.eventLocalDataSource,
  );

  final EventLocalDataSource eventLocalDataSource;

  @override
  Future<void> rebase(
    List<EventModel> events,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) async {
    final syncedEvents = <EventModel>[];
    final unSyncedEvents = <EventModel>[];

    // adding events from pool to each respective list
    for (final event in events) {
      if (event.isSynced()) {
        syncedEvents.add(event);
      } else {
        unSyncedEvents.add(event);
      }
    }

    int lastSyncedVersion = 0;

    // process synced events
    final syncedEventsToAdd = <EventModel>[];
    if (syncedEvents.isNotEmpty) {
      final syncedEventByPriorities = groupBy(syncedEvents, (event) {
        return event.highestAdapterPriority(remoteAdapters);
      });
      final sortedSyncedEventByPriorities =
          SplayTreeMap<int, List<EventModel>>.from(
        syncedEventByPriorities,
        (a, b) => -a.compareTo(b),
      );

      final highestPriority = sortedSyncedEventByPriorities.keys.first;
      lastSyncedVersion =
          sortedSyncedEventByPriorities[highestPriority]!.last.version;

      for (final syncedEventsEntry in sortedSyncedEventByPriorities.entries) {
        final isHighestPriorityEntry = syncedEventsEntry.key == highestPriority;
        for (final syncedEvent in syncedEventsEntry.value) {
          final updatedEvent = syncedEvent.copyWith(
            version: isHighestPriorityEntry
                ? lastSyncedVersion
                : lastSyncedVersion + 1,
          );
          syncedEventsToAdd.add(updatedEvent);
          lastSyncedVersion = updatedEvent.version;
        }
      }
    }

    // process un-synced events
    int lastVersion = lastSyncedVersion;
    final unSyncedEventsToAdd = <EventModel>[];
    for (final unSyncedEvent in unSyncedEvents) {
      final updatedEvent = unSyncedEvent.copyWith(
        version: lastVersion + 1,
      );
      unSyncedEventsToAdd.add(updatedEvent);
      lastVersion = updatedEvent.version;
    }

    eventLocalDataSource.addEvents(syncedEventsToAdd);
    eventLocalDataSource.addEvents(unSyncedEventsToAdd);
  }
}
