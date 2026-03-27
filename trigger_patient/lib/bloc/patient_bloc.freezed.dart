// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatientEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientEvent()';
}


}

/// @nodoc
class $PatientEventCopyWith<$Res>  {
$PatientEventCopyWith(PatientEvent _, $Res Function(PatientEvent) __);
}


/// Adds pattern-matching-related methods to [PatientEvent].
extension PatientEventPatterns on PatientEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( VitalsUpdated value)?  vitalsUpdated,TResult Function( EmergencyTypeSelected value)?  emergencyTypeSelected,TResult Function( SosTriggered value)?  sosTriggered,TResult Function( TriageAnswered value)?  triageAnswered,TResult Function( ReportForAnotherTriggered value)?  reportForAnotherTriggered,TResult Function( SearchWearables value)?  searchWearables,TResult Function( ConnectToDevice value)?  connectToDevice,TResult Function( DisconnectWearable value)?  disconnectWearable,TResult Function( AddEmergencyContact value)?  addEmergencyContact,TResult Function( RemoveEmergencyContact value)?  removeEmergencyContact,TResult Function( UpdateMedicalHistory value)?  updateMedicalHistory,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case VitalsUpdated() when vitalsUpdated != null:
return vitalsUpdated(_that);case EmergencyTypeSelected() when emergencyTypeSelected != null:
return emergencyTypeSelected(_that);case SosTriggered() when sosTriggered != null:
return sosTriggered(_that);case TriageAnswered() when triageAnswered != null:
return triageAnswered(_that);case ReportForAnotherTriggered() when reportForAnotherTriggered != null:
return reportForAnotherTriggered(_that);case SearchWearables() when searchWearables != null:
return searchWearables(_that);case ConnectToDevice() when connectToDevice != null:
return connectToDevice(_that);case DisconnectWearable() when disconnectWearable != null:
return disconnectWearable(_that);case AddEmergencyContact() when addEmergencyContact != null:
return addEmergencyContact(_that);case RemoveEmergencyContact() when removeEmergencyContact != null:
return removeEmergencyContact(_that);case UpdateMedicalHistory() when updateMedicalHistory != null:
return updateMedicalHistory(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( VitalsUpdated value)  vitalsUpdated,required TResult Function( EmergencyTypeSelected value)  emergencyTypeSelected,required TResult Function( SosTriggered value)  sosTriggered,required TResult Function( TriageAnswered value)  triageAnswered,required TResult Function( ReportForAnotherTriggered value)  reportForAnotherTriggered,required TResult Function( SearchWearables value)  searchWearables,required TResult Function( ConnectToDevice value)  connectToDevice,required TResult Function( DisconnectWearable value)  disconnectWearable,required TResult Function( AddEmergencyContact value)  addEmergencyContact,required TResult Function( RemoveEmergencyContact value)  removeEmergencyContact,required TResult Function( UpdateMedicalHistory value)  updateMedicalHistory,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case VitalsUpdated():
return vitalsUpdated(_that);case EmergencyTypeSelected():
return emergencyTypeSelected(_that);case SosTriggered():
return sosTriggered(_that);case TriageAnswered():
return triageAnswered(_that);case ReportForAnotherTriggered():
return reportForAnotherTriggered(_that);case SearchWearables():
return searchWearables(_that);case ConnectToDevice():
return connectToDevice(_that);case DisconnectWearable():
return disconnectWearable(_that);case AddEmergencyContact():
return addEmergencyContact(_that);case RemoveEmergencyContact():
return removeEmergencyContact(_that);case UpdateMedicalHistory():
return updateMedicalHistory(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( VitalsUpdated value)?  vitalsUpdated,TResult? Function( EmergencyTypeSelected value)?  emergencyTypeSelected,TResult? Function( SosTriggered value)?  sosTriggered,TResult? Function( TriageAnswered value)?  triageAnswered,TResult? Function( ReportForAnotherTriggered value)?  reportForAnotherTriggered,TResult? Function( SearchWearables value)?  searchWearables,TResult? Function( ConnectToDevice value)?  connectToDevice,TResult? Function( DisconnectWearable value)?  disconnectWearable,TResult? Function( AddEmergencyContact value)?  addEmergencyContact,TResult? Function( RemoveEmergencyContact value)?  removeEmergencyContact,TResult? Function( UpdateMedicalHistory value)?  updateMedicalHistory,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case VitalsUpdated() when vitalsUpdated != null:
return vitalsUpdated(_that);case EmergencyTypeSelected() when emergencyTypeSelected != null:
return emergencyTypeSelected(_that);case SosTriggered() when sosTriggered != null:
return sosTriggered(_that);case TriageAnswered() when triageAnswered != null:
return triageAnswered(_that);case ReportForAnotherTriggered() when reportForAnotherTriggered != null:
return reportForAnotherTriggered(_that);case SearchWearables() when searchWearables != null:
return searchWearables(_that);case ConnectToDevice() when connectToDevice != null:
return connectToDevice(_that);case DisconnectWearable() when disconnectWearable != null:
return disconnectWearable(_that);case AddEmergencyContact() when addEmergencyContact != null:
return addEmergencyContact(_that);case RemoveEmergencyContact() when removeEmergencyContact != null:
return removeEmergencyContact(_that);case UpdateMedicalHistory() when updateMedicalHistory != null:
return updateMedicalHistory(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int heartRate,  int spO2)?  vitalsUpdated,TResult Function( EmergencyType type)?  emergencyTypeSelected,TResult Function()?  sosTriggered,TResult Function( bool isConscious,  bool hasSevereBleeding)?  triageAnswered,TResult Function( String name,  String age,  String condition)?  reportForAnotherTriggered,TResult Function()?  searchWearables,TResult Function( String deviceName)?  connectToDevice,TResult Function()?  disconnectWearable,TResult Function( String name,  String number)?  addEmergencyContact,TResult Function( EmergencyContact contact)?  removeEmergencyContact,TResult Function( MedicalHistory history)?  updateMedicalHistory,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case VitalsUpdated() when vitalsUpdated != null:
return vitalsUpdated(_that.heartRate,_that.spO2);case EmergencyTypeSelected() when emergencyTypeSelected != null:
return emergencyTypeSelected(_that.type);case SosTriggered() when sosTriggered != null:
return sosTriggered();case TriageAnswered() when triageAnswered != null:
return triageAnswered(_that.isConscious,_that.hasSevereBleeding);case ReportForAnotherTriggered() when reportForAnotherTriggered != null:
return reportForAnotherTriggered(_that.name,_that.age,_that.condition);case SearchWearables() when searchWearables != null:
return searchWearables();case ConnectToDevice() when connectToDevice != null:
return connectToDevice(_that.deviceName);case DisconnectWearable() when disconnectWearable != null:
return disconnectWearable();case AddEmergencyContact() when addEmergencyContact != null:
return addEmergencyContact(_that.name,_that.number);case RemoveEmergencyContact() when removeEmergencyContact != null:
return removeEmergencyContact(_that.contact);case UpdateMedicalHistory() when updateMedicalHistory != null:
return updateMedicalHistory(_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int heartRate,  int spO2)  vitalsUpdated,required TResult Function( EmergencyType type)  emergencyTypeSelected,required TResult Function()  sosTriggered,required TResult Function( bool isConscious,  bool hasSevereBleeding)  triageAnswered,required TResult Function( String name,  String age,  String condition)  reportForAnotherTriggered,required TResult Function()  searchWearables,required TResult Function( String deviceName)  connectToDevice,required TResult Function()  disconnectWearable,required TResult Function( String name,  String number)  addEmergencyContact,required TResult Function( EmergencyContact contact)  removeEmergencyContact,required TResult Function( MedicalHistory history)  updateMedicalHistory,}) {final _that = this;
switch (_that) {
case Started():
return started();case VitalsUpdated():
return vitalsUpdated(_that.heartRate,_that.spO2);case EmergencyTypeSelected():
return emergencyTypeSelected(_that.type);case SosTriggered():
return sosTriggered();case TriageAnswered():
return triageAnswered(_that.isConscious,_that.hasSevereBleeding);case ReportForAnotherTriggered():
return reportForAnotherTriggered(_that.name,_that.age,_that.condition);case SearchWearables():
return searchWearables();case ConnectToDevice():
return connectToDevice(_that.deviceName);case DisconnectWearable():
return disconnectWearable();case AddEmergencyContact():
return addEmergencyContact(_that.name,_that.number);case RemoveEmergencyContact():
return removeEmergencyContact(_that.contact);case UpdateMedicalHistory():
return updateMedicalHistory(_that.history);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int heartRate,  int spO2)?  vitalsUpdated,TResult? Function( EmergencyType type)?  emergencyTypeSelected,TResult? Function()?  sosTriggered,TResult? Function( bool isConscious,  bool hasSevereBleeding)?  triageAnswered,TResult? Function( String name,  String age,  String condition)?  reportForAnotherTriggered,TResult? Function()?  searchWearables,TResult? Function( String deviceName)?  connectToDevice,TResult? Function()?  disconnectWearable,TResult? Function( String name,  String number)?  addEmergencyContact,TResult? Function( EmergencyContact contact)?  removeEmergencyContact,TResult? Function( MedicalHistory history)?  updateMedicalHistory,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case VitalsUpdated() when vitalsUpdated != null:
return vitalsUpdated(_that.heartRate,_that.spO2);case EmergencyTypeSelected() when emergencyTypeSelected != null:
return emergencyTypeSelected(_that.type);case SosTriggered() when sosTriggered != null:
return sosTriggered();case TriageAnswered() when triageAnswered != null:
return triageAnswered(_that.isConscious,_that.hasSevereBleeding);case ReportForAnotherTriggered() when reportForAnotherTriggered != null:
return reportForAnotherTriggered(_that.name,_that.age,_that.condition);case SearchWearables() when searchWearables != null:
return searchWearables();case ConnectToDevice() when connectToDevice != null:
return connectToDevice(_that.deviceName);case DisconnectWearable() when disconnectWearable != null:
return disconnectWearable();case AddEmergencyContact() when addEmergencyContact != null:
return addEmergencyContact(_that.name,_that.number);case RemoveEmergencyContact() when removeEmergencyContact != null:
return removeEmergencyContact(_that.contact);case UpdateMedicalHistory() when updateMedicalHistory != null:
return updateMedicalHistory(_that.history);case _:
  return null;

}
}

}

