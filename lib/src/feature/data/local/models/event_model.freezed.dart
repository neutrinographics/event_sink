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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  /// The unique identifier for the event.
  @JsonKey(name: 'event_id')
  @HiveField(0)
  String get eventId => throw _privateConstructorUsedError;

  /// The order in which the event should be applied.
  @JsonKey(name: 'sort_order')
  @HiveField(1)
  int get order => throw _privateConstructorUsedError;

  /// Indicates if the event has been synced to the server.
  @HiveField(2)
  Map<String, bool> get synced => throw _privateConstructorUsedError;

  /// Indicates the event has already been applied to the local aggregate.
  @HiveField(3)
  bool get applied => throw _privateConstructorUsedError;

  /// The ID of the stream being manipulated by this event.
  @JsonKey(name: 'stream_id')
  @HiveField(4)
  String get streamId => throw _privateConstructorUsedError;

  /// The version of the stream's state.
  @HiveField(5)
  int get version => throw _privateConstructorUsedError;

  /// The name of the event.
  @HiveField(6)
  String get name => throw _privateConstructorUsedError;

  /// The pool to which the event belongs.
  @HiveField(7)
  String get pool => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  @HiveField(8)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Custom event data
  @HiveField(9)
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'event_id') @HiveField(0) String eventId,
      @JsonKey(name: 'sort_order') @HiveField(1) int order,
      @HiveField(2) Map<String, bool> synced,
      @HiveField(3) bool applied,
      @JsonKey(name: 'stream_id') @HiveField(4) String streamId,
      @HiveField(5) int version,
      @HiveField(6) String name,
      @HiveField(7) String pool,
      @JsonKey(name: 'created_at') @HiveField(8) DateTime createdAt,
      @HiveField(9) Map<String, dynamic> data});
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? order = null,
    Object? synced = null,
    Object? applied = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? pool = null,
    Object? createdAt = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      synced: null == synced
          ? _value.synced
          : synced // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
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
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
          _$EventModelImpl value, $Res Function(_$EventModelImpl) then) =
      __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'event_id') @HiveField(0) String eventId,
      @JsonKey(name: 'sort_order') @HiveField(1) int order,
      @HiveField(2) Map<String, bool> synced,
      @HiveField(3) bool applied,
      @JsonKey(name: 'stream_id') @HiveField(4) String streamId,
      @HiveField(5) int version,
      @HiveField(6) String name,
      @HiveField(7) String pool,
      @JsonKey(name: 'created_at') @HiveField(8) DateTime createdAt,
      @HiveField(9) Map<String, dynamic> data});
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
      _$EventModelImpl _value, $Res Function(_$EventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? order = null,
    Object? synced = null,
    Object? applied = null,
    Object? streamId = null,
    Object? version = null,
    Object? name = null,
    Object? pool = null,
    Object? createdAt = null,
    Object? data = null,
  }) {
    return _then(_$EventModelImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      synced: null == synced
          ? _value._synced
          : synced // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
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
@HiveType(typeId: 1)
class _$EventModelImpl extends _EventModel {
  _$EventModelImpl(
      {@JsonKey(name: 'event_id') @HiveField(0) required this.eventId,
      @JsonKey(name: 'sort_order') @HiveField(1) required this.order,
      @HiveField(2) final Map<String, bool> synced = const {},
      @HiveField(3) this.applied = false,
      @JsonKey(name: 'stream_id') @HiveField(4) required this.streamId,
      @HiveField(5) required this.version,
      @HiveField(6) required this.name,
      @HiveField(7) required this.pool,
      @JsonKey(name: 'created_at') @HiveField(8) required this.createdAt,
      @HiveField(9) required final Map<String, dynamic> data})
      : _synced = synced,
        _data = data,
        super._();

  factory _$EventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventModelImplFromJson(json);

  /// The unique identifier for the event.
  @override
  @JsonKey(name: 'event_id')
  @HiveField(0)
  final String eventId;

  /// The order in which the event should be applied.
  @override
  @JsonKey(name: 'sort_order')
  @HiveField(1)
  final int order;

  /// Indicates if the event has been synced to the server.
  final Map<String, bool> _synced;

  /// Indicates if the event has been synced to the server.
  @override
  @JsonKey()
  @HiveField(2)
  Map<String, bool> get synced {
    if (_synced is EqualUnmodifiableMapView) return _synced;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_synced);
  }

  /// Indicates the event has already been applied to the local aggregate.
  @override
  @JsonKey()
  @HiveField(3)
  final bool applied;

  /// The ID of the stream being manipulated by this event.
  @override
  @JsonKey(name: 'stream_id')
  @HiveField(4)
  final String streamId;

  /// The version of the stream's state.
  @override
  @HiveField(5)
  final int version;

  /// The name of the event.
  @override
  @HiveField(6)
  final String name;

  /// The pool to which the event belongs.
  @override
  @HiveField(7)
  final String pool;
  @override
  @JsonKey(name: 'created_at')
  @HiveField(8)
  final DateTime createdAt;

  /// Custom event data
  final Map<String, dynamic> _data;

  /// Custom event data
  @override
  @HiveField(9)
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, order: $order, synced: $synced, applied: $applied, streamId: $streamId, version: $version, name: $name, pool: $pool, createdAt: $createdAt, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventModelImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._synced, _synced) &&
            (identical(other.applied, applied) || other.applied == applied) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      order,
      const DeepCollectionEquality().hash(_synced),
      applied,
      streamId,
      version,
      name,
      pool,
      createdAt,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventModelImplToJson(
      this,
    );
  }
}

abstract class _EventModel extends EventModel {
  factory _EventModel(
      {@JsonKey(name: 'event_id') @HiveField(0) required final String eventId,
      @JsonKey(name: 'sort_order') @HiveField(1) required final int order,
      @HiveField(2) final Map<String, bool> synced,
      @HiveField(3) final bool applied,
      @JsonKey(name: 'stream_id') @HiveField(4) required final String streamId,
      @HiveField(5) required final int version,
      @HiveField(6) required final String name,
      @HiveField(7) required final String pool,
      @JsonKey(name: 'created_at')
      @HiveField(8)
      required final DateTime createdAt,
      @HiveField(9)
      required final Map<String, dynamic> data}) = _$EventModelImpl;
  _EventModel._() : super._();

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$EventModelImpl.fromJson;

  /// The unique identifier for the event.
  @override
  @JsonKey(name: 'event_id')
  @HiveField(0)
  String get eventId;

  /// The order in which the event should be applied.
  @override
  @JsonKey(name: 'sort_order')
  @HiveField(1)
  int get order;

  /// Indicates if the event has been synced to the server.
  @override
  @HiveField(2)
  Map<String, bool> get synced;

  /// Indicates the event has already been applied to the local aggregate.
  @override
  @HiveField(3)
  bool get applied;

  /// The ID of the stream being manipulated by this event.
  @override
  @JsonKey(name: 'stream_id')
  @HiveField(4)
  String get streamId;

  /// The version of the stream's state.
  @override
  @HiveField(5)
  int get version;

  /// The name of the event.
  @override
  @HiveField(6)
  String get name;

  /// The pool to which the event belongs.
  @override
  @HiveField(7)
  String get pool;
  @override
  @JsonKey(name: 'created_at')
  @HiveField(8)
  DateTime get createdAt;

  /// Custom event data
  @override
  @HiveField(9)
  Map<String, dynamic> get data;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
