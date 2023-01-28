// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'bool':
      return _ConfigBoolModel.fromJson(json);
    case 'string':
      return _ConfigStringModel.fromJson(json);
    case 'int':
      return _ConfigIntModel.fromJson(json);
    case 'double':
      return _ConfigDoubleModel.fromJson(json);
    case 'date':
      return _ConfigDateModel.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ConfigModel',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ConfigModel {
  ConfigOption get key => throw _privateConstructorUsedError;
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfigOption key, bool value) bool,
    required TResult Function(ConfigOption key, String value) string,
    required TResult Function(ConfigOption key, int value) int,
    required TResult Function(ConfigOption key, double value) double,
    required TResult Function(ConfigOption key, DateTime value) date,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfigOption key, bool value)? bool,
    TResult? Function(ConfigOption key, String value)? string,
    TResult? Function(ConfigOption key, int value)? int,
    TResult? Function(ConfigOption key, double value)? double,
    TResult? Function(ConfigOption key, DateTime value)? date,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfigOption key, bool value)? bool,
    TResult Function(ConfigOption key, String value)? string,
    TResult Function(ConfigOption key, int value)? int,
    TResult Function(ConfigOption key, double value)? double,
    TResult Function(ConfigOption key, DateTime value)? date,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConfigBoolModel value) bool,
    required TResult Function(_ConfigStringModel value) string,
    required TResult Function(_ConfigIntModel value) int,
    required TResult Function(_ConfigDoubleModel value) double,
    required TResult Function(_ConfigDateModel value) date,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConfigBoolModel value)? bool,
    TResult? Function(_ConfigStringModel value)? string,
    TResult? Function(_ConfigIntModel value)? int,
    TResult? Function(_ConfigDoubleModel value)? double,
    TResult? Function(_ConfigDateModel value)? date,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConfigBoolModel value)? bool,
    TResult Function(_ConfigStringModel value)? string,
    TResult Function(_ConfigIntModel value)? int,
    TResult Function(_ConfigDoubleModel value)? double,
    TResult Function(_ConfigDateModel value)? date,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigModelCopyWith<ConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigModelCopyWith<$Res> {
  factory $ConfigModelCopyWith(
          ConfigModel value, $Res Function(ConfigModel) then) =
      _$ConfigModelCopyWithImpl<$Res, ConfigModel>;
  @useResult
  $Res call({ConfigOption key});
}

/// @nodoc
class _$ConfigModelCopyWithImpl<$Res, $Val extends ConfigModel>
    implements $ConfigModelCopyWith<$Res> {
  _$ConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as ConfigOption,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConfigBoolModelCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$_ConfigBoolModelCopyWith(
          _$_ConfigBoolModel value, $Res Function(_$_ConfigBoolModel) then) =
      __$$_ConfigBoolModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConfigOption key, bool value});
}