/// @nodoc


class Started implements PatientEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientEvent.started()';
}


}




/// @nodoc


class VitalsUpdated implements PatientEvent {
  const VitalsUpdated({required this.heartRate, required this.spO2});
  

 final  int heartRate;
 final  int spO2;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VitalsUpdatedCopyWith<VitalsUpdated> get copyWith => _$VitalsUpdatedCopyWithImpl<VitalsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VitalsUpdated&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.spO2, spO2) || other.spO2 == spO2));
}


@override
int get hashCode => Object.hash(runtimeType,heartRate,spO2);

@override
String toString() {
  return 'PatientEvent.vitalsUpdated(heartRate: $heartRate, spO2: $spO2)';
}


}

/// @nodoc
abstract mixin class $VitalsUpdatedCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $VitalsUpdatedCopyWith(VitalsUpdated value, $Res Function(VitalsUpdated) _then) = _$VitalsUpdatedCopyWithImpl;
@useResult
$Res call({
 int heartRate, int spO2
});




}
/// @nodoc
class _$VitalsUpdatedCopyWithImpl<$Res>
    implements $VitalsUpdatedCopyWith<$Res> {
  _$VitalsUpdatedCopyWithImpl(this._self, this._then);

  final VitalsUpdated _self;
  final $Res Function(VitalsUpdated) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? heartRate = null,Object? spO2 = null,}) {
  return _then(VitalsUpdated(
heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,spO2: null == spO2 ? _self.spO2 : spO2 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class EmergencyTypeSelected implements PatientEvent {
  const EmergencyTypeSelected(this.type);
  

 final  EmergencyType type;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyTypeSelectedCopyWith<EmergencyTypeSelected> get copyWith => _$EmergencyTypeSelectedCopyWithImpl<EmergencyTypeSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyTypeSelected&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'PatientEvent.emergencyTypeSelected(type: $type)';
}


}

/// @nodoc
abstract mixin class $EmergencyTypeSelectedCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $EmergencyTypeSelectedCopyWith(EmergencyTypeSelected value, $Res Function(EmergencyTypeSelected) _then) = _$EmergencyTypeSelectedCopyWithImpl;
@useResult
$Res call({
 EmergencyType type
});




}
/// @nodoc
class _$EmergencyTypeSelectedCopyWithImpl<$Res>
    implements $EmergencyTypeSelectedCopyWith<$Res> {
  _$EmergencyTypeSelectedCopyWithImpl(this._self, this._then);

  final EmergencyTypeSelected _self;
  final $Res Function(EmergencyTypeSelected) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(EmergencyTypeSelected(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EmergencyType,
  ));
}


}

