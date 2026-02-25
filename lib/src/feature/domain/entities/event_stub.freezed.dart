// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_stub.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventStub {

/// The local ID of the event.
 String get eventId;/// The id of the stream being modified
 String get streamId;/// The name of the event
 String get name; int get pool;/// The stream version
 int get version;/// Indicates the event has already been applied to the aggregate.
 bool get applied;/// The data needed to perform the action
 Map<String, dynamic> get data;
/// Create a copy of EventStub
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventStubCopyWith<EventStub> get copyWith => _$EventStubCopyWithImpl<EventStub>(this as EventStub, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventStub&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.name, name) || other.name == name)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.version, version) || other.version == version)&&(identical(other.applied, applied) || other.applied == applied)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,streamId,name,pool,version,applied,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'EventStub(eventId: $eventId, streamId: $streamId, name: $name, pool: $pool, version: $version, applied: $applied, data: $data)';
}


}

/// @nodoc
abstract mixin class $EventStubCopyWith<$Res>  {
  factory $EventStubCopyWith(EventStub value, $Res Function(EventStub) _then) = _$EventStubCopyWithImpl;
@useResult
$Res call({
 String eventId, String streamId, String name, int pool, int version, bool applied, Map<String, dynamic> data
});




}
/// @nodoc
class _$EventStubCopyWithImpl<$Res>
    implements $EventStubCopyWith<$Res> {
  _$EventStubCopyWithImpl(this._self, this._then);

  final EventStub _self;
  final $Res Function(EventStub) _then;

/// Create a copy of EventStub
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? streamId = null,Object? name = null,Object? pool = null,Object? version = null,Object? applied = null,Object? data = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventStub].
extension EventStubPatterns on EventStub {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventStub value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventStub() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventStub value)  $default,){
final _that = this;
switch (_that) {
case _EventStub():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventStub value)?  $default,){
final _that = this;
switch (_that) {
case _EventStub() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String streamId,  String name,  int pool,  int version,  bool applied,  Map<String, dynamic> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventStub() when $default != null:
return $default(_that.eventId,_that.streamId,_that.name,_that.pool,_that.version,_that.applied,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String streamId,  String name,  int pool,  int version,  bool applied,  Map<String, dynamic> data)  $default,) {final _that = this;
switch (_that) {
case _EventStub():
return $default(_that.eventId,_that.streamId,_that.name,_that.pool,_that.version,_that.applied,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String streamId,  String name,  int pool,  int version,  bool applied,  Map<String, dynamic> data)?  $default,) {final _that = this;
switch (_that) {
case _EventStub() when $default != null:
return $default(_that.eventId,_that.streamId,_that.name,_that.pool,_that.version,_that.applied,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _EventStub implements EventStub {
   _EventStub({required this.eventId, required this.streamId, required this.name, required this.pool, required this.version, required this.applied, required final  Map<String, dynamic> data}): _data = data;
  

/// The local ID of the event.
@override final  String eventId;
/// The id of the stream being modified
@override final  String streamId;
/// The name of the event
@override final  String name;
@override final  int pool;
/// The stream version
@override final  int version;
/// Indicates the event has already been applied to the aggregate.
@override final  bool applied;
/// The data needed to perform the action
 final  Map<String, dynamic> _data;
/// The data needed to perform the action
@override Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of EventStub
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventStubCopyWith<_EventStub> get copyWith => __$EventStubCopyWithImpl<_EventStub>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventStub&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.name, name) || other.name == name)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.version, version) || other.version == version)&&(identical(other.applied, applied) || other.applied == applied)&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,streamId,name,pool,version,applied,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'EventStub(eventId: $eventId, streamId: $streamId, name: $name, pool: $pool, version: $version, applied: $applied, data: $data)';
}


}

/// @nodoc
abstract mixin class _$EventStubCopyWith<$Res> implements $EventStubCopyWith<$Res> {
  factory _$EventStubCopyWith(_EventStub value, $Res Function(_EventStub) _then) = __$EventStubCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String streamId, String name, int pool, int version, bool applied, Map<String, dynamic> data
});




}
/// @nodoc
class __$EventStubCopyWithImpl<$Res>
    implements _$EventStubCopyWith<$Res> {
  __$EventStubCopyWithImpl(this._self, this._then);

  final _EventStub _self;
  final $Res Function(_EventStub) _then;

/// Create a copy of EventStub
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? streamId = null,Object? name = null,Object? pool = null,Object? version = null,Object? applied = null,Object? data = null,}) {
  return _then(_EventStub(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
