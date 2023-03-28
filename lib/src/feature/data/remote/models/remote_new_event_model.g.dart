// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_new_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RemoteNewEventModel _$$_RemoteNewEventModelFromJson(
        Map<String, dynamic> json) =>
    _$_RemoteNewEventModel(
      streamId: json['stream_id'] as String,
      version: json['version'] as int,
      name: json['name'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RemoteNewEventModelToJson(
        _$_RemoteNewEventModel instance) =>
    <String, dynamic>{
      'stream_id': instance.streamId,
      'version': instance.version,
      'name': instance.name,
      'data': instance.data,
    };
