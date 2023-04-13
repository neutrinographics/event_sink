// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventModel _$$_EventModelFromJson(Map<String, dynamic> json) =>
    _$_EventModel(
      eventId: json['event_id'] as String,
      remoteId: json['remote_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      applied: json['applied'] as bool? ?? false,
      streamId: json['stream_id'] as String,
      version: json['version'] as int,
      name: json['name'] as String,
      pool: json['pool'] as int,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_EventModelToJson(_$_EventModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'remote_id': instance.remoteId,
      'created_at': instance.createdAt.toIso8601String(),
      'applied': instance.applied,
      'stream_id': instance.streamId,
      'version': instance.version,
      'name': instance.name,
      'pool': instance.pool,
      'data': instance.data,
    };
