// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventModel _$$_EventModelFromJson(Map<String, dynamic> json) =>
    _$_EventModel(
      id: json['id'] as String,
      remoteId: json['remote_id'] as int?,
      remoteCreatedAt: json['remote_created_at'] == null
          ? null
          : DateTime.parse(json['remote_created_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      merged: json['merged'] as bool? ?? false,
      streamId: json['stream_id'] as String,
      version: json['version'] as int,
      name: json['name'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_EventModelToJson(_$_EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remote_id': instance.remoteId,
      'remote_created_at': instance.remoteCreatedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'merged': instance.merged,
      'stream_id': instance.streamId,
      'version': instance.version,
      'name': instance.name,
      'data': instance.data,
    };
