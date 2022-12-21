import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// This defines a new event.
/// The event commands must be unique
///
/// T is the type of data included in the event.
abstract class EventHandler<P> {
  Future<void> call(String streamId, P params);
}
//
// /// This is event info that can be synced.
// @immutable
// abstract class EventInfo<T> {
//   /// The id of this event stream.
//   /// This should be a UUID.
//   final String streamId;
//   final String name;
//   final T? data;
//
//   const EventInfo({
//     required this.streamId,
//     required this.data,
//     required this.name,
//   })  : assert(streamId != ''),
//         assert(name != '');
// }

// abstract class EventParams extends Equatable {}
