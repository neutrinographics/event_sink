import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_new_event_model.freezed.dart';

part 'remote_new_event_model.g.dart';

/// Events are small units of change that can be synchronized to the server.
/// Events can be reduced to produce the current state of an entity in the graph.
@freezed
class RemoteNewEventModel with _$RemoteNewEventModel {
  factory RemoteNewEventModel({
    /// The unique ID of this event
    @JsonKey(name: 'event_id') required String eventId,

    /// The ID of the stream affected by this event.
    @JsonKey(name: 'stream_id') required String streamId,

    /// The version of the stream's state.
    /// This is effectively the number of events that have been added to the
    /// stream indicated by the [streamId].
    required int version,

    /// The name of the event
    required String name,

    /// Custom event data
    required Map<String, dynamic> data,
  }) = _RemoteNewEventModel;

  factory RemoteNewEventModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteNewEventModelFromJson(json);
}
