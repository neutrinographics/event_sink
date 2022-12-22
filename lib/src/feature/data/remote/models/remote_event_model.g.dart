// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RemoteEventModel _$$_RemoteEventModelFromJson(Map<String, dynamic> json) =>
    _$_RemoteEventModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      streamId: json['stream_id'] as String,
      version: json['version'] as int,
      name: json['name'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RemoteEventModelToJson(_$_RemoteEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'stream_id': instance.streamId,
      'version': instance.version,
      'name': instance.name,
      'data': instance.data,
    };
