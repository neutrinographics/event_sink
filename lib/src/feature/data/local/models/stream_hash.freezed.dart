// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_hash.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreamHash {
  String get eventId => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;

  /// Create a copy of StreamHash
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamHashCopyWith<StreamHash> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamHashCopyWith<$Res> {
  factory $StreamHashCopyWith(
          StreamHash value, $Res Function(StreamHash) then) =
      _$StreamHashCopyWithImpl<$Res, StreamHash>;
  @useResult
  $Res call({String eventId, String hash});
}

/// @nodoc
class _$StreamHashCopyWithImpl<$Res, $Val extends StreamHash>
    implements $StreamHashCopyWith<$Res> {
  _$StreamHashCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamHash
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? hash = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamHashImplCopyWith<$Res>
    implements $StreamHashCopyWith<$Res> {
  factory _$$StreamHashImplCopyWith(
          _$StreamHashImpl value, $Res Function(_$StreamHashImpl) then) =
      __$$StreamHashImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String eventId, String hash});
}

/// @nodoc
class __$$StreamHashImplCopyWithImpl<$Res>
    extends _$StreamHashCopyWithImpl<$Res, _$StreamHashImpl>
    implements _$$StreamHashImplCopyWith<$Res> {
  __$$StreamHashImplCopyWithImpl(
      _$StreamHashImpl _value, $Res Function(_$StreamHashImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamHash
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
    Object? hash = null,
  }) {
    return _then(_$StreamHashImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StreamHashImpl implements _StreamHash {
  const _$StreamHashImpl({required this.eventId, required this.hash});

  @override
  final String eventId;
  @override
  final String hash;

  @override
  String toString() {
    return 'StreamHash(eventId: $eventId, hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamHashImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventId, hash);

  /// Create a copy of StreamHash
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamHashImplCopyWith<_$StreamHashImpl> get copyWith =>
      __$$StreamHashImplCopyWithImpl<_$StreamHashImpl>(this, _$identity);
}

abstract class _StreamHash implements StreamHash {
  const factory _StreamHash(
      {required final String eventId,
      required final String hash}) = _$StreamHashImpl;

  @override
  String get eventId;
  @override
  String get hash;

  /// Create a copy of StreamHash
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamHashImplCopyWith<_$StreamHashImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
