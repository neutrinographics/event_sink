import 'package:equatable/equatable.dart';
import 'package:event_sync/event_sync.dart';

import 'command.dart';

// part 'event.freezed.dart';
//
// /// Represents a single graph event.
// /// Events represent small units of change on the graph.
// @freezed
// class Event with _$Event {
//   factory Event({
//     /// The id of the stream being modified
//     required String streamId,
//
//     /// The action being performed
//     required EventActionType actionType,
//
//     /// The data needed to perform the action
//     @Default({}) Map<String, dynamic> data,
//   }) = _Event;
// }

/// This defines a new event.
class Event {
  final EventHandler handler;

  const Event({required this.handler});
}
