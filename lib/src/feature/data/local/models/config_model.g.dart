// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConfigBoolModel _$$_ConfigBoolModelFromJson(Map<String, dynamic> json) =>
    _$_ConfigBoolModel(
      key: $enumDecode(_$ConfigOptionEnumMap, json['key']),
      value: json['value'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ConfigBoolModelToJson(_$_ConfigBoolModel instance) =>
    <String, dynamic>{
      'key': _$ConfigOptionEnumMap[instance.key]!,
      'value': instance.value,
      'runtimeType': instance.$type,
    };

const _$ConfigOptionEnumMap = {
  ConfigOption.serverHost: 'serverHost',
  ConfigOption.authToken: 'authToken',
  ConfigOption.pin: 'pin',
  ConfigOption.lockTimeout: 'lockTimeout',
};

_$_ConfigStringModel _$$_ConfigStringModelFromJson(Map<String, dynamic> json) =>
    _$_ConfigStringModel(
      key: $enumDecode(_$ConfigOptionEnumMap, json['key']),
      value: json['value'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ConfigStringModelToJson(
        _$_ConfigStringModel instance) =>
    <String, dynamic>{
      'key': _$ConfigOptionEnumMap[instance.key]!,
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_ConfigIntModel _$$_ConfigIntModelFromJson(Map<String, dynamic> json) =>
    _$_ConfigIntModel(
      key: $enumDecode(_$ConfigOptionEnumMap, json['key']),
      value: json['value'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ConfigIntModelToJson(_$_ConfigIntModel instance) =>
    <String, dynamic>{
      'key': _$ConfigOptionEnumMap[instance.key]!,
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_ConfigDoubleModel _$$_ConfigDoubleModelFromJson(Map<String, dynamic> json) =>
    _$_ConfigDoubleModel(
      key: $enumDecode(_$ConfigOptionEnumMap, json['key']),
      value: (json['value'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ConfigDoubleModelToJson(
        _$_ConfigDoubleModel instance) =>
    <String, dynamic>{
      'key': _$ConfigOptionEnumMap[instance.key]!,
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$_ConfigDateModel _$$_ConfigDateModelFromJson(Map<String, dynamic> json) =>
    _$_ConfigDateModel(
      key: $enumDecode(_$ConfigOptionEnumMap, json['key']),
      value: DateTime.parse(json['value'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ConfigDateModelToJson(_$_ConfigDateModel instance) =>
    <String, dynamic>{
      'key': _$ConfigOptionEnumMap[instance.key]!,
      'value': instance.value.toIso8601String(),
      'runtimeType': instance.$type,
    };