/// @nodoc
class __$$_ConfigBoolModelCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$_ConfigBoolModel>
    implements _$$_ConfigBoolModelCopyWith<$Res> {
  __$$_ConfigBoolModelCopyWithImpl(
      _$_ConfigBoolModel _value, $Res Function(_$_ConfigBoolModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$_ConfigBoolModel(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as ConfigOption,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConfigBoolModel implements _ConfigBoolModel {
  const _$_ConfigBoolModel(
      {required this.key, required this.value, final String? $type})
      : $type = $type ?? 'bool';

  factory _$_ConfigBoolModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigBoolModelFromJson(json);

  @override
  final ConfigOption key;
  @override
  final bool value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConfigModel.bool(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigBoolModel &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigBoolModelCopyWith<_$_ConfigBoolModel> get copyWith =>
      __$$_ConfigBoolModelCopyWithImpl<_$_ConfigBoolModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfigOption key, bool value) bool,
    required TResult Function(ConfigOption key, String value) string,
    required TResult Function(ConfigOption key, int value) int,
    required TResult Function(ConfigOption key, double value) double,
    required TResult Function(ConfigOption key, DateTime value) date,
  }) {
    return bool(key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfigOption key, bool value)? bool,
    TResult? Function(ConfigOption key, String value)? string,
    TResult? Function(ConfigOption key, int value)? int,
    TResult? Function(ConfigOption key, double value)? double,
    TResult? Function(ConfigOption key, DateTime value)? date,
  }) {
    return bool?.call(key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfigOption key, bool value)? bool,
    TResult Function(ConfigOption key, String value)? string,
    TResult Function(ConfigOption key, int value)? int,
    TResult Function(ConfigOption key, double value)? double,
    TResult Function(ConfigOption key, DateTime value)? date,
    required TResult orElse(),
  }) {
    if (bool != null) {
      return bool(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConfigBoolModel value) bool,
    required TResult Function(_ConfigStringModel value) string,
    required TResult Function(_ConfigIntModel value) int,
    required TResult Function(_ConfigDoubleModel value) double,
    required TResult Function(_ConfigDateModel value) date,
  }) {
    return bool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConfigBoolModel value)? bool,
    TResult? Function(_ConfigStringModel value)? string,
    TResult? Function(_ConfigIntModel value)? int,
    TResult? Function(_ConfigDoubleModel value)? double,
    TResult? Function(_ConfigDateModel value)? date,
  }) {
    return bool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConfigBoolModel value)? bool,
    TResult Function(_ConfigStringModel value)? string,
    TResult Function(_ConfigIntModel value)? int,
    TResult Function(_ConfigDoubleModel value)? double,
    TResult Function(_ConfigDateModel value)? date,
    required TResult orElse(),
  }) {
    if (bool != null) {
      return bool(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigBoolModelToJson(
      this,
    );
  }
}

abstract class _ConfigBoolModel implements ConfigModel {
  const factory _ConfigBoolModel(
      {required final ConfigOption key,
      required final bool value}) = _$_ConfigBoolModel;

  factory _ConfigBoolModel.fromJson(Map<String, dynamic> json) =
      _$_ConfigBoolModel.fromJson;

  @override
  ConfigOption get key;
  @override
  bool get value;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigBoolModelCopyWith<_$_ConfigBoolModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ConfigStringModelCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$_ConfigStringModelCopyWith(_$_ConfigStringModel value,
          $Res Function(_$_ConfigStringModel) then) =
      __$$_ConfigStringModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConfigOption key, String value});
}

/// @nodoc
class __$$_ConfigStringModelCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$_ConfigStringModel>
    implements _$$_ConfigStringModelCopyWith<$Res> {
  __$$_ConfigStringModelCopyWithImpl(
      _$_ConfigStringModel _value, $Res Function(_$_ConfigStringModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$_ConfigStringModel(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as ConfigOption,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConfigStringModel implements _ConfigStringModel {
  const _$_ConfigStringModel(
      {required this.key, required this.value, final String? $type})
      : $type = $type ?? 'string';

  factory _$_ConfigStringModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigStringModelFromJson(json);

  @override
  final ConfigOption key;
  @override
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConfigModel.string(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigStringModel &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigStringModelCopyWith<_$_ConfigStringModel> get copyWith =>
      __$$_ConfigStringModelCopyWithImpl<_$_ConfigStringModel>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfigOption key, bool value) bool,
    required TResult Function(ConfigOption key, String value) string,
    required TResult Function(ConfigOption key, int value) int,
    required TResult Function(ConfigOption key, double value) double,
    required TResult Function(ConfigOption key, DateTime value) date,
  }) {
    return string(key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfigOption key, bool value)? bool,
    TResult? Function(ConfigOption key, String value)? string,
    TResult? Function(ConfigOption key, int value)? int,
    TResult? Function(ConfigOption key, double value)? double,
    TResult? Function(ConfigOption key, DateTime value)? date,
  }) {
    return string?.call(key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfigOption key, bool value)? bool,
    TResult Function(ConfigOption key, String value)? string,
    TResult Function(ConfigOption key, int value)? int,
    TResult Function(ConfigOption key, double value)? double,
    TResult Function(ConfigOption key, DateTime value)? date,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConfigBoolModel value) bool,
    required TResult Function(_ConfigStringModel value) string,
    required TResult Function(_ConfigIntModel value) int,
    required TResult Function(_ConfigDoubleModel value) double,
    required TResult Function(_ConfigDateModel value) date,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConfigBoolModel value)? bool,
    TResult? Function(_ConfigStringModel value)? string,
    TResult? Function(_ConfigIntModel value)? int,
    TResult? Function(_ConfigDoubleModel value)? double,
    TResult? Function(_ConfigDateModel value)? date,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConfigBoolModel value)? bool,
    TResult Function(_ConfigStringModel value)? string,
    TResult Function(_ConfigIntModel value)? int,
    TResult Function(_ConfigDoubleModel value)? double,
    TResult Function(_ConfigDateModel value)? date,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigStringModelToJson(
      this,
    );
  }
}

