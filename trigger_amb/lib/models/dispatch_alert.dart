import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'dispatch_alert.freezed.dart';

enum DispatchStatus { idle, dispatched, enRoute, atScene, transporting }

extension DispatchStatusExtension on DispatchStatus {
  String get name => toString().split('.').last;
}

@freezed
abstract class DispatchAlert with _$DispatchAlert {
  const DispatchAlert._();

  const factory DispatchAlert({
    String? id,
    required String patientId,
    String? patientName,
    required double latitude,
    required double longitude,

    /// 1-Critical to 5-Low
    required int aiSeverityScore,
    required String aiSummary,
    required DispatchStatus status,
    int? age,
    String? gender,
    DateTime? timestamp,
  }) = _DispatchAlert;

  factory DispatchAlert.fromMap(String id, Map<String, dynamic> data) {
    final locationMap = data['patientLocation'] as Map<String, dynamic>? ?? {};
    final lat = (locationMap['lat'] as num?)?.toDouble() ?? 0.0;
    final lng = (locationMap['lng'] as num?)?.toDouble() ?? 0.0;

    DateTime? parsedTimestamp;
    if (data['timestamp'] is Timestamp) {
      parsedTimestamp = (data['timestamp'] as Timestamp).toDate();
    } else if (data['timestamp'] is int) {
      parsedTimestamp = DateTime.fromMillisecondsSinceEpoch(
        data['timestamp'] as int,
      );
    }

    return DispatchAlert(
      id: id,
      patientId: id, // use document ID as patientId if missing
      patientName: data['patientName'] as String?,
      latitude: lat,
      longitude: lng,
      aiSeverityScore: data['aiSeverityScore'] as int? ?? 5,
      aiSummary: data['condition'] as String? ?? 'Unknown Condition',
      status: DispatchStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => DispatchStatus.idle,
      ),
      age: data['age'] as int?,
      gender: data['gender'] as String?,
      timestamp: parsedTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientName': patientName,
      'patientLocation': {'lat': latitude, 'lng': longitude},
      'aiSeverityScore': aiSeverityScore,
      'condition': aiSummary,
      'status': status.name,
      'age': age,
      'gender': gender,
      if (timestamp != null) 'timestamp': Timestamp.fromDate(timestamp!),
    };
  }
}
