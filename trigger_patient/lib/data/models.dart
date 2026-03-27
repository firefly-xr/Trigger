import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class PatientProfile with _$PatientProfile {
  const factory PatientProfile({
    required String uid,
    required String fullName,
    int? age,
    required String bloodGroup,
    required List<Map<String, dynamic>> emergencyContacts,
    required String medicalContext,
    Map<String, dynamic>? medicalHistoryDetails,
  }) = _PatientProfile;

  factory PatientProfile.fromJson(Map<String, Object?> json) => _$PatientProfileFromJson(json);
}

@freezed
abstract class EmergencyEvent with _$EmergencyEvent {
  const factory EmergencyEvent({
    required String id,
    required String patientId,
    required String status,
    required Map<String, dynamic> vitalsSnapshot,
    required int aiSeverityScore,
    required String aiSummary,
    String? assignedAmbulanceId,
    String? targetHospitalId,
  }) = _EmergencyEvent;

  factory EmergencyEvent.fromJson(Map<String, Object?> json) => _$EmergencyEventFromJson(json);
}
