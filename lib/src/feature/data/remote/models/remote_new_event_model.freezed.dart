// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_new_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RemoteNewEventModel _$RemoteNewEventModelFromJson(Map<String, dynamic> json) {
  return _RemoteNewEventModel.fromJson(json);
}

/// @nodoc
mixin _$RemoteNewEventModel {
  /// The unique ID of this event
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;

  /// The ID of the stream affected by this event.
  @JsonKey(name: 'stream_id')
  String get streamId => throw _privateConstructorUsedError;

  /// The version of the stream's state.
  /// This is effectively the number of events that have been added to the
  /// stream indicated by the [streamId].
  int get version => throw _privateConstructorUsedError;

  /// The name of the event
  @JsonKey(name: 'action_type')
  String get name => throw _privateConstructorUsedError;

  /// The time when the event was created.
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Custom event data
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemoteNewEventModelCopyWith<RemoteNewEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteNewEventModelCopyWith<$Res> {
  factory $RemoteNewEventModelCopyWith(
          RemoteNewEventModel value, $Res Function(RemoteNewEventModel) then) =
      _$RemoteNewEventModelCopyWithImpl<$Res, RemoteNewEventModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      @JsonKey(name: 'action_type') String name,
      @JsonKey(name: 'created_at') DateTime createdAt,
      Map<String, dynamic> data});
}

/// @nodoc
class _$RemoteNewEventModelCopyWithImpl<$Res, $Val extends RemoteNewEventModel>
    implements $RemoteNewEventModelCopyWith<$Res> {
  _$RemoteNewEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? createdAt = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemoteNewEventModelImplCopyWith<$Res>
    implements $RemoteNewEventModelCopyWith<$Res> {
  factory _$$RemoteNewEventModelImplCopyWith(_$RemoteNewEventModelImpl value,
          $Res Function(_$RemoteNewEventModelImpl) then) =
      __$$RemoteNewEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'stream_id') String streamId,
      int version,
      @JsonKey(name: 'action_type') String name,
      @JsonKey(name: 'created_at') DateTime createdAt,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$RemoteNewEventModelImplCopyWithImpl<$Res>
    extends _$RemoteNewEventModelCopyWithImpl<$Res, _$RemoteNewEventModelImpl>
    implements _$$RemoteNewEventModelImplCopyWith<$Res> {
  __$$RemoteNewEventModelImplCopyWithImpl(_$RemoteNewEventModelImpl _value,
      $Res Function(_$RemoteNewEventModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? createdAt = null,
    Object? data = null,
  }) {
    return _then(_$RemoteNewEventModelImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoteNewEventModelImpl implements _RemoteNewEventModel {
  _$RemoteNewEventModelImpl(
      {@JsonKey(name: 'event_id') required this.eventId,
      @JsonKey(name: 'stream_id') required this.streamId,
      required this.version,
      @JsonKey(name: 'action_type') required this.name,
      @JsonKey(name: 'created_at') required this.createdAt,
      required final Map<String, dynamic> data})
      : _data = data;

  factory _$RemoteNewEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoteNewEventModelImplFromJson(json);

  /// The unique ID of this event
  @override
  @JsonKey(name: 'event_id')
  final String eventId;

  /// The ID of the stream affected by this event.
  @override
  @JsonKey(name: 'stream_id')
  final String streamId;

  /// The version of the stream's state.
  /// This is effectively the number of events that have been added to the
  /// stream indicated by the [streamId].
  @override
  final int version;

  /// The name of the event
  @override
  @JsonKey(name: 'action_type')
  final String name;

  /// The time when the event was created.
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

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
    return 'RemoteNewEventModel(eventId: $eventId, streamId: $streamId, version: $version, name: $name, createdAt: $createdAt, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteNewEventModelImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, eventId, streamId, version, name,
      createdAt, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteNewEventModelImplCopyWith<_$RemoteNewEventModelImpl> get copyWith =>
      __$$RemoteNewEventModelImplCopyWithImpl<_$RemoteNewEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoteNewEventModelImplToJson(
      this,
    );
  }
}

abstract class _RemoteNewEventModel implements RemoteNewEventModel {
  factory _RemoteNewEventModel(
      {@JsonKey(name: 'event_id') required final String eventId,
      @JsonKey(name: 'stream_id') required final String streamId,
      required final int version,
      @JsonKey(name: 'action_type') required final String name,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      required final Map<String, dynamic> data}) = _$RemoteNewEventModelImpl;

  factory _RemoteNewEventModel.fromJson(Map<String, dynamic> json) =
      _$RemoteNewEventModelImpl.fromJson;

  @override

  /// The unique ID of this event
  @JsonKey(name: 'event_id')
  String get eventId;
  @override

  /// The ID of the stream affected by this event.
  @JsonKey(name: 'stream_id')
  String get streamId;
  @override

  /// The version of the stream's state.
  /// This is effectively the number of events that have been added to the
  /// stream indicated by the [streamId].
  int get version;
  @override

  /// The name of the event
  @JsonKey(name: 'action_type')
  String get name;
  @override

  /// The time when the event was created.
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override

  /// Custom event data
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$RemoteNewEventModelImplCopyWith<_$RemoteNewEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
