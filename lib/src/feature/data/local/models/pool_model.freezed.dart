// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pool_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PoolModel {

@HiveField(0) int get id;@HiveField(1) List<String> get eventIds;
/// Create a copy of PoolModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoolModelCopyWith<PoolModel> get copyWith => _$PoolModelCopyWithImpl<PoolModel>(this as PoolModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoolModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.eventIds, eventIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(eventIds));

@override
String toString() {
  return 'PoolModel(id: $id, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $PoolModelCopyWith<$Res>  {
  factory $PoolModelCopyWith(PoolModel value, $Res Function(PoolModel) _then) = _$PoolModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) int id,@HiveField(1) List<String> eventIds
});




}
/// @nodoc
class _$PoolModelCopyWithImpl<$Res>
    implements $PoolModelCopyWith<$Res> {
  _$PoolModelCopyWithImpl(this._self, this._then);

  final PoolModel _self;
  final $Res Function(PoolModel) _then;

/// Create a copy of PoolModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PoolModel].
extension PoolModelPatterns on PoolModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoolModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoolModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoolModel value)  $default,){
final _that = this;
switch (_that) {
case _PoolModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoolModel value)?  $default,){
final _that = this;
switch (_that) {
case _PoolModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  int id, @HiveField(1)  List<String> eventIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoolModel() when $default != null:
return $default(_that.id,_that.eventIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  int id, @HiveField(1)  List<String> eventIds)  $default,) {final _that = this;
switch (_that) {
case _PoolModel():
return $default(_that.id,_that.eventIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  int id, @HiveField(1)  List<String> eventIds)?  $default,) {final _that = this;
switch (_that) {
case _PoolModel() when $default != null:
return $default(_that.id,_that.eventIds);case _:
  return null;

}
}

}

/// @nodoc

@HiveType(typeId: 2)
class _PoolModel extends PoolModel {
   _PoolModel({@HiveField(0) required this.id, @HiveField(1) required final  List<String> eventIds}): _eventIds = eventIds,super._();
  

@override@HiveField(0) final  int id;
 final  List<String> _eventIds;
@override@HiveField(1) List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


/// Create a copy of PoolModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoolModelCopyWith<_PoolModel> get copyWith => __$PoolModelCopyWithImpl<_PoolModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoolModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'PoolModel(id: $id, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class _$PoolModelCopyWith<$Res> implements $PoolModelCopyWith<$Res> {
  factory _$PoolModelCopyWith(_PoolModel value, $Res Function(_PoolModel) _then) = __$PoolModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) int id,@HiveField(1) List<String> eventIds
});




}
/// @nodoc
class __$PoolModelCopyWithImpl<$Res>
    implements _$PoolModelCopyWith<$Res> {
  __$PoolModelCopyWithImpl(this._self, this._then);

  final _PoolModel _self;
  final $Res Function(_PoolModel) _then;

/// Create a copy of PoolModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventIds = null,}) {
  return _then(_PoolModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
