import 'package:collection/collection.dart';
import 'package:event_sink/src/event_remote_adapter.dart';

import 'data/local/models/event_model.dart';

extension EventModelX on EventModel {
  bool isSyncedWith(String remoteAdapterName) =>
      synced[remoteAdapterName] ?? false;

  bool isSynced() => synced.values.any((element) => element);

  int highestAdapterPriority(Map<String, EventRemoteAdapter> remoteAdapters) {
    if (synced.isEmpty) {
      throw Exception('Event is not synced with any adapter');
    }

    return Map.fromEntries(remoteAdapters.entries.where(
      (entry) => synced.containsKey(entry.key),
    )).values.map<int>((e) => e.priority).max;
  }
}
