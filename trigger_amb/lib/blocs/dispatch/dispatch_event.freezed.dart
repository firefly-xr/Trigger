// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispatch_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DispatchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DispatchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DispatchEvent()';
}


}

/// @nodoc
class $DispatchEventCopyWith<$Res>  {
$DispatchEventCopyWith(DispatchEvent _, $Res Function(DispatchEvent) __);
}


/// Adds pattern-matching-related methods to [DispatchEvent].
extension DispatchEventPatterns on DispatchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ReceiveAlert value)?  receiveAlert,TResult Function( _UpdateStatus value)?  updateStatus,TResult Function( _FirestoreUpdate value)?  firestoreUpdate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiveAlert() when receiveAlert != null:
return receiveAlert(_that);case _UpdateStatus() when updateStatus != null:
return updateStatus(_that);case _FirestoreUpdate() when firestoreUpdate != null:
return firestoreUpdate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ReceiveAlert value)  receiveAlert,required TResult Function( _UpdateStatus value)  updateStatus,required TResult Function( _FirestoreUpdate value)  firestoreUpdate,}){
final _that = this;
switch (_that) {
case _ReceiveAlert():
return receiveAlert(_that);case _UpdateStatus():
return updateStatus(_that);case _FirestoreUpdate():
return firestoreUpdate(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ReceiveAlert value)?  receiveAlert,TResult? Function( _UpdateStatus value)?  updateStatus,TResult? Function( _FirestoreUpdate value)?  firestoreUpdate,}){
final _that = this;
switch (_that) {
case _ReceiveAlert() when receiveAlert != null:
return receiveAlert(_that);case _UpdateStatus() when updateStatus != null:
return updateStatus(_that);case _FirestoreUpdate() when firestoreUpdate != null:
return firestoreUpdate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DispatchAlert alert)?  receiveAlert,TResult Function( DispatchStatus status)?  updateStatus,TResult Function( DispatchAlert? alert)?  firestoreUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiveAlert() when receiveAlert != null:
return receiveAlert(_that.alert);case _UpdateStatus() when updateStatus != null:
return updateStatus(_that.status);case _FirestoreUpdate() when firestoreUpdate != null:
return firestoreUpdate(_that.alert);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DispatchAlert alert)  receiveAlert,required TResult Function( DispatchStatus status)  updateStatus,required TResult Function( DispatchAlert? alert)  firestoreUpdate,}) {final _that = this;
switch (_that) {
case _ReceiveAlert():
return receiveAlert(_that.alert);case _UpdateStatus():
return updateStatus(_that.status);case _FirestoreUpdate():
return firestoreUpdate(_that.alert);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DispatchAlert alert)?  receiveAlert,TResult? Function( DispatchStatus status)?  updateStatus,TResult? Function( DispatchAlert? alert)?  firestoreUpdate,}) {final _that = this;
switch (_that) {
case _ReceiveAlert() when receiveAlert != null:
return receiveAlert(_that.alert);case _UpdateStatus() when updateStatus != null:
return updateStatus(_that.status);case _FirestoreUpdate() when firestoreUpdate != null:
return firestoreUpdate(_that.alert);case _:
  return null;

}
}

}

/// @nodoc


class _ReceiveAlert implements DispatchEvent {
  const _ReceiveAlert(this.alert);
  

 final  DispatchAlert alert;

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiveAlertCopyWith<_ReceiveAlert> get copyWith => __$ReceiveAlertCopyWithImpl<_ReceiveAlert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiveAlert&&(identical(other.alert, alert) || other.alert == alert));
}


@override
int get hashCode => Object.hash(runtimeType,alert);

@override
String toString() {
  return 'DispatchEvent.receiveAlert(alert: $alert)';
}


}

/// @nodoc
abstract mixin class _$ReceiveAlertCopyWith<$Res> implements $DispatchEventCopyWith<$Res> {
  factory _$ReceiveAlertCopyWith(_ReceiveAlert value, $Res Function(_ReceiveAlert) _then) = __$ReceiveAlertCopyWithImpl;
@useResult
$Res call({
 DispatchAlert alert
});


$DispatchAlertCopyWith<$Res> get alert;

}
/// @nodoc
class __$ReceiveAlertCopyWithImpl<$Res>
    implements _$ReceiveAlertCopyWith<$Res> {
  __$ReceiveAlertCopyWithImpl(this._self, this._then);

  final _ReceiveAlert _self;
  final $Res Function(_ReceiveAlert) _then;

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? alert = null,}) {
  return _then(_ReceiveAlert(
null == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as DispatchAlert,
  ));
}

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DispatchAlertCopyWith<$Res> get alert {
  
  return $DispatchAlertCopyWith<$Res>(_self.alert, (value) {
    return _then(_self.copyWith(alert: value));
  });
}
}

/// @nodoc


class _UpdateStatus implements DispatchEvent {
  const _UpdateStatus(this.status);
  

 final  DispatchStatus status;

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateStatusCopyWith<_UpdateStatus> get copyWith => __$UpdateStatusCopyWithImpl<_UpdateStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateStatus&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'DispatchEvent.updateStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class _$UpdateStatusCopyWith<$Res> implements $DispatchEventCopyWith<$Res> {
  factory _$UpdateStatusCopyWith(_UpdateStatus value, $Res Function(_UpdateStatus) _then) = __$UpdateStatusCopyWithImpl;
@useResult
$Res call({
 DispatchStatus status
});




}
/// @nodoc
class __$UpdateStatusCopyWithImpl<$Res>
    implements _$UpdateStatusCopyWith<$Res> {
  __$UpdateStatusCopyWithImpl(this._self, this._then);

  final _UpdateStatus _self;
  final $Res Function(_UpdateStatus) _then;

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_UpdateStatus(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DispatchStatus,
  ));
}


}

/// @nodoc


class _FirestoreUpdate implements DispatchEvent {
  const _FirestoreUpdate(this.alert);
  

 final  DispatchAlert? alert;

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirestoreUpdateCopyWith<_FirestoreUpdate> get copyWith => __$FirestoreUpdateCopyWithImpl<_FirestoreUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirestoreUpdate&&(identical(other.alert, alert) || other.alert == alert));
}


@override
int get hashCode => Object.hash(runtimeType,alert);

@override
String toString() {
  return 'DispatchEvent.firestoreUpdate(alert: $alert)';
}


}

/// @nodoc
abstract mixin class _$FirestoreUpdateCopyWith<$Res> implements $DispatchEventCopyWith<$Res> {
  factory _$FirestoreUpdateCopyWith(_FirestoreUpdate value, $Res Function(_FirestoreUpdate) _then) = __$FirestoreUpdateCopyWithImpl;
@useResult
$Res call({
 DispatchAlert? alert
});


$DispatchAlertCopyWith<$Res>? get alert;

}
/// @nodoc
class __$FirestoreUpdateCopyWithImpl<$Res>
    implements _$FirestoreUpdateCopyWith<$Res> {
  __$FirestoreUpdateCopyWithImpl(this._self, this._then);

  final _FirestoreUpdate _self;
  final $Res Function(_FirestoreUpdate) _then;

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? alert = freezed,}) {
  return _then(_FirestoreUpdate(
freezed == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as DispatchAlert?,
  ));
}

/// Create a copy of DispatchEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DispatchAlertCopyWith<$Res>? get alert {
    if (_self.alert == null) {
    return null;
  }

  return $DispatchAlertCopyWith<$Res>(_self.alert!, (value) {
    return _then(_self.copyWith(alert: value));
  });
}
}

// dart format on