abstract class _ConfigStringModel implements ConfigModel {
  const factory _ConfigStringModel(
      {required final ConfigOption key,
      required final String value}) = _$_ConfigStringModel;

  factory _ConfigStringModel.fromJson(Map<String, dynamic> json) =
      _$_ConfigStringModel.fromJson;

  @override
  ConfigOption get key;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigStringModelCopyWith<_$_ConfigStringModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ConfigIntModelCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$_ConfigIntModelCopyWith(
          _$_ConfigIntModel value, $Res Function(_$_ConfigIntModel) then) =
      __$$_ConfigIntModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConfigOption key, int value});
}

/// @nodoc
class __$$_ConfigIntModelCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$_ConfigIntModel>
    implements _$$_ConfigIntModelCopyWith<$Res> {
  __$$_ConfigIntModelCopyWithImpl(
      _$_ConfigIntModel _value, $Res Function(_$_ConfigIntModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$_ConfigIntModel(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as ConfigOption,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConfigIntModel implements _ConfigIntModel {
  const _$_ConfigIntModel(
      {required this.key, required this.value, final String? $type})
      : $type = $type ?? 'int';

  factory _$_ConfigIntModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigIntModelFromJson(json);

  @override
  final ConfigOption key;
  @override
  final int value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConfigModel.int(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigIntModel &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigIntModelCopyWith<_$_ConfigIntModel> get copyWith =>
      __$$_ConfigIntModelCopyWithImpl<_$_ConfigIntModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfigOption key, bool value) bool,
    required TResult Function(ConfigOption key, String value) string,
    required TResult Function(ConfigOption key, int value) int,
    required TResult Function(ConfigOption key, double value) double,
    required TResult Function(ConfigOption key, DateTime value) date,
  }) {
    return int(key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfigOption key, bool value)? bool,
    TResult? Function(ConfigOption key, String value)? string,
    TResult? Function(ConfigOption key, int value)? int,
    TResult? Function(ConfigOption key, double value)? double,
    TResult? Function(ConfigOption key, DateTime value)? date,
  }) {
    return int?.call(key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfigOption key, bool value)? bool,
    TResult Function(ConfigOption key, String value)? string,
    TResult Function(ConfigOption key, int value)? int,
    TResult Function(ConfigOption key, double value)? double,
    TResult Function(ConfigOption key, DateTime value)? date,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConfigBoolModel value) bool,
    required TResult Function(_ConfigStringModel value) string,
    required TResult Function(_ConfigIntModel value) int,
    required TResult Function(_ConfigDoubleModel value) double,
    required TResult Function(_ConfigDateModel value) date,
  }) {
    return int(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConfigBoolModel value)? bool,
    TResult? Function(_ConfigStringModel value)? string,
    TResult? Function(_ConfigIntModel value)? int,
    TResult? Function(_ConfigDoubleModel value)? double,
    TResult? Function(_ConfigDateModel value)? date,
  }) {
    return int?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConfigBoolModel value)? bool,
    TResult Function(_ConfigStringModel value)? string,
    TResult Function(_ConfigIntModel value)? int,
    TResult Function(_ConfigDoubleModel value)? double,
    TResult Function(_ConfigDateModel value)? date,
    required TResult orElse(),
  }) {
    if (int != null) {
      return int(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigIntModelToJson(
      this,
    );
  }
}

abstract class _ConfigIntModel implements ConfigModel {
  const factory _ConfigIntModel(
      {required final ConfigOption key,
      required final int value}) = _$_ConfigIntModel;

  factory _ConfigIntModel.fromJson(Map<String, dynamic> json) =
      _$_ConfigIntModel.fromJson;

  @override
  ConfigOption get key;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigIntModelCopyWith<_$_ConfigIntModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ConfigDoubleModelCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$_ConfigDoubleModelCopyWith(_$_ConfigDoubleModel value,
          $Res Function(_$_ConfigDoubleModel) then) =
      __$$_ConfigDoubleModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConfigOption key, double value});
}