/// @nodoc


class SosTriggered implements PatientEvent {
  const SosTriggered();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SosTriggered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientEvent.sosTriggered()';
}


}




/// @nodoc


class TriageAnswered implements PatientEvent {
  const TriageAnswered({required this.isConscious, required this.hasSevereBleeding});
  

 final  bool isConscious;
 final  bool hasSevereBleeding;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TriageAnsweredCopyWith<TriageAnswered> get copyWith => _$TriageAnsweredCopyWithImpl<TriageAnswered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriageAnswered&&(identical(other.isConscious, isConscious) || other.isConscious == isConscious)&&(identical(other.hasSevereBleeding, hasSevereBleeding) || other.hasSevereBleeding == hasSevereBleeding));
}


@override
int get hashCode => Object.hash(runtimeType,isConscious,hasSevereBleeding);

@override
String toString() {
  return 'PatientEvent.triageAnswered(isConscious: $isConscious, hasSevereBleeding: $hasSevereBleeding)';
}


}

/// @nodoc
abstract mixin class $TriageAnsweredCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $TriageAnsweredCopyWith(TriageAnswered value, $Res Function(TriageAnswered) _then) = _$TriageAnsweredCopyWithImpl;
@useResult
$Res call({
 bool isConscious, bool hasSevereBleeding
});




}
/// @nodoc
class _$TriageAnsweredCopyWithImpl<$Res>
    implements $TriageAnsweredCopyWith<$Res> {
  _$TriageAnsweredCopyWithImpl(this._self, this._then);

  final TriageAnswered _self;
  final $Res Function(TriageAnswered) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isConscious = null,Object? hasSevereBleeding = null,}) {
  return _then(TriageAnswered(
isConscious: null == isConscious ? _self.isConscious : isConscious // ignore: cast_nullable_to_non_nullable
as bool,hasSevereBleeding: null == hasSevereBleeding ? _self.hasSevereBleeding : hasSevereBleeding // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ReportForAnotherTriggered implements PatientEvent {
  const ReportForAnotherTriggered({required this.name, required this.age, required this.condition});
  

 final  String name;
 final  String age;
 final  String condition;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportForAnotherTriggeredCopyWith<ReportForAnotherTriggered> get copyWith => _$ReportForAnotherTriggeredCopyWithImpl<ReportForAnotherTriggered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportForAnotherTriggered&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,name,age,condition);

@override
String toString() {
  return 'PatientEvent.reportForAnotherTriggered(name: $name, age: $age, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $ReportForAnotherTriggeredCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $ReportForAnotherTriggeredCopyWith(ReportForAnotherTriggered value, $Res Function(ReportForAnotherTriggered) _then) = _$ReportForAnotherTriggeredCopyWithImpl;
@useResult
$Res call({
 String name, String age, String condition
});




}
/// @nodoc
class _$ReportForAnotherTriggeredCopyWithImpl<$Res>
    implements $ReportForAnotherTriggeredCopyWith<$Res> {
  _$ReportForAnotherTriggeredCopyWithImpl(this._self, this._then);

  final ReportForAnotherTriggered _self;
  final $Res Function(ReportForAnotherTriggered) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,Object? condition = null,}) {
  return _then(ReportForAnotherTriggered(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchWearables implements PatientEvent {
  const SearchWearables();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchWearables);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientEvent.searchWearables()';
}


}




/// @nodoc


class ConnectToDevice implements PatientEvent {
  const ConnectToDevice({required this.deviceName});
  

 final  String deviceName;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectToDeviceCopyWith<ConnectToDevice> get copyWith => _$ConnectToDeviceCopyWithImpl<ConnectToDevice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectToDevice&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName));
}


@override
int get hashCode => Object.hash(runtimeType,deviceName);

@override
String toString() {
  return 'PatientEvent.connectToDevice(deviceName: $deviceName)';
}


}

