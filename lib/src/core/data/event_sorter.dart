import 'package:collection/collection.dart';
import 'package:event_sink/event_sink.dart';
import 'package:event_sink/src/feature/extensions.dart';

abstract class EventSorter {
  /// Sorts the list of events by:
  /// - [EventModel] synced property
  /// - [EventRemoteAdapter] priority
  /// - [EventModel] order
  List<EventModel> sort(
    List<EventModel> events,
    Map<String, EventRemoteAdapter> remoteAdapters,
  );
}

class EventSorterImpl implements EventSorter {
  @override
  List<EventModel> sort(
    List<EventModel> events,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) {
    events.sort(
      (a, b) {
        final aSynced = a.isSynced();
        final bSynced = b.isSynced();

        // place synced events in front
        if (aSynced && !bSynced) {
          return -1;
        }
        if (!aSynced && bSynced) {
          return 1;
        }

        // sort synced events by order
        if (aSynced && bSynced) {
          // place higher priority synced events in front
          final aPriority = Map.fromEntries(remoteAdapters.entries.where(
            (entry) => a.synced.containsKey(entry.key),
          )).values.map<int>((e) => e.priority).max;
          final bPriority = Map.fromEntries(remoteAdapters.entries.where(
            (entry) => b.synced.containsKey(entry.key),
          )).values.map<int>((e) => e.priority).max;

          final priorityCompare = -aPriority.compareTo(bPriority);
          if (priorityCompare == 0) {
            return a.order.compareTo(b.order);
          }

          return priorityCompare;
        }

        // sort un-synced events by order
        if (!aSynced && !bSynced) {
          return a.order.compareTo(b.order);
        }

        return a.createdAt.compareTo(b.createdAt);
      },
    );

    return events;
  }
}
