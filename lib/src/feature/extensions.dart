import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:event_sink/src/core/hash_generator.dart';
import 'package:event_sink/src/event_remote_adapter.dart';

import 'data/local/models/event_model.dart';

extension EventModelX on EventModel {
  bool isSyncedWith(String remoteAdapterName) =>
      synced.contains(remoteAdapterName);

  bool isSynced() => synced.isNotEmpty;

  int highestAdapterPriority(Map<String, EventRemoteAdapter> remoteAdapters) {
    if (synced.isEmpty) {
      throw Exception('Event is not synced with any adapter');
    }

    return Map.fromEntries(remoteAdapters.entries.where(
      (entry) => synced.contains(entry.key),
    )).values.map<int>((e) => e.priority).max;
  }

  String asHash(HashGenerator generator) {
    final eventsJson = jsonEncode(
      {
        'eventId': eventId,
        'version': version,
        'order': order,
      },
    );
    return generator.generateHash(eventsJson);
  }
}

extension EventModelsX on Iterable<EventModel> {
  String asHash(HashGenerator generator) {
    final eventsJson = jsonEncode(
      map((e) => {
            'eventId': e.eventId,
            'version': e.version,
            'order': e.order,
          }).toList(),
    );
    return generator.generateHash(eventsJson);
  }
}