/// @nodoc
abstract mixin class $ConnectToDeviceCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $ConnectToDeviceCopyWith(ConnectToDevice value, $Res Function(ConnectToDevice) _then) = _$ConnectToDeviceCopyWithImpl;
@useResult
$Res call({
 String deviceName
});




}
/// @nodoc
class _$ConnectToDeviceCopyWithImpl<$Res>
    implements $ConnectToDeviceCopyWith<$Res> {
  _$ConnectToDeviceCopyWithImpl(this._self, this._then);

  final ConnectToDevice _self;
  final $Res Function(ConnectToDevice) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? deviceName = null,}) {
  return _then(ConnectToDevice(
deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DisconnectWearable implements PatientEvent {
  const DisconnectWearable();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisconnectWearable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientEvent.disconnectWearable()';
}


}




/// @nodoc


class AddEmergencyContact implements PatientEvent {
  const AddEmergencyContact(this.name, this.number);
  

 final  String name;
 final  String number;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddEmergencyContactCopyWith<AddEmergencyContact> get copyWith => _$AddEmergencyContactCopyWithImpl<AddEmergencyContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddEmergencyContact&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,name,number);

@override
String toString() {
  return 'PatientEvent.addEmergencyContact(name: $name, number: $number)';
}


}

/// @nodoc
abstract mixin class $AddEmergencyContactCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $AddEmergencyContactCopyWith(AddEmergencyContact value, $Res Function(AddEmergencyContact) _then) = _$AddEmergencyContactCopyWithImpl;
@useResult
$Res call({
 String name, String number
});




}
/// @nodoc
class _$AddEmergencyContactCopyWithImpl<$Res>
    implements $AddEmergencyContactCopyWith<$Res> {
  _$AddEmergencyContactCopyWithImpl(this._self, this._then);

  final AddEmergencyContact _self;
  final $Res Function(AddEmergencyContact) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? number = null,}) {
  return _then(AddEmergencyContact(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RemoveEmergencyContact implements PatientEvent {
  const RemoveEmergencyContact(this.contact);
  

 final  EmergencyContact contact;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveEmergencyContactCopyWith<RemoveEmergencyContact> get copyWith => _$RemoveEmergencyContactCopyWithImpl<RemoveEmergencyContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveEmergencyContact&&(identical(other.contact, contact) || other.contact == contact));
}


@override
int get hashCode => Object.hash(runtimeType,contact);

@override
String toString() {
  return 'PatientEvent.removeEmergencyContact(contact: $contact)';
}


}

/// @nodoc
abstract mixin class $RemoveEmergencyContactCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $RemoveEmergencyContactCopyWith(RemoveEmergencyContact value, $Res Function(RemoveEmergencyContact) _then) = _$RemoveEmergencyContactCopyWithImpl;
@useResult
$Res call({
 EmergencyContact contact
});


$EmergencyContactCopyWith<$Res> get contact;

}
/// @nodoc
class _$RemoveEmergencyContactCopyWithImpl<$Res>
    implements $RemoveEmergencyContactCopyWith<$Res> {
  _$RemoveEmergencyContactCopyWithImpl(this._self, this._then);

  final RemoveEmergencyContact _self;
  final $Res Function(RemoveEmergencyContact) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contact = null,}) {
  return _then(RemoveEmergencyContact(
null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as EmergencyContact,
  ));
}

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res> get contact {
  
  return $EmergencyContactCopyWith<$Res>(_self.contact, (value) {
    return _then(_self.copyWith(contact: value));
  });
}
}

/// @nodoc


class UpdateMedicalHistory implements PatientEvent {
  const UpdateMedicalHistory(this.history);
  

 final  MedicalHistory history;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateMedicalHistoryCopyWith<UpdateMedicalHistory> get copyWith => _$UpdateMedicalHistoryCopyWithImpl<UpdateMedicalHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateMedicalHistory&&(identical(other.history, history) || other.history == history));
}


@override
int get hashCode => Object.hash(runtimeType,history);

@override
String toString() {
  return 'PatientEvent.updateMedicalHistory(history: $history)';
}


}

/// @nodoc
abstract mixin class $UpdateMedicalHistoryCopyWith<$Res> implements $PatientEventCopyWith<$Res> {
  factory $UpdateMedicalHistoryCopyWith(UpdateMedicalHistory value, $Res Function(UpdateMedicalHistory) _then) = _$UpdateMedicalHistoryCopyWithImpl;
@useResult
$Res call({
 MedicalHistory history
});


$MedicalHistoryCopyWith<$Res> get history;

}
/// @nodoc
class _$UpdateMedicalHistoryCopyWithImpl<$Res>
    implements $UpdateMedicalHistoryCopyWith<$Res> {
  _$UpdateMedicalHistoryCopyWithImpl(this._self, this._then);

  final UpdateMedicalHistory _self;
  final $Res Function(UpdateMedicalHistory) _then;

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(UpdateMedicalHistory(
null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as MedicalHistory,
  ));
}

/// Create a copy of PatientEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MedicalHistoryCopyWith<$Res> get history {
  
  return $MedicalHistoryCopyWith<$Res>(_self.history, (value) {
    return _then(_self.copyWith(history: value));
  });
}
}

/// @nodoc
mixin _$EmergencyContact {

 String get name; String get number;
/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<EmergencyContact> get copyWith => _$EmergencyContactCopyWithImpl<EmergencyContact>(this as EmergencyContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyContact&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,name,number);

@override
String toString() {
  return 'EmergencyContact(name: $name, number: $number)';
}


}

/// @nodoc
abstract mixin class $EmergencyContactCopyWith<$Res>  {
  factory $EmergencyContactCopyWith(EmergencyContact value, $Res Function(EmergencyContact) _then) = _$EmergencyContactCopyWithImpl;
@useResult
$Res call({
 String name, String number
});




}
/// @nodoc
class _$EmergencyContactCopyWithImpl<$Res>
    implements $EmergencyContactCopyWith<$Res> {
  _$EmergencyContactCopyWithImpl(this._self, this._then);

  final EmergencyContact _self;
  final $Res Function(EmergencyContact) _then;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? number = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmergencyContact].
