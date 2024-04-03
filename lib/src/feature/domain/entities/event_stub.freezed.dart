// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_stub.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventStub {
  /// The local ID of the event.
  String get eventId => throw _privateConstructorUsedError;

  /// The id of the stream being modified
  String get streamId => throw _privateConstructorUsedError;

  /// The name of the event
  String get name => throw _privateConstructorUsedError;
  int get pool => throw _privateConstructorUsedError;

  /// The stream version
  int get version => throw _privateConstructorUsedError;

  /// Indicates the event has already been applied to the aggregate.
  bool get applied => throw _privateConstructorUsedError;

  /// The data needed to perform the action
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventStubCopyWith<EventStub> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventStubCopyWith<$Res> {
  factory $EventStubCopyWith(EventStub value, $Res Function(EventStub) then) =
      _$EventStubCopyWithImpl<$Res, EventStub>;
  @useResult
  $Res call(
      {String eventId,
      String streamId,
      String name,
      int pool,
      int version,
      bool applied,
      Map<String, dynamic> data});
}

/// @nodoc
class _$EventStubCopyWithImpl<$Res, $Val extends EventStub>
    implements $EventStubCopyWith<$Res> {
  _$EventStubCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? streamId = null,
    Object? name = null,
    Object? pool = null,
    Object? version = null,
    Object? applied = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pool: null == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as int,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      applied: null == applied
          ? _value.applied
          : applied // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventStubImplCopyWith<$Res>
    implements $EventStubCopyWith<$Res> {
  factory _$$EventStubImplCopyWith(
          _$EventStubImpl value, $Res Function(_$EventStubImpl) then) =
      __$$EventStubImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String eventId,
      String streamId,
      String name,
      int pool,
      int version,
      bool applied,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$EventStubImplCopyWithImpl<$Res>
    extends _$EventStubCopyWithImpl<$Res, _$EventStubImpl>
    implements _$$EventStubImplCopyWith<$Res> {
  __$$EventStubImplCopyWithImpl(
      _$EventStubImpl _value, $Res Function(_$EventStubImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? streamId = null,
    Object? name = null,
    Object? pool = null,
    Object? version = null,
    Object? applied = null,
    Object? data = null,
  }) {
    return _then(_$EventStubImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      streamId: null == streamId
          ? _value.streamId
          : streamId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pool: null == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as int,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      applied: null == applied
          ? _value.applied
          : applied // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$EventStubImpl implements _EventStub {
  _$EventStubImpl(
      {required this.eventId,
      required this.streamId,
      required this.name,
      required this.pool,
      required this.version,
      required this.applied,
      required final Map<String, dynamic> data})
      : _data = data;

  /// The local ID of the event.
  @override
  final String eventId;

  /// The id of the stream being modified
  @override
  final String streamId;

  /// The name of the event
  @override
  final String name;
  @override
  final int pool;

  /// The stream version
  @override
  final int version;

  /// Indicates the event has already been applied to the aggregate.
  @override
  final bool applied;

  /// The data needed to perform the action
  final Map<String, dynamic> _data;

  /// The data needed to perform the action
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'EventStub(eventId: $eventId, streamId: $streamId, name: $name, pool: $pool, version: $version, applied: $applied, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventStubImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.streamId, streamId) ||
                other.streamId == streamId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.applied, applied) || other.applied == applied) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventId, streamId, name, pool,
      version, applied, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventStubImplCopyWith<_$EventStubImpl> get copyWith =>
      __$$EventStubImplCopyWithImpl<_$EventStubImpl>(this, _$identity);
}

abstract class _EventStub implements EventStub {
  factory _EventStub(
      {required final String eventId,
      required final String streamId,
      required final String name,
      required final int pool,
      required final int version,
      required final bool applied,
      required final Map<String, dynamic> data}) = _$EventStubImpl;

  @override

  /// The local ID of the event.
  String get eventId;
  @override

  /// The id of the stream being modified
  String get streamId;
  @override

  /// The name of the event
  String get name;
  @override
  int get pool;
  @override

  /// The stream version
  int get version;
  @override

  /// Indicates the event has already been applied to the aggregate.
  bool get applied;
  @override

  /// The data needed to perform the action
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$EventStubImplCopyWith<_$EventStubImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
