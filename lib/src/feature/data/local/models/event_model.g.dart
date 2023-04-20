// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventModel _$$_EventModelFromJson(Map<String, dynamic> json) =>
    _$_EventModel(
      eventId: json['event_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      remoteCreatedAt: json['remote_created_at'] == null
          ? null
          : DateTime.parse(json['remote_created_at'] as String),
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
      'created_at': instance.createdAt.toIso8601String(),
      'remote_created_at': instance.remoteCreatedAt?.toIso8601String(),
      'applied': instance.applied,
      'stream_id': instance.streamId,
      'version': instance.version,
      'name': instance.name,
      'pool': instance.pool,
      'data': instance.data,
    };