/// @nodoc
class __$$_ConfigDoubleModelCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$_ConfigDoubleModel>
    implements _$$_ConfigDoubleModelCopyWith<$Res> {
  __$$_ConfigDoubleModelCopyWithImpl(
      _$_ConfigDoubleModel _value, $Res Function(_$_ConfigDoubleModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$_ConfigDoubleModel(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as ConfigOption,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConfigDoubleModel implements _ConfigDoubleModel {
  const _$_ConfigDoubleModel(
      {required this.key, required this.value, final String? $type})
      : $type = $type ?? 'double';

  factory _$_ConfigDoubleModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigDoubleModelFromJson(json);

  @override
  final ConfigOption key;
  @override
  final double value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConfigModel.double(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigDoubleModel &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigDoubleModelCopyWith<_$_ConfigDoubleModel> get copyWith =>
      __$$_ConfigDoubleModelCopyWithImpl<_$_ConfigDoubleModel>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfigOption key, bool value) bool,
    required TResult Function(ConfigOption key, String value) string,
    required TResult Function(ConfigOption key, int value) int,
    required TResult Function(ConfigOption key, double value) double,
    required TResult Function(ConfigOption key, DateTime value) date,
  }) {
    return double(key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfigOption key, bool value)? bool,
    TResult? Function(ConfigOption key, String value)? string,
    TResult? Function(ConfigOption key, int value)? int,
    TResult? Function(ConfigOption key, double value)? double,
    TResult? Function(ConfigOption key, DateTime value)? date,
  }) {
    return double?.call(key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfigOption key, bool value)? bool,
    TResult Function(ConfigOption key, String value)? string,
    TResult Function(ConfigOption key, int value)? int,
    TResult Function(ConfigOption key, double value)? double,
    TResult Function(ConfigOption key, DateTime value)? date,
    required TResult orElse(),
  }) {
    if (double != null) {
      return double(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConfigBoolModel value) bool,
    required TResult Function(_ConfigStringModel value) string,
    required TResult Function(_ConfigIntModel value) int,
    required TResult Function(_ConfigDoubleModel value) double,
    required TResult Function(_ConfigDateModel value) date,
  }) {
    return double(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConfigBoolModel value)? bool,
    TResult? Function(_ConfigStringModel value)? string,
    TResult? Function(_ConfigIntModel value)? int,
    TResult? Function(_ConfigDoubleModel value)? double,
    TResult? Function(_ConfigDateModel value)? date,
  }) {
    return double?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConfigBoolModel value)? bool,
    TResult Function(_ConfigStringModel value)? string,
    TResult Function(_ConfigIntModel value)? int,
    TResult Function(_ConfigDoubleModel value)? double,
    TResult Function(_ConfigDateModel value)? date,
    required TResult orElse(),
  }) {
    if (double != null) {
      return double(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigDoubleModelToJson(
      this,
    );
  }
}

abstract class _ConfigDoubleModel implements ConfigModel {
  const factory _ConfigDoubleModel(
      {required final ConfigOption key,
      required final double value}) = _$_ConfigDoubleModel;

  factory _ConfigDoubleModel.fromJson(Map<String, dynamic> json) =
      _$_ConfigDoubleModel.fromJson;

  @override
  ConfigOption get key;
  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigDoubleModelCopyWith<_$_ConfigDoubleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ConfigDateModelCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$_ConfigDateModelCopyWith(
          _$_ConfigDateModel value, $Res Function(_$_ConfigDateModel) then) =
      __$$_ConfigDateModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConfigOption key, DateTime value});
}

