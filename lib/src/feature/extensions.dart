import 'data/local/models/event_model.dart';

extension EventModelX on EventModel {
  bool isSyncedWith(String remoteAdapterName) =>
      synced[remoteAdapterName] ?? false;

  bool isSynced() => synced.values.any((element) => element);
}
