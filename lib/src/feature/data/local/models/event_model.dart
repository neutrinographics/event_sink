import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';

part 'event_model.g.dart';

/// Represents a event
@freezed
class EventModel with _$EventModel {
  const EventModel._();

  const factory EventModel({
    /// The unique ID of the event
    @JsonKey(name: 'event_id') required String eventId,

    /// The remote id of the event.
    /// This will only have a value if this has been downloaded from the server.
    @JsonKey(name: 'remote_id') int? remoteId,

    /// The time when this event was recorded locally.
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// Flag indicating if the event has been merged into the local state
    @Default(false) bool merged,

    /// The ID of the stream being manipulated by this event.
    @JsonKey(name: 'stream_id') required String streamId,

    /// The version of the stream's state.
    required int version,

    /// The name of the event.
    required String name,
    required int pool,

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
    required int pool,
  }) {
    return EventModel(
      eventId: remoteEvent.eventId,
      remoteId: remoteEvent.id,
      merged: false,
      createdAt: DateTime.now(),
      streamId: remoteEvent.streamId,
      version: remoteEvent.version,
      data: remoteEvent.data,
      name: remoteEvent.name,
      pool: pool,
    );
  }

  RemoteNewEventModel toNewRemote() {
    return RemoteNewEventModel(
      eventId: eventId,
      streamId: streamId,
      version: version,
      name: name,
      data: data,
    );
  }

  EventStub toDomain() {
    return EventStub(
      eventId: eventId,
      version: version,
      streamId: streamId,
      data: data,
      merged: merged,
      name: name,
      pool: pool,
    );
  }
}
