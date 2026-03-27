import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/dispatch_alert.dart';

part 'dispatch_state.freezed.dart';

@freezed
class DispatchState with _$DispatchState {
  const factory DispatchState.idle() = _Idle;
  const factory DispatchState.active(DispatchAlert alert) = _Active;
}
