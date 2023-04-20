// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_new_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RemoteNewEventModel _$$_RemoteNewEventModelFromJson(
        Map<String, dynamic> json) =>
    _$_RemoteNewEventModel(
      eventId: json['event_id'] as String,
      streamId: json['stream_id'] as String,
      version: json['version'] as int,
      name: json['action_type'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RemoteNewEventModelToJson(
        _$_RemoteNewEventModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'stream_id': instance.streamId,
      'version': instance.version,
      'action_type': instance.name,
      'data': instance.data,
    };
