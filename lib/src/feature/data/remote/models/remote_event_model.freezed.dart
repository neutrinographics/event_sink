// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RemoteEventModel _$RemoteEventModelFromJson(Map<String, dynamic> json) {
  return _RemoteEventModel.fromJson(json);
}

/// @nodoc
mixin _$RemoteEventModel {
  /// The remote ID of the event.
  /// This will only have a value when downloaded from the server
  int? get id => throw _privateConstructorUsedError;

  /// The remote creation time.
  /// This will only have a value when downloaded from the server.
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// The ID of the parent stream.
  @JsonKey(name: 'stream_id')
  String get streamId => throw _privateConstructorUsedError;

  /// The version of the stream's state.
  int get version => throw _privateConstructorUsedError;

  /// The name of the event
  String get name => throw _privateConstructorUsedError;

  /// Information specific to the [EventActionType]
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemoteEventModelCopyWith<RemoteEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteEventModelCopyWith<$Res> {
  factory $RemoteEventModelCopyWith(
          RemoteEventModel value, $Res Function(RemoteEventModel) then) =
      _$RemoteEventModelCopyWithImpl<$Res, RemoteEventModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      String name,
      Map<String, dynamic> data});
}

/// @nodoc
class _$RemoteEventModelCopyWithImpl<$Res, $Val extends RemoteEventModel>
    implements $RemoteEventModelCopyWith<$Res> {
  _$RemoteEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      streamId: null == streamId
          ? _value.streamId
          : streamId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RemoteEventModelCopyWith<$Res>
    implements $RemoteEventModelCopyWith<$Res> {
  factory _$$_RemoteEventModelCopyWith(
          _$_RemoteEventModel value, $Res Function(_$_RemoteEventModel) then) =
      __$$_RemoteEventModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      String name,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$_RemoteEventModelCopyWithImpl<$Res>
    extends _$RemoteEventModelCopyWithImpl<$Res, _$_RemoteEventModel>
    implements _$$_RemoteEventModelCopyWith<$Res> {
  __$$_RemoteEventModelCopyWithImpl(
      _$_RemoteEventModel _value, $Res Function(_$_RemoteEventModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? data = null,
  }) {
    return _then(_$_RemoteEventModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      streamId: null == streamId
          ? _value.streamId
          : streamId // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RemoteEventModel implements _RemoteEventModel {
  _$_RemoteEventModel(
      {this.id,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'stream_id') required this.streamId,
      required this.version,
      required this.name,
      required final Map<String, dynamic> data})
      : _data = data;

  factory _$_RemoteEventModel.fromJson(Map<String, dynamic> json) =>
      _$$_RemoteEventModelFromJson(json);

  /// The remote ID of the event.
  /// This will only have a value when downloaded from the server
  @override
  final int? id;

  /// The remote creation time.
  /// This will only have a value when downloaded from the server.
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// The ID of the parent stream.
  @override
  @JsonKey(name: 'stream_id')
  final String streamId;

  /// The version of the stream's state.
  @override
  final int version;

  /// The name of the event
  @override
  final String name;

  /// Information specific to the [EventActionType]
  final Map<String, dynamic> _data;

  /// Information specific to the [EventActionType]
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'RemoteEventModel(id: $id, createdAt: $createdAt, streamId: $streamId, version: $version, name: $name, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteEventModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, streamId, version,
      name, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoteEventModelCopyWith<_$_RemoteEventModel> get copyWith =>
      __$$_RemoteEventModelCopyWithImpl<_$_RemoteEventModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RemoteEventModelToJson(
      this,
    );
  }
}

abstract class _RemoteEventModel implements RemoteEventModel {
  factory _RemoteEventModel(
      {final int? id,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'stream_id') required final String streamId,
      required final int version,
      required final String name,
      required final Map<String, dynamic> data}) = _$_RemoteEventModel;

  factory _RemoteEventModel.fromJson(Map<String, dynamic> json) =
      _$_RemoteEventModel.fromJson;

  @override

  /// The remote ID of the event.
  /// This will only have a value when downloaded from the server
  int? get id;
  @override

  /// The remote creation time.
  /// This will only have a value when downloaded from the server.
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override

  /// The ID of the parent stream.
  @JsonKey(name: 'stream_id')
  String get streamId;
  @override

  /// The version of the stream's state.
  int get version;
  @override

  /// The name of the event
  String get name;
  @override

  /// Information specific to the [EventActionType]
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_RemoteEventModelCopyWith<_$_RemoteEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}