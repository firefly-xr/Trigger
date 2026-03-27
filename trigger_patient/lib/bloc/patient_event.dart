part of 'patient_bloc.dart';

@freezed
sealed class PatientEvent with _$PatientEvent {
  const factory PatientEvent.started() = Started;
  const factory PatientEvent.vitalsUpdated({
    required int heartRate,
    required int spO2,
  }) = VitalsUpdated;
  const factory PatientEvent.emergencyTypeSelected(EmergencyType type) = EmergencyTypeSelected;
  const factory PatientEvent.sosTriggered() = SosTriggered;
  const factory PatientEvent.triageAnswered({
    required bool isConscious,
    required bool hasSevereBleeding,
  }) = TriageAnswered;
  
  const factory PatientEvent.reportForAnotherTriggered({
    required String name,
    required String age,
    required String condition,
  }) = ReportForAnotherTriggered;

  const factory PatientEvent.searchWearables() = SearchWearables;
  const factory PatientEvent.connectToDevice({required String deviceName}) = ConnectToDevice;
  const factory PatientEvent.disconnectWearable() = DisconnectWearable;

  const factory PatientEvent.addEmergencyContact(String name, String number) = AddEmergencyContact;
  const factory PatientEvent.removeEmergencyContact(EmergencyContact contact) = RemoveEmergencyContact;

  const factory PatientEvent.updateMedicalHistory(MedicalHistory history) = UpdateMedicalHistory;
}
