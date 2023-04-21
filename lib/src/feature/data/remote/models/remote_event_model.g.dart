// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RemoteEventModel _$$_RemoteEventModelFromJson(Map<String, dynamic> json) =>
    _$_RemoteEventModel(
      eventId: json['event_id'] as String,
      streamId: json['stream_id'] as String,
      order: json['sort_order'] as int,
      version: json['version'] as int,
      name: json['action_type'] as String,
      data: json['data'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_RemoteEventModelToJson(_$_RemoteEventModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'stream_id': instance.streamId,
      'sort_order': instance.order,
      'version': instance.version,
      'action_type': instance.name,
      'data': instance.data,
      'created_at': instance.createdAt.toIso8601String(),
    };
