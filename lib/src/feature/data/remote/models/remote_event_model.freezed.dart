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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RemoteEventModel _$RemoteEventModelFromJson(Map<String, dynamic> json) {
  return _RemoteEventModel.fromJson(json);
}

/// @nodoc
mixin _$RemoteEventModel {
  /// The unique ID of this event
  @JsonKey(name: 'event_id')
  String get eventId => throw _privateConstructorUsedError;

  /// The ID of the stream affected by this event.
  @JsonKey(name: 'stream_id')
  String get streamId => throw _privateConstructorUsedError;

  /// The order in which the event should be applied
  @JsonKey(name: 'sort_order')
  int get order => throw _privateConstructorUsedError;

  /// The version of the stream's state.
  /// This is effectively the number of events that have been added to the
  /// stream indicated by the [streamId].
  int get version => throw _privateConstructorUsedError;

  /// The name of the event
  @JsonKey(name: 'action_type')
  String get name => throw _privateConstructorUsedError;

  /// Custom event data
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// The time when the event was created on the server
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this RemoteEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoteEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'stream_id') String streamId,
      @JsonKey(name: 'sort_order') int order,
      int version,
      @JsonKey(name: 'action_type') String name,
      Map<String, dynamic> data,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$RemoteEventModelCopyWithImpl<$Res, $Val extends RemoteEventModel>
    implements $RemoteEventModelCopyWith<$Res> {
  _$RemoteEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoteEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? streamId = null,
    Object? order = null,
    Object? version = null,
    Object? name = null,
    Object? data = null,
    Object? createdAt = null,
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
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemoteEventModelImplCopyWith<$Res>
    implements $RemoteEventModelCopyWith<$Res> {
  factory _$$RemoteEventModelImplCopyWith(_$RemoteEventModelImpl value,
          $Res Function(_$RemoteEventModelImpl) then) =
      __$$RemoteEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'event_id') String eventId,
      @JsonKey(name: 'stream_id') String streamId,
      @JsonKey(name: 'sort_order') int order,
      int version,
      @JsonKey(name: 'action_type') String name,
      Map<String, dynamic> data,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$RemoteEventModelImplCopyWithImpl<$Res>
    extends _$RemoteEventModelCopyWithImpl<$Res, _$RemoteEventModelImpl>
    implements _$$RemoteEventModelImplCopyWith<$Res> {
  __$$RemoteEventModelImplCopyWithImpl(_$RemoteEventModelImpl _value,
      $Res Function(_$RemoteEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RemoteEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? streamId = null,
    Object? order = null,
    Object? version = null,
    Object? name = null,
    Object? data = null,
    Object? createdAt = null,
  }) {
    return _then(_$RemoteEventModelImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      streamId: null == streamId
          ? _value.streamId
          : streamId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoteEventModelImpl implements _RemoteEventModel {
  _$RemoteEventModelImpl(
      {@JsonKey(name: 'event_id') required this.eventId,
      @JsonKey(name: 'stream_id') required this.streamId,
      @JsonKey(name: 'sort_order') required this.order,
      required this.version,
      @JsonKey(name: 'action_type') required this.name,
      required final Map<String, dynamic> data,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _data = data;

  factory _$RemoteEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoteEventModelImplFromJson(json);

  /// The unique ID of this event
  @override
  @JsonKey(name: 'event_id')
  final String eventId;

  /// The ID of the stream affected by this event.
  @override
  @JsonKey(name: 'stream_id')
  final String streamId;

  /// The order in which the event should be applied
  @override
  @JsonKey(name: 'sort_order')
  final int order;

  /// The version of the stream's state.
  /// This is effectively the number of events that have been added to the
  /// stream indicated by the [streamId].
  @override
  final int version;

  /// The name of the event
  @override
  @JsonKey(name: 'action_type')
  final String name;

  /// Custom event data
  final Map<String, dynamic> _data;

  /// Custom event data
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// The time when the event was created on the server
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'RemoteEventModel(eventId: $eventId, streamId: $streamId, order: $order, version: $version, name: $name, data: $data, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteEventModelImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, eventId, streamId, order,
      version, name, const DeepCollectionEquality().hash(_data), createdAt);

  /// Create a copy of RemoteEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteEventModelImplCopyWith<_$RemoteEventModelImpl> get copyWith =>
      __$$RemoteEventModelImplCopyWithImpl<_$RemoteEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoteEventModelImplToJson(
      this,
    );
  }
}

abstract class _RemoteEventModel implements RemoteEventModel {
  factory _RemoteEventModel(
          {@JsonKey(name: 'event_id') required final String eventId,
          @JsonKey(name: 'stream_id') required final String streamId,
          @JsonKey(name: 'sort_order') required final int order,
          required final int version,
          @JsonKey(name: 'action_type') required final String name,
          required final Map<String, dynamic> data,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$RemoteEventModelImpl;

  factory _RemoteEventModel.fromJson(Map<String, dynamic> json) =
      _$RemoteEventModelImpl.fromJson;

  /// The unique ID of this event
  @override
  @JsonKey(name: 'event_id')
  String get eventId;

  /// The ID of the stream affected by this event.
  @override
  @JsonKey(name: 'stream_id')
  String get streamId;

  /// The order in which the event should be applied
  @override
  @JsonKey(name: 'sort_order')
  int get order;

  /// The version of the stream's state.
  /// This is effectively the number of events that have been added to the
  /// stream indicated by the [streamId].
  @override
  int get version;

  /// The name of the event
  @override
  @JsonKey(name: 'action_type')
  String get name;

  /// Custom event data
  @override
  Map<String, dynamic> get data;

  /// The time when the event was created on the server
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of RemoteEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoteEventModelImplCopyWith<_$RemoteEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
