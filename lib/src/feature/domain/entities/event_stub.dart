import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_stub.freezed.dart';

/// Represents an [Event] that has already been cached locally.
/// This is designed to be used when reducing events into the aggregate graph state.
@freezed
class EventStub with _$EventStub {
  factory EventStub({
    /// The local ID of the event.
    required String eventId,

    /// The id of the stream being modified
    required String streamId,

    /// The name of the event
    required String name,
    required int pool,

    /// The stream version
    required int version,

    /// Indicates the event has already been applied to the aggregate.
    required bool applied,

    /// The data needed to perform the action
    required Map<String, dynamic> data,
  }) = _EventStub;
}
