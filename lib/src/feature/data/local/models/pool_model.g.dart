// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PoolModelImplAdapter extends TypeAdapter<_$PoolModelImpl> {
  @override
  final int typeId = 2;

  @override
  _$PoolModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$PoolModelImpl(
      id: fields[0] as int,
      eventIds: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$PoolModelImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.eventIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoolModelImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
