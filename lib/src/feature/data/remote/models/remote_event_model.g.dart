// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RemoteEventModelImpl _$$RemoteEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RemoteEventModelImpl(
      eventId: json['event_id'] as String,
      streamId: json['stream_id'] as String,
      order: (json['sort_order'] as num).toInt(),
      version: (json['version'] as num).toInt(),
      name: json['action_type'] as String,
      data: json['data'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$RemoteEventModelImplToJson(
        _$RemoteEventModelImpl instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'stream_id': instance.streamId,
      'sort_order': instance.order,
      'version': instance.version,
      'action_type': instance.name,
      'data': instance.data,
      'created_at': instance.createdAt.toIso8601String(),
    };
