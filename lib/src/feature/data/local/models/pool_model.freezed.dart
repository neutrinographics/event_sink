// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pool_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PoolModel {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  List<String> get eventIds => throw _privateConstructorUsedError;

  /// Create a copy of PoolModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoolModelCopyWith<PoolModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoolModelCopyWith<$Res> {
  factory $PoolModelCopyWith(PoolModel value, $Res Function(PoolModel) then) =
      _$PoolModelCopyWithImpl<$Res, PoolModel>;
  @useResult
  $Res call({@HiveField(0) int id, @HiveField(1) List<String> eventIds});
}

/// @nodoc
class _$PoolModelCopyWithImpl<$Res, $Val extends PoolModel>
    implements $PoolModelCopyWith<$Res> {
  _$PoolModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoolModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventIds: null == eventIds
          ? _value.eventIds
          : eventIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoolModelImplCopyWith<$Res>
    implements $PoolModelCopyWith<$Res> {
  factory _$$PoolModelImplCopyWith(
          _$PoolModelImpl value, $Res Function(_$PoolModelImpl) then) =
      __$$PoolModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) int id, @HiveField(1) List<String> eventIds});
}

/// @nodoc
class __$$PoolModelImplCopyWithImpl<$Res>
    extends _$PoolModelCopyWithImpl<$Res, _$PoolModelImpl>
    implements _$$PoolModelImplCopyWith<$Res> {
  __$$PoolModelImplCopyWithImpl(
      _$PoolModelImpl _value, $Res Function(_$PoolModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoolModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventIds = null,
  }) {
    return _then(_$PoolModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventIds: null == eventIds
          ? _value._eventIds
          : eventIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 2)
class _$PoolModelImpl extends _PoolModel {
  _$PoolModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required final List<String> eventIds})
      : _eventIds = eventIds,
        super._();

  @override
  @HiveField(0)
  final int id;
  final List<String> _eventIds;
  @override
  @HiveField(1)
  List<String> get eventIds {
    if (_eventIds is EqualUnmodifiableListView) return _eventIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eventIds);
  }

  @override
  String toString() {
    return 'PoolModel(id: $id, eventIds: $eventIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._eventIds, _eventIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_eventIds));

  /// Create a copy of PoolModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolModelImplCopyWith<_$PoolModelImpl> get copyWith =>
      __$$PoolModelImplCopyWithImpl<_$PoolModelImpl>(this, _$identity);
}

abstract class _PoolModel extends PoolModel {
  factory _PoolModel(
      {@HiveField(0) required final int id,
      @HiveField(1) required final List<String> eventIds}) = _$PoolModelImpl;
  _PoolModel._() : super._();

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  List<String> get eventIds;

  /// Create a copy of PoolModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoolModelImplCopyWith<_$PoolModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
