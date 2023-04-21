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

    /// The time when this event was recorded locally.
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// The time when this event was recorded locally.
    @JsonKey(name: 'remote_created_at') DateTime? remoteCreatedAt,

    /// Indicates the event has already been applied to the aggregate.
    @Default(false) bool applied,

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
  bool get synced {
    return remoteCreatedAt != null;
  }

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.fromRemote({
    required RemoteEventModel remoteEvent,
    required int pool,
  }) {
    return EventModel(
      eventId: remoteEvent.eventId,
      applied: false,
      createdAt: DateTime.now(),
      remoteCreatedAt: remoteEvent.createdAt,
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
      applied: applied,
      name: name,
      pool: pool,
    );
  }
}
