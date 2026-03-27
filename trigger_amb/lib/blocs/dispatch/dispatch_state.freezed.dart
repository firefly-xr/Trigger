// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispatch_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DispatchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DispatchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DispatchState()';
}


}

/// @nodoc
class $DispatchStateCopyWith<$Res>  {
$DispatchStateCopyWith(DispatchState _, $Res Function(DispatchState) __);
}


/// Adds pattern-matching-related methods to [DispatchState].
extension DispatchStatePatterns on DispatchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Active value)?  active,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Active() when active != null:
return active(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Active value)  active,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Active():
return active(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Active value)?  active,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Active() when active != null:
return active(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( DispatchAlert alert)?  active,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Active() when active != null:
return active(_that.alert);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( DispatchAlert alert)  active,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Active():
return active(_that.alert);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( DispatchAlert alert)?  active,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Active() when active != null:
return active(_that.alert);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements DispatchState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DispatchState.idle()';
}


}




/// @nodoc


class _Active implements DispatchState {
  const _Active(this.alert);
  

 final  DispatchAlert alert;

/// Create a copy of DispatchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveCopyWith<_Active> get copyWith => __$ActiveCopyWithImpl<_Active>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Active&&(identical(other.alert, alert) || other.alert == alert));
}


@override
int get hashCode => Object.hash(runtimeType,alert);

@override
String toString() {
  return 'DispatchState.active(alert: $alert)';
}


}

/// @nodoc
abstract mixin class _$ActiveCopyWith<$Res> implements $DispatchStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) _then) = __$ActiveCopyWithImpl;
@useResult
$Res call({
 DispatchAlert alert
});


$DispatchAlertCopyWith<$Res> get alert;

}
/// @nodoc
class __$ActiveCopyWithImpl<$Res>
    implements _$ActiveCopyWith<$Res> {
  __$ActiveCopyWithImpl(this._self, this._then);

  final _Active _self;
  final $Res Function(_Active) _then;

/// Create a copy of DispatchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? alert = null,}) {
  return _then(_Active(
null == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as DispatchAlert,
  ));
}

/// Create a copy of DispatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DispatchAlertCopyWith<$Res> get alert {
  
  return $DispatchAlertCopyWith<$Res>(_self.alert, (value) {
    return _then(_self.copyWith(alert: value));
  });
}
}

// dart format on
