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

        if (aSynced && !bSynced) {
          return -1;
        }
        if (!aSynced && bSynced) {
          return 1;
        }

        if (aSynced && bSynced) {
          final aPriority = _getHighestPriority(a, remoteAdapters);
          final bPriority = _getHighestPriority(b, remoteAdapters);

          final priorityCompare = -aPriority.compareTo(bPriority);
          final orderCompare = a.order.compareTo(b.order);

          if (priorityCompare == 0 && orderCompare == 0) {
            return -a.createdAt.compareTo(b.createdAt);
          }

          if (priorityCompare == 0) {
            return orderCompare;
          }

          return priorityCompare;
        }

        if (!aSynced && !bSynced) {
          final orderCompare = a.order.compareTo(b.order);

          if (orderCompare == 0) {
            return -a.createdAt.compareTo(b.createdAt);
          }

          return orderCompare;
        }

        return 0;
      },
    );

    return events;
  }

  int _getHighestPriority(
    EventModel event,
    Map<String, EventRemoteAdapter> remoteAdapters,
  ) {
    return Map.fromEntries(remoteAdapters.entries.where(
      (entry) => event.synced.containsKey(entry.key),
    )).values.map<int>((e) => e.priority).max;
  }
}
