// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventModel {

/// The unique identifier for the event.
@JsonKey(name: 'event_id')@HiveField(0) String get eventId;/// The order in which the event should be applied.
@JsonKey(name: 'sort_order')@HiveField(1) int get order;/// Indicates if the event has been synced to the server.
@HiveField(2) bool get synced;/// Indicates the event has already been applied to the local aggregate.
@HiveField(3) bool get applied;/// The ID of the stream being manipulated by this event.
@JsonKey(name: 'stream_id')@HiveField(4) String get streamId;/// The version of the stream's state.
@HiveField(5) int get version;/// The name of the event.
@HiveField(6) String get name;/// The pool to which the event belongs.
@HiveField(7) int get pool;@JsonKey(name: 'created_at')@HiveField(8) DateTime get createdAt;/// Custom event data
@HiveField(9) Map<String, dynamic> get data;
/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventModelCopyWith<EventModel> get copyWith => _$EventModelCopyWithImpl<EventModel>(this as EventModel, _$identity);

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.order, order) || other.order == order)&&(identical(other.synced, synced) || other.synced == synced)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,order,synced,applied,streamId,version,name,pool,createdAt,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'EventModel(eventId: $eventId, order: $order, synced: $synced, applied: $applied, streamId: $streamId, version: $version, name: $name, pool: $pool, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class $EventModelCopyWith<$Res>  {
  factory $EventModelCopyWith(EventModel value, $Res Function(EventModel) _then) = _$EventModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id')@HiveField(0) String eventId,@JsonKey(name: 'sort_order')@HiveField(1) int order,@HiveField(2) bool synced,@HiveField(3) bool applied,@JsonKey(name: 'stream_id')@HiveField(4) String streamId,@HiveField(5) int version,@HiveField(6) String name,@HiveField(7) int pool,@JsonKey(name: 'created_at')@HiveField(8) DateTime createdAt,@HiveField(9) Map<String, dynamic> data
});




}
/// @nodoc
class _$EventModelCopyWithImpl<$Res>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._self, this._then);

  final EventModel _self;
  final $Res Function(EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? order = null,Object? synced = null,Object? applied = null,Object? streamId = null,Object? version = null,Object? name = null,Object? pool = null,Object? createdAt = null,Object? data = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as bool,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventModel].
