import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_event_model.freezed.dart';

part 'remote_event_model.g.dart';

/// Events are small units of change that can be synchronized to the server.
/// Events can be reduced to produce the current state of an entity in the graph.
@freezed
class RemoteEventModel with _$RemoteEventModel {
  factory RemoteEventModel({
    /// The remote ID of the event.
    /// This will only have a value when downloaded from the server
    int? id,

    /// The remote creation time.
    /// This will only have a value when downloaded from the server.
    @JsonKey(name: 'created_at') DateTime? createdAt,

    /// The ID of the parent stream.
    @JsonKey(name: 'stream_id') required String streamId,

    /// The version of the stream's state.
    required int version,

    /// The name of the event
    required String name,

    /// Information specific to the [EventActionType]
    required Map<String, dynamic> data,
  }) = _RemoteEventModel;

  factory RemoteEventModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteEventModelFromJson(json);
}
