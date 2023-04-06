import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';

part 'event_model.g.dart';

/// Represents a event
@freezed
class EventModel with _$EventModel {
  // Needed to allow for toDomain()
  // See https://pub.dev/packages/freezed#custom-getters-and-methods
  const EventModel._();

  const factory EventModel({
    /// The local ID of the event
    required String id,

    /// The remote id of the event.
    /// This will only have a value if this has been downloaded from the server.
    @JsonKey(name: 'remote_id') int? remoteId,

    /// The time when this event was created on the remote host.
    /// This will only have a value if this has been downloaded from the server.
    @JsonKey(name: 'remote_created_at') DateTime? remoteCreatedAt,

    /// The time when this event was recorded locally.
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// Flag indicating if the event has been merged into the local state
    @Default(false) bool merged,

    /// The ID of the parent stream.
    @JsonKey(name: 'stream_id') required String streamId,

    /// The version of the stream's state.
    required int version,

    /// The unique name of the event.
    required String name,

    /// Custom event data
    required Map<String, dynamic> data,
  }) = _EventModel;

  /// A convenience method to check if this event has been synced with the server.
  /// This is more readable than checking if the remote id is not null.
  bool get synced {
    return remoteId != null;
  }

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.fromRemote({
    required RemoteEventModel remoteEvent,
    required String id,
  }) {
    return EventModel(
      id: id,
      remoteId: remoteEvent.id,
      remoteCreatedAt: remoteEvent.createdAt,
      merged: false,
      createdAt: DateTime.now(),
      streamId: remoteEvent.streamId,
      version: remoteEvent.version,
      data: remoteEvent.data,
      name: remoteEvent.name,
    );
  }

  RemoteNewEventModel toNewRemote() {
    return RemoteNewEventModel(
      streamId: streamId,
      version: version,
      name: name,
      data: data,
    );
  }

  EventStub toDomain() {
    return EventStub(
      id: id,
      version: version,
      streamId: streamId,
      data: data,
      merged: merged,
      name: name,
    );
  }
}
