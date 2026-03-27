// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientProfile {

 String get uid; String get fullName; int? get age; String get bloodGroup; List<Map<String, dynamic>> get emergencyContacts; String get medicalContext; Map<String, dynamic>? get medicalHistoryDetails;
/// Create a copy of PatientProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientProfileCopyWith<PatientProfile> get copyWith => _$PatientProfileCopyWithImpl<PatientProfile>(this as PatientProfile, _$identity);

  /// Serializes this PatientProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.age, age) || other.age == age)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&const DeepCollectionEquality().equals(other.emergencyContacts, emergencyContacts)&&(identical(other.medicalContext, medicalContext) || other.medicalContext == medicalContext)&&const DeepCollectionEquality().equals(other.medicalHistoryDetails, medicalHistoryDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,fullName,age,bloodGroup,const DeepCollectionEquality().hash(emergencyContacts),medicalContext,const DeepCollectionEquality().hash(medicalHistoryDetails));

@override
String toString() {
  return 'PatientProfile(uid: $uid, fullName: $fullName, age: $age, bloodGroup: $bloodGroup, emergencyContacts: $emergencyContacts, medicalContext: $medicalContext, medicalHistoryDetails: $medicalHistoryDetails)';
}


}

/// @nodoc
abstract mixin class $PatientProfileCopyWith<$Res>  {
  factory $PatientProfileCopyWith(PatientProfile value, $Res Function(PatientProfile) _then) = _$PatientProfileCopyWithImpl;
@useResult
$Res call({
 String uid, String fullName, int? age, String bloodGroup, List<Map<String, dynamic>> emergencyContacts, String medicalContext, Map<String, dynamic>? medicalHistoryDetails
});




}
/// @nodoc
class _$PatientProfileCopyWithImpl<$Res>
    implements $PatientProfileCopyWith<$Res> {
  _$PatientProfileCopyWithImpl(this._self, this._then);

  final PatientProfile _self;
  final $Res Function(PatientProfile) _then;

/// Create a copy of PatientProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? fullName = null,Object? age = freezed,Object? bloodGroup = null,Object? emergencyContacts = null,Object? medicalContext = null,Object? medicalHistoryDetails = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,bloodGroup: null == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as String,emergencyContacts: null == emergencyContacts ? _self.emergencyContacts : emergencyContacts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,medicalContext: null == medicalContext ? _self.medicalContext : medicalContext // ignore: cast_nullable_to_non_nullable
as String,medicalHistoryDetails: freezed == medicalHistoryDetails ? _self.medicalHistoryDetails : medicalHistoryDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PatientProfile].
extension PatientProfilePatterns on PatientProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientProfile value)  $default,){
final _that = this;
switch (_that) {
case _PatientProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PatientProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String fullName,  int? age,  String bloodGroup,  List<Map<String, dynamic>> emergencyContacts,  String medicalContext,  Map<String, dynamic>? medicalHistoryDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientProfile() when $default != null:
return $default(_that.uid,_that.fullName,_that.age,_that.bloodGroup,_that.emergencyContacts,_that.medicalContext,_that.medicalHistoryDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String fullName,  int? age,  String bloodGroup,  List<Map<String, dynamic>> emergencyContacts,  String medicalContext,  Map<String, dynamic>? medicalHistoryDetails)  $default,) {final _that = this;
switch (_that) {
case _PatientProfile():
return $default(_that.uid,_that.fullName,_that.age,_that.bloodGroup,_that.emergencyContacts,_that.medicalContext,_that.medicalHistoryDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String fullName,  int? age,  String bloodGroup,  List<Map<String, dynamic>> emergencyContacts,  String medicalContext,  Map<String, dynamic>? medicalHistoryDetails)?  $default,) {final _that = this;
switch (_that) {
case _PatientProfile() when $default != null:
return $default(_that.uid,_that.fullName,_that.age,_that.bloodGroup,_that.emergencyContacts,_that.medicalContext,_that.medicalHistoryDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientProfile implements PatientProfile {
  const _PatientProfile({required this.uid, required this.fullName, this.age, required this.bloodGroup, required final  List<Map<String, dynamic>> emergencyContacts, required this.medicalContext, final  Map<String, dynamic>? medicalHistoryDetails}): _emergencyContacts = emergencyContacts,_medicalHistoryDetails = medicalHistoryDetails;
  factory _PatientProfile.fromJson(Map<String, dynamic> json) => _$PatientProfileFromJson(json);

@override final  String uid;
@override final  String fullName;
@override final  int? age;
@override final  String bloodGroup;
 final  List<Map<String, dynamic>> _emergencyContacts;
@override List<Map<String, dynamic>> get emergencyContacts {
  if (_emergencyContacts is EqualUnmodifiableListView) return _emergencyContacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emergencyContacts);
}

@override final  String medicalContext;
 final  Map<String, dynamic>? _medicalHistoryDetails;
@override Map<String, dynamic>? get medicalHistoryDetails {
  final value = _medicalHistoryDetails;
  if (value == null) return null;
  if (_medicalHistoryDetails is EqualUnmodifiableMapView) return _medicalHistoryDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PatientProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientProfileCopyWith<_PatientProfile> get copyWith => __$PatientProfileCopyWithImpl<_PatientProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.age, age) || other.age == age)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&const DeepCollectionEquality().equals(other._emergencyContacts, _emergencyContacts)&&(identical(other.medicalContext, medicalContext) || other.medicalContext == medicalContext)&&const DeepCollectionEquality().equals(other._medicalHistoryDetails, _medicalHistoryDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,fullName,age,bloodGroup,const DeepCollectionEquality().hash(_emergencyContacts),medicalContext,const DeepCollectionEquality().hash(_medicalHistoryDetails));

@override
String toString() {
  return 'PatientProfile(uid: $uid, fullName: $fullName, age: $age, bloodGroup: $bloodGroup, emergencyContacts: $emergencyContacts, medicalContext: $medicalContext, medicalHistoryDetails: $medicalHistoryDetails)';
}


}

/// @nodoc
abstract mixin class _$PatientProfileCopyWith<$Res> implements $PatientProfileCopyWith<$Res> {
  factory _$PatientProfileCopyWith(_PatientProfile value, $Res Function(_PatientProfile) _then) = __$PatientProfileCopyWithImpl;
@override @useResult
$Res call({
 String uid, String fullName, int? age, String bloodGroup, List<Map<String, dynamic>> emergencyContacts, String medicalContext, Map<String, dynamic>? medicalHistoryDetails
});




}
/// @nodoc
class __$PatientProfileCopyWithImpl<$Res>
    implements _$PatientProfileCopyWith<$Res> {
  __$PatientProfileCopyWithImpl(this._self, this._then);

  final _PatientProfile _self;
  final $Res Function(_PatientProfile) _then;

/// Create a copy of PatientProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? fullName = null,Object? age = freezed,Object? bloodGroup = null,Object? emergencyContacts = null,Object? medicalContext = null,Object? medicalHistoryDetails = freezed,}) {
  return _then(_PatientProfile(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,bloodGroup: null == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as String,emergencyContacts: null == emergencyContacts ? _self._emergencyContacts : emergencyContacts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,medicalContext: null == medicalContext ? _self.medicalContext : medicalContext // ignore: cast_nullable_to_non_nullable
as String,medicalHistoryDetails: freezed == medicalHistoryDetails ? _self._medicalHistoryDetails : medicalHistoryDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$EmergencyEvent {

 String get id; String get patientId; String get status; Map<String, dynamic> get vitalsSnapshot; int get aiSeverityScore; String get aiSummary; String? get assignedAmbulanceId; String? get targetHospitalId;
/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyEventCopyWith<EmergencyEvent> get copyWith => _$EmergencyEventCopyWithImpl<EmergencyEvent>(this as EmergencyEvent, _$identity);

  /// Serializes this EmergencyEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.vitalsSnapshot, vitalsSnapshot)&&(identical(other.aiSeverityScore, aiSeverityScore) || other.aiSeverityScore == aiSeverityScore)&&(identical(other.aiSummary, aiSummary) || other.aiSummary == aiSummary)&&(identical(other.assignedAmbulanceId, assignedAmbulanceId) || other.assignedAmbulanceId == assignedAmbulanceId)&&(identical(other.targetHospitalId, targetHospitalId) || other.targetHospitalId == targetHospitalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patientId,status,const DeepCollectionEquality().hash(vitalsSnapshot),aiSeverityScore,aiSummary,assignedAmbulanceId,targetHospitalId);

@override
String toString() {
  return 'EmergencyEvent(id: $id, patientId: $patientId, status: $status, vitalsSnapshot: $vitalsSnapshot, aiSeverityScore: $aiSeverityScore, aiSummary: $aiSummary, assignedAmbulanceId: $assignedAmbulanceId, targetHospitalId: $targetHospitalId)';
}


}

/// @nodoc
abstract mixin class $EmergencyEventCopyWith<$Res>  {
  factory $EmergencyEventCopyWith(EmergencyEvent value, $Res Function(EmergencyEvent) _then) = _$EmergencyEventCopyWithImpl;
@useResult
$Res call({
 String id, String patientId, String status, Map<String, dynamic> vitalsSnapshot, int aiSeverityScore, String aiSummary, String? assignedAmbulanceId, String? targetHospitalId
});




}
/// @nodoc
class _$EmergencyEventCopyWithImpl<$Res>
    implements $EmergencyEventCopyWith<$Res> {
  _$EmergencyEventCopyWithImpl(this._self, this._then);

  final EmergencyEvent _self;
  final $Res Function(EmergencyEvent) _then;

/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patientId = null,Object? status = null,Object? vitalsSnapshot = null,Object? aiSeverityScore = null,Object? aiSummary = null,Object? assignedAmbulanceId = freezed,Object? targetHospitalId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,vitalsSnapshot: null == vitalsSnapshot ? _self.vitalsSnapshot : vitalsSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,aiSeverityScore: null == aiSeverityScore ? _self.aiSeverityScore : aiSeverityScore // ignore: cast_nullable_to_non_nullable
as int,aiSummary: null == aiSummary ? _self.aiSummary : aiSummary // ignore: cast_nullable_to_non_nullable
as String,assignedAmbulanceId: freezed == assignedAmbulanceId ? _self.assignedAmbulanceId : assignedAmbulanceId // ignore: cast_nullable_to_non_nullable
as String?,targetHospitalId: freezed == targetHospitalId ? _self.targetHospitalId : targetHospitalId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmergencyEvent].
extension EmergencyEventPatterns on EmergencyEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyEvent value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyEvent value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String patientId,  String status,  Map<String, dynamic> vitalsSnapshot,  int aiSeverityScore,  String aiSummary,  String? assignedAmbulanceId,  String? targetHospitalId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
return $default(_that.id,_that.patientId,_that.status,_that.vitalsSnapshot,_that.aiSeverityScore,_that.aiSummary,_that.assignedAmbulanceId,_that.targetHospitalId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String patientId,  String status,  Map<String, dynamic> vitalsSnapshot,  int aiSeverityScore,  String aiSummary,  String? assignedAmbulanceId,  String? targetHospitalId)  $default,) {final _that = this;
switch (_that) {
case _EmergencyEvent():
return $default(_that.id,_that.patientId,_that.status,_that.vitalsSnapshot,_that.aiSeverityScore,_that.aiSummary,_that.assignedAmbulanceId,_that.targetHospitalId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String patientId,  String status,  Map<String, dynamic> vitalsSnapshot,  int aiSeverityScore,  String aiSummary,  String? assignedAmbulanceId,  String? targetHospitalId)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyEvent() when $default != null:
return $default(_that.id,_that.patientId,_that.status,_that.vitalsSnapshot,_that.aiSeverityScore,_that.aiSummary,_that.assignedAmbulanceId,_that.targetHospitalId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmergencyEvent implements EmergencyEvent {
  const _EmergencyEvent({required this.id, required this.patientId, required this.status, required final  Map<String, dynamic> vitalsSnapshot, required this.aiSeverityScore, required this.aiSummary, this.assignedAmbulanceId, this.targetHospitalId}): _vitalsSnapshot = vitalsSnapshot;
  factory _EmergencyEvent.fromJson(Map<String, dynamic> json) => _$EmergencyEventFromJson(json);

@override final  String id;
@override final  String patientId;
@override final  String status;
 final  Map<String, dynamic> _vitalsSnapshot;
@override Map<String, dynamic> get vitalsSnapshot {
  if (_vitalsSnapshot is EqualUnmodifiableMapView) return _vitalsSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_vitalsSnapshot);
}

@override final  int aiSeverityScore;
@override final  String aiSummary;
@override final  String? assignedAmbulanceId;
@override final  String? targetHospitalId;

/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyEventCopyWith<_EmergencyEvent> get copyWith => __$EmergencyEventCopyWithImpl<_EmergencyEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmergencyEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._vitalsSnapshot, _vitalsSnapshot)&&(identical(other.aiSeverityScore, aiSeverityScore) || other.aiSeverityScore == aiSeverityScore)&&(identical(other.aiSummary, aiSummary) || other.aiSummary == aiSummary)&&(identical(other.assignedAmbulanceId, assignedAmbulanceId) || other.assignedAmbulanceId == assignedAmbulanceId)&&(identical(other.targetHospitalId, targetHospitalId) || other.targetHospitalId == targetHospitalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patientId,status,const DeepCollectionEquality().hash(_vitalsSnapshot),aiSeverityScore,aiSummary,assignedAmbulanceId,targetHospitalId);

@override
String toString() {
  return 'EmergencyEvent(id: $id, patientId: $patientId, status: $status, vitalsSnapshot: $vitalsSnapshot, aiSeverityScore: $aiSeverityScore, aiSummary: $aiSummary, assignedAmbulanceId: $assignedAmbulanceId, targetHospitalId: $targetHospitalId)';
}


}

/// @nodoc
abstract mixin class _$EmergencyEventCopyWith<$Res> implements $EmergencyEventCopyWith<$Res> {
  factory _$EmergencyEventCopyWith(_EmergencyEvent value, $Res Function(_EmergencyEvent) _then) = __$EmergencyEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String patientId, String status, Map<String, dynamic> vitalsSnapshot, int aiSeverityScore, String aiSummary, String? assignedAmbulanceId, String? targetHospitalId
});




}
/// @nodoc
class __$EmergencyEventCopyWithImpl<$Res>
    implements _$EmergencyEventCopyWith<$Res> {
  __$EmergencyEventCopyWithImpl(this._self, this._then);

  final _EmergencyEvent _self;
  final $Res Function(_EmergencyEvent) _then;

/// Create a copy of EmergencyEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patientId = null,Object? status = null,Object? vitalsSnapshot = null,Object? aiSeverityScore = null,Object? aiSummary = null,Object? assignedAmbulanceId = freezed,Object? targetHospitalId = freezed,}) {
  return _then(_EmergencyEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,vitalsSnapshot: null == vitalsSnapshot ? _self._vitalsSnapshot : vitalsSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,aiSeverityScore: null == aiSeverityScore ? _self.aiSeverityScore : aiSeverityScore // ignore: cast_nullable_to_non_nullable
as int,aiSummary: null == aiSummary ? _self.aiSummary : aiSummary // ignore: cast_nullable_to_non_nullable
as String,assignedAmbulanceId: freezed == assignedAmbulanceId ? _self.assignedAmbulanceId : assignedAmbulanceId // ignore: cast_nullable_to_non_nullable
as String?,targetHospitalId: freezed == targetHospitalId ? _self.targetHospitalId : targetHospitalId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
