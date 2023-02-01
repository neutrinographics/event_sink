// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  /// The local ID of the event
  String get id => throw _privateConstructorUsedError;

  /// The remote id of the event.
  /// This will only have a value if this has been downloaded from the server.
  @JsonKey(name: 'remote_id')
  int? get remoteId => throw _privateConstructorUsedError;

  /// The time when this event was created on the remote host.
  /// This will only have a value if this has been downloaded from the server.
  @JsonKey(name: 'remote_created_at')
  DateTime? get remoteCreatedAt => throw _privateConstructorUsedError;

  /// The time when this event was recorded locally.
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Flag indicating if the event has been merged into the local state
  bool get merged => throw _privateConstructorUsedError;

  /// The ID of the parent stream.
  @JsonKey(name: 'stream_id')
  String get streamId => throw _privateConstructorUsedError;

  /// The version of the stream's state.
  int get version => throw _privateConstructorUsedError;

  /// The unique name of the event.
  String get name => throw _privateConstructorUsedError;

  /// Information specific to the [EventActionType]
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'remote_id') int? remoteId,
      @JsonKey(name: 'remote_created_at') DateTime? remoteCreatedAt,
      @JsonKey(name: 'created_at') DateTime createdAt,
      bool merged,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      String name,
      Map<String, dynamic> data});
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? remoteId = freezed,
    Object? remoteCreatedAt = freezed,
    Object? createdAt = null,
    Object? merged = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as int?,
      remoteCreatedAt: freezed == remoteCreatedAt
          ? _value.remoteCreatedAt
          : remoteCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      merged: null == merged
          ? _value.merged
          : merged // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_EventModelCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$_EventModelCopyWith(
          _$_EventModel value, $Res Function(_$_EventModel) then) =
      __$$_EventModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'remote_id') int? remoteId,
      @JsonKey(name: 'remote_created_at') DateTime? remoteCreatedAt,
      @JsonKey(name: 'created_at') DateTime createdAt,
      bool merged,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      String name,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$_EventModelCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$_EventModel>
    implements _$$_EventModelCopyWith<$Res> {
  __$$_EventModelCopyWithImpl(
      _$_EventModel _value, $Res Function(_$_EventModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? remoteId = freezed,
    Object? remoteCreatedAt = freezed,
    Object? createdAt = null,
    Object? merged = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? data = null,
  }) {
    return _then(_$_EventModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as int?,
      remoteCreatedAt: freezed == remoteCreatedAt
          ? _value.remoteCreatedAt
          : remoteCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      merged: null == merged
          ? _value.merged
          : merged // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$_EventModel extends _EventModel {
  const _$_EventModel(
      {required this.id,
      @JsonKey(name: 'remote_id') this.remoteId,
      @JsonKey(name: 'remote_created_at') this.remoteCreatedAt,
      @JsonKey(name: 'created_at') required this.createdAt,
      this.merged = false,
      @JsonKey(name: 'stream_id') required this.streamId,
      required this.version,
      required this.name,
      required final Map<String, dynamic> data})
      : _data = data,
        super._();

  factory _$_EventModel.fromJson(Map<String, dynamic> json) =>
      _$$_EventModelFromJson(json);

  /// The local ID of the event
  @override
  final String id;

  /// The remote id of the event.
  /// This will only have a value if this has been downloaded from the server.
  @override
  @JsonKey(name: 'remote_id')
  final int? remoteId;

  /// The time when this event was created on the remote host.
  /// This will only have a value if this has been downloaded from the server.
  @override
  @JsonKey(name: 'remote_created_at')
  final DateTime? remoteCreatedAt;

  /// The time when this event was recorded locally.
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Flag indicating if the event has been merged into the local state
  @override
  @JsonKey()
  final bool merged;

  /// The ID of the parent stream.
  @override
  @JsonKey(name: 'stream_id')
  final String streamId;

  /// The version of the stream's state.
  @override
  final int version;

  /// The unique name of the event.
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
    return 'EventModel(id: $id, remoteId: $remoteId, remoteCreatedAt: $remoteCreatedAt, createdAt: $createdAt, merged: $merged, streamId: $streamId, version: $version, name: $name, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.remoteCreatedAt, remoteCreatedAt) ||
                other.remoteCreatedAt == remoteCreatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.merged, merged) || other.merged == merged) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      remoteId,
      remoteCreatedAt,
      createdAt,
      merged,
      streamId,
      version,
      name,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventModelCopyWith<_$_EventModel> get copyWith =>
      __$$_EventModelCopyWithImpl<_$_EventModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventModelToJson(
      this,
    );
  }
}

abstract class _EventModel extends EventModel {
  const factory _EventModel(
      {required final String id,
      @JsonKey(name: 'remote_id') final int? remoteId,
      @JsonKey(name: 'remote_created_at') final DateTime? remoteCreatedAt,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      final bool merged,
      @JsonKey(name: 'stream_id') required final String streamId,
      required final int version,
      required final String name,
      required final Map<String, dynamic> data}) = _$_EventModel;
  const _EventModel._() : super._();

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$_EventModel.fromJson;

  @override

  /// The local ID of the event
  String get id;
  @override

  /// The remote id of the event.
  /// This will only have a value if this has been downloaded from the server.
  @JsonKey(name: 'remote_id')
  int? get remoteId;
  @override

  /// The time when this event was created on the remote host.
  /// This will only have a value if this has been downloaded from the server.
  @JsonKey(name: 'remote_created_at')
  DateTime? get remoteCreatedAt;
  @override

  /// The time when this event was recorded locally.
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override

  /// Flag indicating if the event has been merged into the local state
  bool get merged;
  @override

  /// The ID of the parent stream.
  @JsonKey(name: 'stream_id')
  String get streamId;
  @override

  /// The version of the stream's state.
  int get version;
  @override

  /// The unique name of the event.
  String get name;
  @override

  /// Information specific to the [EventActionType]
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_EventModelCopyWith<_$_EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}