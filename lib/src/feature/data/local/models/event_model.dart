import 'package:event_sink/src/core/hash_generator.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sink/src/feature/data/remote/models/remote_new_event_model.dart';
import 'package:event_sink/src/feature/domain/entities/event_stub.dart';
import 'package:event_sink/src/feature/extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

/// Represents a event
@freezed
class EventModel extends HiveObject with _$EventModel {
  EventModel._();

  @HiveType(typeId: 1)
  factory EventModel({
    /// The unique identifier for the event.
    @JsonKey(name: 'event_id') @HiveField(0) required String eventId,

    /// The order in which the event should be applied.
    @JsonKey(name: 'sort_order') @HiveField(1) required int order,

    /// List of remote adapters that have synced this event.
    @HiveField(2) @Default(<String>[]) List<String> synced,

    /// Indicates the event has already been applied to the local aggregate.
    @HiveField(3) @Default(false) bool applied,

    /// The ID of the stream being manipulated by this event.
    @JsonKey(name: 'stream_id') @HiveField(4) required String streamId,

    /// The version of the stream's state.
    @HiveField(5) required int version,

    /// The name of the event.
    @HiveField(6) required String name,

    /// The pool to which the event belongs.
    @HiveField(7) required String pool,
    @JsonKey(name: 'created_at') @HiveField(8) required DateTime createdAt,

    /// Custom event data
    @HiveField(9) required Map<String, dynamic> data,
  }) = _EventModel;

  /// The hash of the event
  String hash(HashGenerator generator) => asHash(generator);

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.fromRemote({
    required RemoteEventModel remoteEvent,
    required String pool,
    required String remoteAdapterName,
  }) {
    return EventModel(
      eventId: remoteEvent.eventId,
      applied: false,
      createdAt: remoteEvent.createdAt,
      streamId: remoteEvent.streamId,
      version: remoteEvent.version,
      synced: [remoteAdapterName],
      order: remoteEvent.order,
      data: remoteEvent.data,
      name: remoteEvent.name,
      pool: pool,
    );
  }

  RemoteEventModel toRemote() {
    return RemoteEventModel(
      eventId: eventId,
      streamId: streamId,
      version: version,
      order: order,
      name: name,
      data: data,
      createdAt: createdAt,
    );
  }

  RemoteNewEventModel toNewRemote() {
    return RemoteNewEventModel(
      eventId: eventId,
      streamId: streamId,
      version: version,
      createdAt: createdAt,
      name: name,
      data: data,
    );
  }

  EventStub toDomain() {
    return EventStub(
      eventId: eventId,
      version: version,
      streamId: streamId,
      createdAt: createdAt,
      data: data,
      applied: applied,
      name: name,
      pool: pool,
    );
  }
}
