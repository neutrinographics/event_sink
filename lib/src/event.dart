import 'package:equatable/equatable.dart';

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
/// The event commands must be unique
///
/// T is the type of data included in the event.
class Event {
  final Command command;

  const Event({
    required this.command,
  });
}
