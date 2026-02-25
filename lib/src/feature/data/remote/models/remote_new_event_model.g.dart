// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_new_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteNewEventModel _$RemoteNewEventModelFromJson(Map<String, dynamic> json) =>
    _RemoteNewEventModel(
      eventId: json['event_id'] as String,
      streamId: json['stream_id'] as String,
      version: (json['version'] as num).toInt(),
      name: json['action_type'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RemoteNewEventModelToJson(
  _RemoteNewEventModel instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'stream_id': instance.streamId,
  'version': instance.version,
  'action_type': instance.name,
  'data': instance.data,
};
