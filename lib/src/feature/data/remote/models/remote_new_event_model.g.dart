// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_new_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RemoteNewEventModelImpl _$$RemoteNewEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RemoteNewEventModelImpl(
      eventId: json['event_id'] as String,
      streamId: json['stream_id'] as String,
      version: (json['version'] as num).toInt(),
      name: json['action_type'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$RemoteNewEventModelImplToJson(
        _$RemoteNewEventModelImpl instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'stream_id': instance.streamId,
      'version': instance.version,
      'action_type': instance.name,
      'data': instance.data,
    };
