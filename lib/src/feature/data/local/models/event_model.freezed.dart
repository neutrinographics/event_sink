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
  /// The unique ID of the event
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;

  /// The remote id of the event.
  /// This will only have a value if this has been downloaded from the server.
  @JsonKey(name: 'remote_id')
  int? get remoteId => throw _privateConstructorUsedError;

  /// The time when this event was recorded locally.
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Indicates the event has already been applied to the aggregate.
  bool get applied => throw _privateConstructorUsedError;

  /// The ID of the stream being manipulated by this event.
  @JsonKey(name: 'stream_id')
  String get streamId => throw _privateConstructorUsedError;

  /// The version of the stream's state.
  int get version => throw _privateConstructorUsedError;

  /// The name of the event.
  String get name => throw _privateConstructorUsedError;
  int get pool => throw _privateConstructorUsedError;

  /// Custom event data
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
      {@JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'remote_id') int? remoteId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      bool applied,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      String name,
      int pool,
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
    Object? eventId = null,
    Object? remoteId = freezed,
    Object? createdAt = null,
    Object? applied = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? pool = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      applied: null == applied
          ? _value.applied
          : applied // ignore: cast_nullable_to_non_nullable
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
      pool: null == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as int,
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
      {@JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'remote_id') int? remoteId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      bool applied,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      String name,
      int pool,
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
    Object? eventId = null,
    Object? remoteId = freezed,
    Object? createdAt = null,
    Object? applied = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? pool = null,
    Object? data = null,
  }) {
    return _then(_$_EventModel(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      applied: null == applied
          ? _value.applied
          : applied // ignore: cast_nullable_to_non_nullable
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
      pool: null == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as int,
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
      {@JsonKey(name: 'event_id') required this.eventId,
      @JsonKey(name: 'remote_id') this.remoteId,
      @JsonKey(name: 'created_at') required this.createdAt,
      this.applied = false,
      @JsonKey(name: 'stream_id') required this.streamId,
      required this.version,
      required this.name,
      required this.pool,
      required final Map<String, dynamic> data})
      : _data = data,
        super._();

  factory _$_EventModel.fromJson(Map<String, dynamic> json) =>
      _$$_EventModelFromJson(json);

  /// The unique ID of the event
  @override
  @JsonKey(name: 'event_id')
  final String eventId;

  /// The remote id of the event.
  /// This will only have a value if this has been downloaded from the server.
  @override
  @JsonKey(name: 'remote_id')
  final int? remoteId;

  /// The time when this event was recorded locally.
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Indicates the event has already been applied to the aggregate.
  @override
  @JsonKey()
  final bool applied;

  /// The ID of the stream being manipulated by this event.
  @override
  @JsonKey(name: 'stream_id')
  final String streamId;

  /// The version of the stream's state.
  @override
  final int version;

  /// The name of the event.
  @override
  final String name;
  @override
  final int pool;

  /// Custom event data
  final Map<String, dynamic> _data;

  /// Custom event data
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, remoteId: $remoteId, createdAt: $createdAt, applied: $applied, streamId: $streamId, version: $version, name: $name, pool: $pool, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventModel &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.applied, applied) || other.applied == applied) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      remoteId,
      createdAt,
      applied,
      streamId,
      version,
      name,
      pool,
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
      {@JsonKey(name: 'event_id') required final String eventId,
      @JsonKey(name: 'remote_id') final int? remoteId,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      final bool applied,
      @JsonKey(name: 'stream_id') required final String streamId,
      required final int version,
      required final String name,
      required final int pool,
      required final Map<String, dynamic> data}) = _$_EventModel;
  const _EventModel._() : super._();

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$_EventModel.fromJson;

  @override

  /// The unique ID of the event
  @JsonKey(name: 'event_id')
  String get eventId;
  @override

  /// The remote id of the event.
  /// This will only have a value if this has been downloaded from the server.
  @JsonKey(name: 'remote_id')
  int? get remoteId;
  @override

  /// The time when this event was recorded locally.
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override

  /// Indicates the event has already been applied to the aggregate.
  bool get applied;
  @override

  /// The ID of the stream being manipulated by this event.
  @JsonKey(name: 'stream_id')
  String get streamId;
  @override

  /// The version of the stream's state.
  int get version;
  @override

  /// The name of the event.
  String get name;
  @override
  int get pool;
  @override

  /// Custom event data
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_EventModelCopyWith<_$_EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}