/// @nodoc
class __$$_ConfigDateModelCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$_ConfigDateModel>
    implements _$$_ConfigDateModelCopyWith<$Res> {
  __$$_ConfigDateModelCopyWithImpl(
      _$_ConfigDateModel _value, $Res Function(_$_ConfigDateModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$_ConfigDateModel(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as ConfigOption,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConfigDateModel implements _ConfigDateModel {
  const _$_ConfigDateModel(
      {required this.key, required this.value, final String? $type})
      : $type = $type ?? 'date';

  factory _$_ConfigDateModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigDateModelFromJson(json);

  @override
  final ConfigOption key;
  @override
  final DateTime value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConfigModel.date(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigDateModel &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigDateModelCopyWith<_$_ConfigDateModel> get copyWith =>
      __$$_ConfigDateModelCopyWithImpl<_$_ConfigDateModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfigOption key, bool value) bool,
    required TResult Function(ConfigOption key, String value) string,
    required TResult Function(ConfigOption key, int value) int,
    required TResult Function(ConfigOption key, double value) double,
    required TResult Function(ConfigOption key, DateTime value) date,
  }) {
    return date(key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfigOption key, bool value)? bool,
    TResult? Function(ConfigOption key, String value)? string,
    TResult? Function(ConfigOption key, int value)? int,
    TResult? Function(ConfigOption key, double value)? double,
    TResult? Function(ConfigOption key, DateTime value)? date,
  }) {
    return date?.call(key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfigOption key, bool value)? bool,
    TResult Function(ConfigOption key, String value)? string,
    TResult Function(ConfigOption key, int value)? int,
    TResult Function(ConfigOption key, double value)? double,
    TResult Function(ConfigOption key, DateTime value)? date,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConfigBoolModel value) bool,
    required TResult Function(_ConfigStringModel value) string,
    required TResult Function(_ConfigIntModel value) int,
    required TResult Function(_ConfigDoubleModel value) double,
    required TResult Function(_ConfigDateModel value) date,
  }) {
    return date(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConfigBoolModel value)? bool,
    TResult? Function(_ConfigStringModel value)? string,
    TResult? Function(_ConfigIntModel value)? int,
    TResult? Function(_ConfigDoubleModel value)? double,
    TResult? Function(_ConfigDateModel value)? date,
  }) {
    return date?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConfigBoolModel value)? bool,
    TResult Function(_ConfigStringModel value)? string,
    TResult Function(_ConfigIntModel value)? int,
    TResult Function(_ConfigDoubleModel value)? double,
    TResult Function(_ConfigDateModel value)? date,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigDateModelToJson(
      this,
    );
  }
}

abstract class _ConfigDateModel implements ConfigModel {
  const factory _ConfigDateModel(
      {required final ConfigOption key,
      required final DateTime value}) = _$_ConfigDateModel;

  factory _ConfigDateModel.fromJson(Map<String, dynamic> json) =
      _$_ConfigDateModel.fromJson;

  @override
  ConfigOption get key;
  @override
  DateTime get value;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigDateModelCopyWith<_$_ConfigDateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
