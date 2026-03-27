// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientProfile _$PatientProfileFromJson(Map<String, dynamic> json) =>
    _PatientProfile(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String,
      age: (json['age'] as num?)?.toInt(),
      bloodGroup: json['bloodGroup'] as String,
      emergencyContacts: (json['emergencyContacts'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      medicalContext: json['medicalContext'] as String,
      medicalHistoryDetails:
          json['medicalHistoryDetails'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PatientProfileToJson(_PatientProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'age': instance.age,
      'bloodGroup': instance.bloodGroup,
      'emergencyContacts': instance.emergencyContacts,
      'medicalContext': instance.medicalContext,
      'medicalHistoryDetails': instance.medicalHistoryDetails,
    };

_EmergencyEvent _$EmergencyEventFromJson(Map<String, dynamic> json) =>
    _EmergencyEvent(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      status: json['status'] as String,
      vitalsSnapshot: json['vitalsSnapshot'] as Map<String, dynamic>,
      aiSeverityScore: (json['aiSeverityScore'] as num).toInt(),
      aiSummary: json['aiSummary'] as String,
      assignedAmbulanceId: json['assignedAmbulanceId'] as String?,
      targetHospitalId: json['targetHospitalId'] as String?,
    );

Map<String, dynamic> _$EmergencyEventToJson(_EmergencyEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'status': instance.status,
      'vitalsSnapshot': instance.vitalsSnapshot,
      'aiSeverityScore': instance.aiSeverityScore,
      'aiSummary': instance.aiSummary,
      'assignedAmbulanceId': instance.assignedAmbulanceId,
      'targetHospitalId': instance.targetHospitalId,
    };
