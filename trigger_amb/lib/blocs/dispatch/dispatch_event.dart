import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/dispatch_alert.dart';

part 'dispatch_event.freezed.dart';

@freezed
class DispatchEvent with _$DispatchEvent {
  const factory DispatchEvent.receiveAlert(DispatchAlert alert) = _ReceiveAlert;
  const factory DispatchEvent.updateStatus(DispatchStatus status) = _UpdateStatus;
  const factory DispatchEvent.firestoreUpdate(DispatchAlert? alert) = _FirestoreUpdate;
}
