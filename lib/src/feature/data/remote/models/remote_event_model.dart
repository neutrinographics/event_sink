import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_event_model.freezed.dart';

part 'remote_event_model.g.dart';

/// Events are small units of change that can be synchronized to the server.
/// Events can be reduced to produce the current state of an entity in the graph.
@freezed
class RemoteEventModel with _$RemoteEventModel {
  factory RemoteEventModel({
    /// The unique ID of this event
    @JsonKey(name: 'event_id') required String eventId,

    /// The ID of the stream affected by this event.
    @JsonKey(name: 'stream_id') required String streamId,

    /// The order in which the event should be applied
    @JsonKey(name: 'sort_order') required int order,

    /// The version of the stream's state.
    /// This is effectively the number of events that have been added to the
    /// stream indicated by the [streamId].
    required int version,

    /// The name of the event
    @JsonKey(name: 'action_type') required String name,

    /// Custom event data
    required Map<String, dynamic> data,

    /// The time when the event was created on the server
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _RemoteEventModel;

  factory RemoteEventModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteEventModelFromJson(json);
}