extension EmergencyContactPatterns on EmergencyContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyContact value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyContact value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String number)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
return $default(_that.name,_that.number);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String number)  $default,) {final _that = this;
switch (_that) {
case _EmergencyContact():
return $default(_that.name,_that.number);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String number)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
return $default(_that.name,_that.number);case _:
  return null;

}
}

}

/// @nodoc


class _EmergencyContact implements EmergencyContact {
  const _EmergencyContact({required this.name, required this.number});
  

@override final  String name;
@override final  String number;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyContactCopyWith<_EmergencyContact> get copyWith => __$EmergencyContactCopyWithImpl<_EmergencyContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyContact&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number));
}


@override
int get hashCode => Object.hash(runtimeType,name,number);

@override
String toString() {
  return 'EmergencyContact(name: $name, number: $number)';
}


}

/// @nodoc
abstract mixin class _$EmergencyContactCopyWith<$Res> implements $EmergencyContactCopyWith<$Res> {
  factory _$EmergencyContactCopyWith(_EmergencyContact value, $Res Function(_EmergencyContact) _then) = __$EmergencyContactCopyWithImpl;
@override @useResult
$Res call({
 String name, String number
});




}
/// @nodoc
class __$EmergencyContactCopyWithImpl<$Res>
    implements _$EmergencyContactCopyWith<$Res> {
  __$EmergencyContactCopyWithImpl(this._self, this._then);

  final _EmergencyContact _self;
  final $Res Function(_EmergencyContact) _then;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? number = null,}) {
  return _then(_EmergencyContact(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MedicalHistory {

 String get bloodType; String get allergies; String get medicalConditions; String get medications;
/// Create a copy of MedicalHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicalHistoryCopyWith<MedicalHistory> get copyWith => _$MedicalHistoryCopyWithImpl<MedicalHistory>(this as MedicalHistory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalHistory&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.allergies, allergies) || other.allergies == allergies)&&(identical(other.medicalConditions, medicalConditions) || other.medicalConditions == medicalConditions)&&(identical(other.medications, medications) || other.medications == medications));
}


@override
int get hashCode => Object.hash(runtimeType,bloodType,allergies,medicalConditions,medications);

@override
String toString() {
  return 'MedicalHistory(bloodType: $bloodType, allergies: $allergies, medicalConditions: $medicalConditions, medications: $medications)';
}


}

/// @nodoc
abstract mixin class $MedicalHistoryCopyWith<$Res>  {
  factory $MedicalHistoryCopyWith(MedicalHistory value, $Res Function(MedicalHistory) _then) = _$MedicalHistoryCopyWithImpl;
@useResult
$Res call({
 String bloodType, String allergies, String medicalConditions, String medications
});




}
/// @nodoc
class _$MedicalHistoryCopyWithImpl<$Res>
    implements $MedicalHistoryCopyWith<$Res> {
  _$MedicalHistoryCopyWithImpl(this._self, this._then);

  final MedicalHistory _self;
  final $Res Function(MedicalHistory) _then;

/// Create a copy of MedicalHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bloodType = null,Object? allergies = null,Object? medicalConditions = null,Object? medications = null,}) {
  return _then(_self.copyWith(
bloodType: null == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String,allergies: null == allergies ? _self.allergies : allergies // ignore: cast_nullable_to_non_nullable
as String,medicalConditions: null == medicalConditions ? _self.medicalConditions : medicalConditions // ignore: cast_nullable_to_non_nullable
as String,medications: null == medications ? _self.medications : medications // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicalHistory].
extension MedicalHistoryPatterns on MedicalHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicalHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicalHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicalHistory value)  $default,){
final _that = this;
switch (_that) {
case _MedicalHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicalHistory value)?  $default,){
final _that = this;
switch (_that) {
case _MedicalHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bloodType,  String allergies,  String medicalConditions,  String medications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicalHistory() when $default != null:
return $default(_that.bloodType,_that.allergies,_that.medicalConditions,_that.medications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bloodType,  String allergies,  String medicalConditions,  String medications)  $default,) {final _that = this;
switch (_that) {
case _MedicalHistory():
return $default(_that.bloodType,_that.allergies,_that.medicalConditions,_that.medications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bloodType,  String allergies,  String medicalConditions,  String medications)?  $default,) {final _that = this;
switch (_that) {
case _MedicalHistory() when $default != null:
return $default(_that.bloodType,_that.allergies,_that.medicalConditions,_that.medications);case _:
  return null;

}
}

}

/// @nodoc


class _MedicalHistory implements MedicalHistory {
  const _MedicalHistory({this.bloodType = '', this.allergies = '', this.medicalConditions = '', this.medications = ''});
  

@override@JsonKey() final  String bloodType;
@override@JsonKey() final  String allergies;
@override@JsonKey() final  String medicalConditions;
@override@JsonKey() final  String medications;

/// Create a copy of MedicalHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicalHistoryCopyWith<_MedicalHistory> get copyWith => __$MedicalHistoryCopyWithImpl<_MedicalHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicalHistory&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.allergies, allergies) || other.allergies == allergies)&&(identical(other.medicalConditions, medicalConditions) || other.medicalConditions == medicalConditions)&&(identical(other.medications, medications) || other.medications == medications));
}


@override
int get hashCode => Object.hash(runtimeType,bloodType,allergies,medicalConditions,medications);

@override
String toString() {
  return 'MedicalHistory(bloodType: $bloodType, allergies: $allergies, medicalConditions: $medicalConditions, medications: $medications)';
}


}

/// @nodoc
abstract mixin class _$MedicalHistoryCopyWith<$Res> implements $MedicalHistoryCopyWith<$Res> {
  factory _$MedicalHistoryCopyWith(_MedicalHistory value, $Res Function(_MedicalHistory) _then) = __$MedicalHistoryCopyWithImpl;
@override @useResult
$Res call({
 String bloodType, String allergies, String medicalConditions, String medications
});




}
/// @nodoc
class __$MedicalHistoryCopyWithImpl<$Res>
    implements _$MedicalHistoryCopyWith<$Res> {
  __$MedicalHistoryCopyWithImpl(this._self, this._then);

  final _MedicalHistory _self;
  final $Res Function(_MedicalHistory) _then;

/// Create a copy of MedicalHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bloodType = null,Object? allergies = null,Object? medicalConditions = null,Object? medications = null,}) {
  return _then(_MedicalHistory(
bloodType: null == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String,allergies: null == allergies ? _self.allergies : allergies // ignore: cast_nullable_to_non_nullable
as String,medicalConditions: null == medicalConditions ? _self.medicalConditions : medicalConditions // ignore: cast_nullable_to_non_nullable
as String,medications: null == medications ? _self.medications : medications // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PatientState {

 SosStatus get sosStatus; EmergencyType get selectedEmergencyType; int get heartRate; int get spO2; bool get showTriageQuestions; bool get isConscious; bool get hasSevereBleeding; bool get isWearableConnected; bool get isConnecting; List<String> get availableDevices; String? get connectedDeviceName; List<EmergencyContact> get emergencyContacts; MedicalHistory? get medicalHistory;
/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientStateCopyWith<PatientState> get copyWith => _$PatientStateCopyWithImpl<PatientState>(this as PatientState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientState&&(identical(other.sosStatus, sosStatus) || other.sosStatus == sosStatus)&&(identical(other.selectedEmergencyType, selectedEmergencyType) || other.selectedEmergencyType == selectedEmergencyType)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.spO2, spO2) || other.spO2 == spO2)&&(identical(other.showTriageQuestions, showTriageQuestions) || other.showTriageQuestions == showTriageQuestions)&&(identical(other.isConscious, isConscious) || other.isConscious == isConscious)&&(identical(other.hasSevereBleeding, hasSevereBleeding) || other.hasSevereBleeding == hasSevereBleeding)&&(identical(other.isWearableConnected, isWearableConnected) || other.isWearableConnected == isWearableConnected)&&(identical(other.isConnecting, isConnecting) || other.isConnecting == isConnecting)&&const DeepCollectionEquality().equals(other.availableDevices, availableDevices)&&(identical(other.connectedDeviceName, connectedDeviceName) || other.connectedDeviceName == connectedDeviceName)&&const DeepCollectionEquality().equals(other.emergencyContacts, emergencyContacts)&&(identical(other.medicalHistory, medicalHistory) || other.medicalHistory == medicalHistory));
}


@override
int get hashCode => Object.hash(runtimeType,sosStatus,selectedEmergencyType,heartRate,spO2,showTriageQuestions,isConscious,hasSevereBleeding,isWearableConnected,isConnecting,const DeepCollectionEquality().hash(availableDevices),connectedDeviceName,const DeepCollectionEquality().hash(emergencyContacts),medicalHistory);

@override
String toString() {
  return 'PatientState(sosStatus: $sosStatus, selectedEmergencyType: $selectedEmergencyType, heartRate: $heartRate, spO2: $spO2, showTriageQuestions: $showTriageQuestions, isConscious: $isConscious, hasSevereBleeding: $hasSevereBleeding, isWearableConnected: $isWearableConnected, isConnecting: $isConnecting, availableDevices: $availableDevices, connectedDeviceName: $connectedDeviceName, emergencyContacts: $emergencyContacts, medicalHistory: $medicalHistory)';
}


}

/// @nodoc
abstract mixin class $PatientStateCopyWith<$Res>  {
  factory $PatientStateCopyWith(PatientState value, $Res Function(PatientState) _then) = _$PatientStateCopyWithImpl;
@useResult
$Res call({
 SosStatus sosStatus, EmergencyType selectedEmergencyType, int heartRate, int spO2, bool showTriageQuestions, bool isConscious, bool hasSevereBleeding, bool isWearableConnected, bool isConnecting, List<String> availableDevices, String? connectedDeviceName, List<EmergencyContact> emergencyContacts, MedicalHistory? medicalHistory
});


$MedicalHistoryCopyWith<$Res>? get medicalHistory;

}
/// @nodoc
class _$PatientStateCopyWithImpl<$Res>
    implements $PatientStateCopyWith<$Res> {
  _$PatientStateCopyWithImpl(this._self, this._then);

  final PatientState _self;
  final $Res Function(PatientState) _then;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sosStatus = null,Object? selectedEmergencyType = null,Object? heartRate = null,Object? spO2 = null,Object? showTriageQuestions = null,Object? isConscious = null,Object? hasSevereBleeding = null,Object? isWearableConnected = null,Object? isConnecting = null,Object? availableDevices = null,Object? connectedDeviceName = freezed,Object? emergencyContacts = null,Object? medicalHistory = freezed,}) {
  return _then(_self.copyWith(
sosStatus: null == sosStatus ? _self.sosStatus : sosStatus // ignore: cast_nullable_to_non_nullable
as SosStatus,selectedEmergencyType: null == selectedEmergencyType ? _self.selectedEmergencyType : selectedEmergencyType // ignore: cast_nullable_to_non_nullable
as EmergencyType,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,spO2: null == spO2 ? _self.spO2 : spO2 // ignore: cast_nullable_to_non_nullable
as int,showTriageQuestions: null == showTriageQuestions ? _self.showTriageQuestions : showTriageQuestions // ignore: cast_nullable_to_non_nullable
as bool,isConscious: null == isConscious ? _self.isConscious : isConscious // ignore: cast_nullable_to_non_nullable
as bool,hasSevereBleeding: null == hasSevereBleeding ? _self.hasSevereBleeding : hasSevereBleeding // ignore: cast_nullable_to_non_nullable
as bool,isWearableConnected: null == isWearableConnected ? _self.isWearableConnected : isWearableConnected // ignore: cast_nullable_to_non_nullable
as bool,isConnecting: null == isConnecting ? _self.isConnecting : isConnecting // ignore: cast_nullable_to_non_nullable
as bool,availableDevices: null == availableDevices ? _self.availableDevices : availableDevices // ignore: cast_nullable_to_non_nullable
as List<String>,connectedDeviceName: freezed == connectedDeviceName ? _self.connectedDeviceName : connectedDeviceName // ignore: cast_nullable_to_non_nullable
as String?,emergencyContacts: null == emergencyContacts ? _self.emergencyContacts : emergencyContacts // ignore: cast_nullable_to_non_nullable
as List<EmergencyContact>,medicalHistory: freezed == medicalHistory ? _self.medicalHistory : medicalHistory // ignore: cast_nullable_to_non_nullable
as MedicalHistory?,
  ));
}
/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MedicalHistoryCopyWith<$Res>? get medicalHistory {
    if (_self.medicalHistory == null) {
    return null;
  }

  return $MedicalHistoryCopyWith<$Res>(_self.medicalHistory!, (value) {
    return _then(_self.copyWith(medicalHistory: value));
  });
}
}


