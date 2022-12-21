import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../command.dart';

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
  final Type command;

  const Event({
    required this.command,
  });
}

/// This is event info that can be synced.
@immutable
abstract class EventInfo<T> {
  /// The id of this event stream.
  /// This should be a UUID.
  final String streamId;
  final String name;
  final T? data;

  const EventInfo({
    required this.streamId,
    required this.data,
    required this.name,
  })  : assert(streamId != ''),
        assert(name != '');
}

abstract class EventParams extends Equatable {}
