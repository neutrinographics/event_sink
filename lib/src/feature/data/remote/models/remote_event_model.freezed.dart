// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteEventModel {

/// The unique ID of this event
@JsonKey(name: 'event_id') String get eventId;/// The ID of the stream affected by this event.
@JsonKey(name: 'stream_id') String get streamId;/// The order in which the event should be applied
@JsonKey(name: 'sort_order') int get order;/// The version of the stream's state.
/// This is effectively the number of events that have been added to the
/// stream indicated by the [streamId].
 int get version;/// The name of the event
@JsonKey(name: 'action_type') String get name;/// Custom event data
 Map<String, dynamic> get data;/// The time when the event was created on the server
@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of RemoteEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteEventModelCopyWith<RemoteEventModel> get copyWith => _$RemoteEventModelCopyWithImpl<RemoteEventModel>(this as RemoteEventModel, _$identity);

  /// Serializes this RemoteEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteEventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.order, order) || other.order == order)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,streamId,order,version,name,const DeepCollectionEquality().hash(data),createdAt);

@override
String toString() {
  return 'RemoteEventModel(eventId: $eventId, streamId: $streamId, order: $order, version: $version, name: $name, data: $data, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RemoteEventModelCopyWith<$Res>  {
  factory $RemoteEventModelCopyWith(RemoteEventModel value, $Res Function(RemoteEventModel) _then) = _$RemoteEventModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'stream_id') String streamId,@JsonKey(name: 'sort_order') int order, int version,@JsonKey(name: 'action_type') String name, Map<String, dynamic> data,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$RemoteEventModelCopyWithImpl<$Res>
    implements $RemoteEventModelCopyWith<$Res> {
  _$RemoteEventModelCopyWithImpl(this._self, this._then);

  final RemoteEventModel _self;
  final $Res Function(RemoteEventModel) _then;

/// Create a copy of RemoteEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? streamId = null,Object? order = null,Object? version = null,Object? name = null,Object? data = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoteEventModel].
extension RemoteEventModelPatterns on RemoteEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteEventModel value)  $default,){
final _that = this;
switch (_that) {
case _RemoteEventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'stream_id')  String streamId, @JsonKey(name: 'sort_order')  int order,  int version, @JsonKey(name: 'action_type')  String name,  Map<String, dynamic> data, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteEventModel() when $default != null:
return $default(_that.eventId,_that.streamId,_that.order,_that.version,_that.name,_that.data,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'stream_id')  String streamId, @JsonKey(name: 'sort_order')  int order,  int version, @JsonKey(name: 'action_type')  String name,  Map<String, dynamic> data, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RemoteEventModel():
return $default(_that.eventId,_that.streamId,_that.order,_that.version,_that.name,_that.data,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'stream_id')  String streamId, @JsonKey(name: 'sort_order')  int order,  int version, @JsonKey(name: 'action_type')  String name,  Map<String, dynamic> data, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RemoteEventModel() when $default != null:
return $default(_that.eventId,_that.streamId,_that.order,_that.version,_that.name,_that.data,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteEventModel implements RemoteEventModel {
   _RemoteEventModel({@JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'stream_id') required this.streamId, @JsonKey(name: 'sort_order') required this.order, required this.version, @JsonKey(name: 'action_type') required this.name, required final  Map<String, dynamic> data, @JsonKey(name: 'created_at') required this.createdAt}): _data = data;
  factory _RemoteEventModel.fromJson(Map<String, dynamic> json) => _$RemoteEventModelFromJson(json);

/// The unique ID of this event
@override@JsonKey(name: 'event_id') final  String eventId;
/// The ID of the stream affected by this event.
@override@JsonKey(name: 'stream_id') final  String streamId;
/// The order in which the event should be applied
@override@JsonKey(name: 'sort_order') final  int order;
/// The version of the stream's state.
/// This is effectively the number of events that have been added to the
/// stream indicated by the [streamId].
@override final  int version;
/// The name of the event
@override@JsonKey(name: 'action_type') final  String name;
/// Custom event data
 final  Map<String, dynamic> _data;
/// Custom event data
@override Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

/// The time when the event was created on the server
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of RemoteEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteEventModelCopyWith<_RemoteEventModel> get copyWith => __$RemoteEventModelCopyWithImpl<_RemoteEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteEventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.order, order) || other.order == order)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,streamId,order,version,name,const DeepCollectionEquality().hash(_data),createdAt);

@override
String toString() {
  return 'RemoteEventModel(eventId: $eventId, streamId: $streamId, order: $order, version: $version, name: $name, data: $data, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RemoteEventModelCopyWith<$Res> implements $RemoteEventModelCopyWith<$Res> {
  factory _$RemoteEventModelCopyWith(_RemoteEventModel value, $Res Function(_RemoteEventModel) _then) = __$RemoteEventModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'stream_id') String streamId,@JsonKey(name: 'sort_order') int order, int version,@JsonKey(name: 'action_type') String name, Map<String, dynamic> data,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$RemoteEventModelCopyWithImpl<$Res>
    implements _$RemoteEventModelCopyWith<$Res> {
  __$RemoteEventModelCopyWithImpl(this._self, this._then);

  final _RemoteEventModel _self;
  final $Res Function(_RemoteEventModel) _then;

/// Create a copy of RemoteEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? streamId = null,Object? order = null,Object? version = null,Object? name = null,Object? data = null,Object? createdAt = null,}) {
  return _then(_RemoteEventModel(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