/// Adds pattern-matching-related methods to [PatientState].
extension PatientStatePatterns on PatientState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientState value)  $default,){
final _that = this;
switch (_that) {
case _PatientState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientState value)?  $default,){
final _that = this;
switch (_that) {
case _PatientState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SosStatus sosStatus,  EmergencyType selectedEmergencyType,  int heartRate,  int spO2,  bool showTriageQuestions,  bool isConscious,  bool hasSevereBleeding,  bool isWearableConnected,  bool isConnecting,  List<String> availableDevices,  String? connectedDeviceName,  List<EmergencyContact> emergencyContacts,  MedicalHistory? medicalHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientState() when $default != null:
return $default(_that.sosStatus,_that.selectedEmergencyType,_that.heartRate,_that.spO2,_that.showTriageQuestions,_that.isConscious,_that.hasSevereBleeding,_that.isWearableConnected,_that.isConnecting,_that.availableDevices,_that.connectedDeviceName,_that.emergencyContacts,_that.medicalHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SosStatus sosStatus,  EmergencyType selectedEmergencyType,  int heartRate,  int spO2,  bool showTriageQuestions,  bool isConscious,  bool hasSevereBleeding,  bool isWearableConnected,  bool isConnecting,  List<String> availableDevices,  String? connectedDeviceName,  List<EmergencyContact> emergencyContacts,  MedicalHistory? medicalHistory)  $default,) {final _that = this;
switch (_that) {
case _PatientState():
return $default(_that.sosStatus,_that.selectedEmergencyType,_that.heartRate,_that.spO2,_that.showTriageQuestions,_that.isConscious,_that.hasSevereBleeding,_that.isWearableConnected,_that.isConnecting,_that.availableDevices,_that.connectedDeviceName,_that.emergencyContacts,_that.medicalHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SosStatus sosStatus,  EmergencyType selectedEmergencyType,  int heartRate,  int spO2,  bool showTriageQuestions,  bool isConscious,  bool hasSevereBleeding,  bool isWearableConnected,  bool isConnecting,  List<String> availableDevices,  String? connectedDeviceName,  List<EmergencyContact> emergencyContacts,  MedicalHistory? medicalHistory)?  $default,) {final _that = this;
switch (_that) {
case _PatientState() when $default != null:
return $default(_that.sosStatus,_that.selectedEmergencyType,_that.heartRate,_that.spO2,_that.showTriageQuestions,_that.isConscious,_that.hasSevereBleeding,_that.isWearableConnected,_that.isConnecting,_that.availableDevices,_that.connectedDeviceName,_that.emergencyContacts,_that.medicalHistory);case _:
  return null;

}
}

}

/// @nodoc


class _PatientState implements PatientState {
  const _PatientState({this.sosStatus = SosStatus.idle, this.selectedEmergencyType = EmergencyType.none, this.heartRate = 0, this.spO2 = 0, this.showTriageQuestions = false, this.isConscious = false, this.hasSevereBleeding = false, this.isWearableConnected = false, this.isConnecting = false, final  List<String> availableDevices = const [], this.connectedDeviceName, final  List<EmergencyContact> emergencyContacts = const [], this.medicalHistory}): _availableDevices = availableDevices,_emergencyContacts = emergencyContacts;
  

@override@JsonKey() final  SosStatus sosStatus;
@override@JsonKey() final  EmergencyType selectedEmergencyType;
@override@JsonKey() final  int heartRate;
@override@JsonKey() final  int spO2;
@override@JsonKey() final  bool showTriageQuestions;
@override@JsonKey() final  bool isConscious;
@override@JsonKey() final  bool hasSevereBleeding;
@override@JsonKey() final  bool isWearableConnected;
@override@JsonKey() final  bool isConnecting;
 final  List<String> _availableDevices;
@override@JsonKey() List<String> get availableDevices {
  if (_availableDevices is EqualUnmodifiableListView) return _availableDevices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableDevices);
}

@override final  String? connectedDeviceName;
 final  List<EmergencyContact> _emergencyContacts;
@override@JsonKey() List<EmergencyContact> get emergencyContacts {
  if (_emergencyContacts is EqualUnmodifiableListView) return _emergencyContacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emergencyContacts);
}

