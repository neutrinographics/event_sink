// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_new_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteNewEventModel {

/// The unique ID of this event
@JsonKey(name: 'event_id') String get eventId;/// The ID of the stream affected by this event.
@JsonKey(name: 'stream_id') String get streamId;/// The version of the stream's state.
/// This is effectively the number of events that have been added to the
/// stream indicated by the [streamId].
 int get version;/// The name of the event
@JsonKey(name: 'action_type') String get name;/// Custom event data
 Map<String, dynamic> get data;
/// Create a copy of RemoteNewEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteNewEventModelCopyWith<RemoteNewEventModel> get copyWith => _$RemoteNewEventModelCopyWithImpl<RemoteNewEventModel>(this as RemoteNewEventModel, _$identity);

  /// Serializes this RemoteNewEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteNewEventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,streamId,version,name,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'RemoteNewEventModel(eventId: $eventId, streamId: $streamId, version: $version, name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class $RemoteNewEventModelCopyWith<$Res>  {
  factory $RemoteNewEventModelCopyWith(RemoteNewEventModel value, $Res Function(RemoteNewEventModel) _then) = _$RemoteNewEventModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'stream_id') String streamId, int version,@JsonKey(name: 'action_type') String name, Map<String, dynamic> data
});




}
/// @nodoc
class _$RemoteNewEventModelCopyWithImpl<$Res>
    implements $RemoteNewEventModelCopyWith<$Res> {
  _$RemoteNewEventModelCopyWithImpl(this._self, this._then);

  final RemoteNewEventModel _self;
  final $Res Function(RemoteNewEventModel) _then;

/// Create a copy of RemoteNewEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? streamId = null,Object? version = null,Object? name = null,Object? data = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoteNewEventModel].
extension RemoteNewEventModelPatterns on RemoteNewEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteNewEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteNewEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteNewEventModel value)  $default,){
final _that = this;
switch (_that) {
case _RemoteNewEventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteNewEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteNewEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'stream_id')  String streamId,  int version, @JsonKey(name: 'action_type')  String name,  Map<String, dynamic> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteNewEventModel() when $default != null:
return $default(_that.eventId,_that.streamId,_that.version,_that.name,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'stream_id')  String streamId,  int version, @JsonKey(name: 'action_type')  String name,  Map<String, dynamic> data)  $default,) {final _that = this;
switch (_that) {
case _RemoteNewEventModel():
return $default(_that.eventId,_that.streamId,_that.version,_that.name,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'stream_id')  String streamId,  int version, @JsonKey(name: 'action_type')  String name,  Map<String, dynamic> data)?  $default,) {final _that = this;
switch (_that) {
case _RemoteNewEventModel() when $default != null:
return $default(_that.eventId,_that.streamId,_that.version,_that.name,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteNewEventModel implements RemoteNewEventModel {
   _RemoteNewEventModel({@JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'stream_id') required this.streamId, required this.version, @JsonKey(name: 'action_type') required this.name, required final  Map<String, dynamic> data}): _data = data;
  factory _RemoteNewEventModel.fromJson(Map<String, dynamic> json) => _$RemoteNewEventModelFromJson(json);

/// The unique ID of this event
@override@JsonKey(name: 'event_id') final  String eventId;
/// The ID of the stream affected by this event.
@override@JsonKey(name: 'stream_id') final  String streamId;
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


/// Create a copy of RemoteNewEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteNewEventModelCopyWith<_RemoteNewEventModel> get copyWith => __$RemoteNewEventModelCopyWithImpl<_RemoteNewEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteNewEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteNewEventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,streamId,version,name,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'RemoteNewEventModel(eventId: $eventId, streamId: $streamId, version: $version, name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class _$RemoteNewEventModelCopyWith<$Res> implements $RemoteNewEventModelCopyWith<$Res> {
  factory _$RemoteNewEventModelCopyWith(_RemoteNewEventModel value, $Res Function(_RemoteNewEventModel) _then) = __$RemoteNewEventModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'stream_id') String streamId, int version,@JsonKey(name: 'action_type') String name, Map<String, dynamic> data
});




}
/// @nodoc
class __$RemoteNewEventModelCopyWithImpl<$Res>
    implements _$RemoteNewEventModelCopyWith<$Res> {
  __$RemoteNewEventModelCopyWithImpl(this._self, this._then);

  final _RemoteNewEventModel _self;
  final $Res Function(_RemoteNewEventModel) _then;

/// Create a copy of RemoteNewEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? streamId = null,Object? version = null,Object? name = null,Object? data = null,}) {
  return _then(_RemoteNewEventModel(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