extension EventModelPatterns on EventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventModel value)  $default,){
final _that = this;
switch (_that) {
case _EventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventModel value)?  $default,){
final _that = this;
switch (_that) {
case _EventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')@HiveField(0)  String eventId, @JsonKey(name: 'sort_order')@HiveField(1)  int order, @HiveField(2)  bool synced, @HiveField(3)  bool applied, @JsonKey(name: 'stream_id')@HiveField(4)  String streamId, @HiveField(5)  int version, @HiveField(6)  String name, @HiveField(7)  int pool, @JsonKey(name: 'created_at')@HiveField(8)  DateTime createdAt, @HiveField(9)  Map<String, dynamic> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventModel() when $default != null:
return $default(_that.eventId,_that.order,_that.synced,_that.applied,_that.streamId,_that.version,_that.name,_that.pool,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')@HiveField(0)  String eventId, @JsonKey(name: 'sort_order')@HiveField(1)  int order, @HiveField(2)  bool synced, @HiveField(3)  bool applied, @JsonKey(name: 'stream_id')@HiveField(4)  String streamId, @HiveField(5)  int version, @HiveField(6)  String name, @HiveField(7)  int pool, @JsonKey(name: 'created_at')@HiveField(8)  DateTime createdAt, @HiveField(9)  Map<String, dynamic> data)  $default,) {final _that = this;
switch (_that) {
case _EventModel():
return $default(_that.eventId,_that.order,_that.synced,_that.applied,_that.streamId,_that.version,_that.name,_that.pool,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')@HiveField(0)  String eventId, @JsonKey(name: 'sort_order')@HiveField(1)  int order, @HiveField(2)  bool synced, @HiveField(3)  bool applied, @JsonKey(name: 'stream_id')@HiveField(4)  String streamId, @HiveField(5)  int version, @HiveField(6)  String name, @HiveField(7)  int pool, @JsonKey(name: 'created_at')@HiveField(8)  DateTime createdAt, @HiveField(9)  Map<String, dynamic> data)?  $default,) {final _that = this;
switch (_that) {
case _EventModel() when $default != null:
return $default(_that.eventId,_that.order,_that.synced,_that.applied,_that.streamId,_that.version,_that.name,_that.pool,_that.createdAt,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1)
class _EventModel extends EventModel {
   _EventModel({@JsonKey(name: 'event_id')@HiveField(0) required this.eventId, @JsonKey(name: 'sort_order')@HiveField(1) required this.order, @HiveField(2) this.synced = false, @HiveField(3) this.applied = false, @JsonKey(name: 'stream_id')@HiveField(4) required this.streamId, @HiveField(5) required this.version, @HiveField(6) required this.name, @HiveField(7) required this.pool, @JsonKey(name: 'created_at')@HiveField(8) required this.createdAt, @HiveField(9) required final  Map<String, dynamic> data}): _data = data,super._();
  factory _EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

/// The unique identifier for the event.
@override@JsonKey(name: 'event_id')@HiveField(0) final  String eventId;
/// The order in which the event should be applied.
@override@JsonKey(name: 'sort_order')@HiveField(1) final  int order;
/// Indicates if the event has been synced to the server.
@override@JsonKey()@HiveField(2) final  bool synced;
/// Indicates the event has already been applied to the local aggregate.
@override@JsonKey()@HiveField(3) final  bool applied;
/// The ID of the stream being manipulated by this event.
@override@JsonKey(name: 'stream_id')@HiveField(4) final  String streamId;
/// The version of the stream's state.
@override@HiveField(5) final  int version;
/// The name of the event.
@override@HiveField(6) final  String name;
/// The pool to which the event belongs.
@override@HiveField(7) final  int pool;
@override@JsonKey(name: 'created_at')@HiveField(8) final  DateTime createdAt;
/// Custom event data
 final  Map<String, dynamic> _data;
/// Custom event data
@override@HiveField(9) Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventModelCopyWith<_EventModel> get copyWith => __$EventModelCopyWithImpl<_EventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.order, order) || other.order == order)&&(identical(other.synced, synced) || other.synced == synced)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.streamId, streamId) || other.streamId == streamId)&&(identical(other.version, version) || other.version == version)&&(identical(other.name, name) || other.name == name)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,order,synced,applied,streamId,version,name,pool,createdAt,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'EventModel(eventId: $eventId, order: $order, synced: $synced, applied: $applied, streamId: $streamId, version: $version, name: $name, pool: $pool, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class _$EventModelCopyWith<$Res> implements $EventModelCopyWith<$Res> {
  factory _$EventModelCopyWith(_EventModel value, $Res Function(_EventModel) _then) = __$EventModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id')@HiveField(0) String eventId,@JsonKey(name: 'sort_order')@HiveField(1) int order,@HiveField(2) bool synced,@HiveField(3) bool applied,@JsonKey(name: 'stream_id')@HiveField(4) String streamId,@HiveField(5) int version,@HiveField(6) String name,@HiveField(7) int pool,@JsonKey(name: 'created_at')@HiveField(8) DateTime createdAt,@HiveField(9) Map<String, dynamic> data
});




}
/// @nodoc
class __$EventModelCopyWithImpl<$Res>
    implements _$EventModelCopyWith<$Res> {
  __$EventModelCopyWithImpl(this._self, this._then);

  final _EventModel _self;
  final $Res Function(_EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? order = null,Object? synced = null,Object? applied = null,Object? streamId = null,Object? version = null,Object? name = null,Object? pool = null,Object? createdAt = null,Object? data = null,}) {
  return _then(_EventModel(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as bool,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as bool,streamId: null == streamId ? _self.streamId : streamId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
