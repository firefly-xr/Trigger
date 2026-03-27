// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispatch_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DispatchAlert {

 String? get id; String get patientId; String? get patientName; double get latitude; double get longitude;/// 1-Critical to 5-Low
 int get aiSeverityScore; String get aiSummary; DispatchStatus get status; int? get age; String? get gender; DateTime? get timestamp;
/// Create a copy of DispatchAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DispatchAlertCopyWith<DispatchAlert> get copyWith => _$DispatchAlertCopyWithImpl<DispatchAlert>(this as DispatchAlert, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DispatchAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.aiSeverityScore, aiSeverityScore) || other.aiSeverityScore == aiSeverityScore)&&(identical(other.aiSummary, aiSummary) || other.aiSummary == aiSummary)&&(identical(other.status, status) || other.status == status)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,patientId,patientName,latitude,longitude,aiSeverityScore,aiSummary,status,age,gender,timestamp);

@override
String toString() {
  return 'DispatchAlert(id: $id, patientId: $patientId, patientName: $patientName, latitude: $latitude, longitude: $longitude, aiSeverityScore: $aiSeverityScore, aiSummary: $aiSummary, status: $status, age: $age, gender: $gender, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $DispatchAlertCopyWith<$Res>  {
  factory $DispatchAlertCopyWith(DispatchAlert value, $Res Function(DispatchAlert) _then) = _$DispatchAlertCopyWithImpl;
@useResult
$Res call({
 String? id, String patientId, String? patientName, double latitude, double longitude, int aiSeverityScore, String aiSummary, DispatchStatus status, int? age, String? gender, DateTime? timestamp
});




}
/// @nodoc
class _$DispatchAlertCopyWithImpl<$Res>
    implements $DispatchAlertCopyWith<$Res> {
  _$DispatchAlertCopyWithImpl(this._self, this._then);

  final DispatchAlert _self;
  final $Res Function(DispatchAlert) _then;

/// Create a copy of DispatchAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? patientId = null,Object? patientName = freezed,Object? latitude = null,Object? longitude = null,Object? aiSeverityScore = null,Object? aiSummary = null,Object? status = null,Object? age = freezed,Object? gender = freezed,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,patientName: freezed == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,aiSeverityScore: null == aiSeverityScore ? _self.aiSeverityScore : aiSeverityScore // ignore: cast_nullable_to_non_nullable
as int,aiSummary: null == aiSummary ? _self.aiSummary : aiSummary // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DispatchStatus,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DispatchAlert].
extension DispatchAlertPatterns on DispatchAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DispatchAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DispatchAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DispatchAlert value)  $default,){
final _that = this;
switch (_that) {
case _DispatchAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DispatchAlert value)?  $default,){
final _that = this;
switch (_that) {
case _DispatchAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String patientId,  String? patientName,  double latitude,  double longitude,  int aiSeverityScore,  String aiSummary,  DispatchStatus status,  int? age,  String? gender,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DispatchAlert() when $default != null:
return $default(_that.id,_that.patientId,_that.patientName,_that.latitude,_that.longitude,_that.aiSeverityScore,_that.aiSummary,_that.status,_that.age,_that.gender,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String patientId,  String? patientName,  double latitude,  double longitude,  int aiSeverityScore,  String aiSummary,  DispatchStatus status,  int? age,  String? gender,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _DispatchAlert():
return $default(_that.id,_that.patientId,_that.patientName,_that.latitude,_that.longitude,_that.aiSeverityScore,_that.aiSummary,_that.status,_that.age,_that.gender,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String patientId,  String? patientName,  double latitude,  double longitude,  int aiSeverityScore,  String aiSummary,  DispatchStatus status,  int? age,  String? gender,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _DispatchAlert() when $default != null:
return $default(_that.id,_that.patientId,_that.patientName,_that.latitude,_that.longitude,_that.aiSeverityScore,_that.aiSummary,_that.status,_that.age,_that.gender,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _DispatchAlert extends DispatchAlert {
  const _DispatchAlert({this.id, required this.patientId, this.patientName, required this.latitude, required this.longitude, required this.aiSeverityScore, required this.aiSummary, required this.status, this.age, this.gender, this.timestamp}): super._();
  

@override final  String? id;
@override final  String patientId;
@override final  String? patientName;
@override final  double latitude;
@override final  double longitude;
/// 1-Critical to 5-Low
@override final  int aiSeverityScore;
@override final  String aiSummary;
@override final  DispatchStatus status;
@override final  int? age;
@override final  String? gender;
@override final  DateTime? timestamp;

/// Create a copy of DispatchAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DispatchAlertCopyWith<_DispatchAlert> get copyWith => __$DispatchAlertCopyWithImpl<_DispatchAlert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DispatchAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.aiSeverityScore, aiSeverityScore) || other.aiSeverityScore == aiSeverityScore)&&(identical(other.aiSummary, aiSummary) || other.aiSummary == aiSummary)&&(identical(other.status, status) || other.status == status)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,patientId,patientName,latitude,longitude,aiSeverityScore,aiSummary,status,age,gender,timestamp);

@override
String toString() {
  return 'DispatchAlert(id: $id, patientId: $patientId, patientName: $patientName, latitude: $latitude, longitude: $longitude, aiSeverityScore: $aiSeverityScore, aiSummary: $aiSummary, status: $status, age: $age, gender: $gender, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$DispatchAlertCopyWith<$Res> implements $DispatchAlertCopyWith<$Res> {
  factory _$DispatchAlertCopyWith(_DispatchAlert value, $Res Function(_DispatchAlert) _then) = __$DispatchAlertCopyWithImpl;
@override @useResult
$Res call({
 String? id, String patientId, String? patientName, double latitude, double longitude, int aiSeverityScore, String aiSummary, DispatchStatus status, int? age, String? gender, DateTime? timestamp
});




}
/// @nodoc
class __$DispatchAlertCopyWithImpl<$Res>
    implements _$DispatchAlertCopyWith<$Res> {
  __$DispatchAlertCopyWithImpl(this._self, this._then);

  final _DispatchAlert _self;
  final $Res Function(_DispatchAlert) _then;

/// Create a copy of DispatchAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? patientId = null,Object? patientName = freezed,Object? latitude = null,Object? longitude = null,Object? aiSeverityScore = null,Object? aiSummary = null,Object? status = null,Object? age = freezed,Object? gender = freezed,Object? timestamp = freezed,}) {
  return _then(_DispatchAlert(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,patientName: freezed == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,aiSeverityScore: null == aiSeverityScore ? _self.aiSeverityScore : aiSeverityScore // ignore: cast_nullable_to_non_nullable
as int,aiSummary: null == aiSummary ? _self.aiSummary : aiSummary // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DispatchStatus,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
