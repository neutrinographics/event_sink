// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelImplAdapter extends TypeAdapter<_$EventModelImpl> {
  @override
  final int typeId = 1;

  @override
  _$EventModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$EventModelImpl(
      eventId: fields[0] as String,
      order: fields[1] as int,
      synced: fields[2] as bool,
      applied: fields[3] as bool,
      streamId: fields[4] as String,
      version: fields[5] as int,
      name: fields[6] as String,
      pool: fields[7] as int,
      createdAt: fields[8] as DateTime,
      data: (fields[9] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$EventModelImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.eventId)
      ..writeByte(1)
      ..write(obj.order)
      ..writeByte(2)
      ..write(obj.synced)
      ..writeByte(3)
      ..write(obj.applied)
      ..writeByte(4)
      ..write(obj.streamId)
      ..writeByte(5)
      ..write(obj.version)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.pool)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      eventId: json['event_id'] as String,
      order: json['sort_order'] as int,
      synced: json['synced'] as bool? ?? false,
      applied: json['applied'] as bool? ?? false,
      streamId: json['stream_id'] as String,
      version: json['version'] as int,
      name: json['name'] as String,
      pool: json['pool'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'sort_order': instance.order,
      'synced': instance.synced,
      'applied': instance.applied,
      'stream_id': instance.streamId,
      'version': instance.version,
      'name': instance.name,
      'pool': instance.pool,
      'created_at': instance.createdAt.toIso8601String(),
      'data': instance.data,
    };
