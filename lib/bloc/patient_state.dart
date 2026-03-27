part of 'patient_bloc.dart';

enum EmergencyType { none, heart, accident, fire }

enum SosStatus { idle, active }

@freezed
abstract class EmergencyContact with _$EmergencyContact {
  const factory EmergencyContact({
    required String name,
    required String number,
  }) = _EmergencyContact;
}

@freezed
abstract class MedicalHistory with _$MedicalHistory {
  const factory MedicalHistory({
    @Default('') String bloodType,
    @Default('') String allergies,
    @Default('') String medicalConditions,
    @Default('') String medications,
  }) = _MedicalHistory;
}

@freezed
abstract class PatientState with _$PatientState {
  const factory PatientState({
    @Default(SosStatus.idle) SosStatus sosStatus,
    @Default(EmergencyType.none) EmergencyType selectedEmergencyType,
    @Default(0) int heartRate,
    @Default(0) int spO2,
    @Default(false) bool showTriageQuestions,
    @Default(false) bool isConscious,
    @Default(false) bool hasSevereBleeding,
    @Default(false) bool isWearableConnected,
    @Default(false) bool isConnecting,
    @Default([]) List<String> availableDevices,
    String? connectedDeviceName,
    @Default([]) List<EmergencyContact> emergencyContacts,
    MedicalHistory? medicalHistory,
  }) = _PatientState;
}