@override final  MedicalHistory? medicalHistory;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientStateCopyWith<_PatientState> get copyWith => __$PatientStateCopyWithImpl<_PatientState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientState&&(identical(other.sosStatus, sosStatus) || other.sosStatus == sosStatus)&&(identical(other.selectedEmergencyType, selectedEmergencyType) || other.selectedEmergencyType == selectedEmergencyType)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.spO2, spO2) || other.spO2 == spO2)&&(identical(other.showTriageQuestions, showTriageQuestions) || other.showTriageQuestions == showTriageQuestions)&&(identical(other.isConscious, isConscious) || other.isConscious == isConscious)&&(identical(other.hasSevereBleeding, hasSevereBleeding) || other.hasSevereBleeding == hasSevereBleeding)&&(identical(other.isWearableConnected, isWearableConnected) || other.isWearableConnected == isWearableConnected)&&(identical(other.isConnecting, isConnecting) || other.isConnecting == isConnecting)&&const DeepCollectionEquality().equals(other._availableDevices, _availableDevices)&&(identical(other.connectedDeviceName, connectedDeviceName) || other.connectedDeviceName == connectedDeviceName)&&const DeepCollectionEquality().equals(other._emergencyContacts, _emergencyContacts)&&(identical(other.medicalHistory, medicalHistory) || other.medicalHistory == medicalHistory));
}


@override
int get hashCode => Object.hash(runtimeType,sosStatus,selectedEmergencyType,heartRate,spO2,showTriageQuestions,isConscious,hasSevereBleeding,isWearableConnected,isConnecting,const DeepCollectionEquality().hash(_availableDevices),connectedDeviceName,const DeepCollectionEquality().hash(_emergencyContacts),medicalHistory);

@override
String toString() {
  return 'PatientState(sosStatus: $sosStatus, selectedEmergencyType: $selectedEmergencyType, heartRate: $heartRate, spO2: $spO2, showTriageQuestions: $showTriageQuestions, isConscious: $isConscious, hasSevereBleeding: $hasSevereBleeding, isWearableConnected: $isWearableConnected, isConnecting: $isConnecting, availableDevices: $availableDevices, connectedDeviceName: $connectedDeviceName, emergencyContacts: $emergencyContacts, medicalHistory: $medicalHistory)';
}


}

/// @nodoc
abstract mixin class _$PatientStateCopyWith<$Res> implements $PatientStateCopyWith<$Res> {
  factory _$PatientStateCopyWith(_PatientState value, $Res Function(_PatientState) _then) = __$PatientStateCopyWithImpl;
@override @useResult
$Res call({
 SosStatus sosStatus, EmergencyType selectedEmergencyType, int heartRate, int spO2, bool showTriageQuestions, bool isConscious, bool hasSevereBleeding, bool isWearableConnected, bool isConnecting, List<String> availableDevices, String? connectedDeviceName, List<EmergencyContact> emergencyContacts, MedicalHistory? medicalHistory
});


@override $MedicalHistoryCopyWith<$Res>? get medicalHistory;

}
/// @nodoc
class __$PatientStateCopyWithImpl<$Res>
    implements _$PatientStateCopyWith<$Res> {
  __$PatientStateCopyWithImpl(this._self, this._then);

  final _PatientState _self;
  final $Res Function(_PatientState) _then;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sosStatus = null,Object? selectedEmergencyType = null,Object? heartRate = null,Object? spO2 = null,Object? showTriageQuestions = null,Object? isConscious = null,Object? hasSevereBleeding = null,Object? isWearableConnected = null,Object? isConnecting = null,Object? availableDevices = null,Object? connectedDeviceName = freezed,Object? emergencyContacts = null,Object? medicalHistory = freezed,}) {
  return _then(_PatientState(
sosStatus: null == sosStatus ? _self.sosStatus : sosStatus // ignore: cast_nullable_to_non_nullable
as SosStatus,selectedEmergencyType: null == selectedEmergencyType ? _self.selectedEmergencyType : selectedEmergencyType // ignore: cast_nullable_to_non_nullable
as EmergencyType,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,spO2: null == spO2 ? _self.spO2 : spO2 // ignore: cast_nullable_to_non_nullable
as int,showTriageQuestions: null == showTriageQuestions ? _self.showTriageQuestions : showTriageQuestions // ignore: cast_nullable_to_non_nullable
as bool,isConscious: null == isConscious ? _self.isConscious : isConscious // ignore: cast_nullable_to_non_nullable
as bool,hasSevereBleeding: null == hasSevereBleeding ? _self.hasSevereBleeding : hasSevereBleeding // ignore: cast_nullable_to_non_nullable
as bool,isWearableConnected: null == isWearableConnected ? _self.isWearableConnected : isWearableConnected // ignore: cast_nullable_to_non_nullable
as bool,isConnecting: null == isConnecting ? _self.isConnecting : isConnecting // ignore: cast_nullable_to_non_nullable
as bool,availableDevices: null == availableDevices ? _self._availableDevices : availableDevices // ignore: cast_nullable_to_non_nullable
as List<String>,connectedDeviceName: freezed == connectedDeviceName ? _self.connectedDeviceName : connectedDeviceName // ignore: cast_nullable_to_non_nullable
as String?,emergencyContacts: null == emergencyContacts ? _self._emergencyContacts : emergencyContacts // ignore: cast_nullable_to_non_nullable
as List<EmergencyContact>,medicalHistory: freezed == medicalHistory ? _self.medicalHistory : medicalHistory // ignore: cast_nullable_to_non_nullable
as MedicalHistory?,
  ));
}

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MedicalHistoryCopyWith<$Res>? get medicalHistory {
    if (_self.medicalHistory == null) {
    return null;
  }

  return $MedicalHistoryCopyWith<$Res>(_self.medicalHistory!, (value) {
    return _then(_self.copyWith(medicalHistory: value));
  });
}
}

// dart format on
