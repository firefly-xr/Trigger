import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models.dart';

class PatientRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<PatientProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return PatientProfile.fromJson(doc.data()!);
      }
    } catch (e) {
      print('Error getting user profile: $e');
    }
    return null;
  }

  Future<void> triggerSOS(EmergencyEvent event) async {
    try {
      final collection = _firestore.collection('active_emergencies');
      final docRef = event.id.isEmpty
          ? collection.doc()
          : collection.doc(event.id);

      final eventWithIds = event.copyWith(
        id: docRef.id,
        patientId: FirebaseAuth.instance.currentUser?.uid ?? event.patientId,
      );

      await docRef.set(eventWithIds.toJson());
      print('Created emergency session: ${docRef.id}');
    } catch (e) {
      print('Error triggering SOS: $e');
    }
  }

  // --- HACKATHON WEB DASHBOARD INTEGRATION ---
  Future<void> triggerEmergencySOS(double currentLat, double currentLng, String conditionStr, int aiSeverity) async {
    try {
      // Fetch user's real name from their profile if possible
      String name = "Live Mobile User";
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc = await _firestore.collection('users').doc(uid).get();
        if (doc.exists && doc.data() != null) {
          final profileStr = doc.data()!['fullName'] as String?;
          if (profileStr != null && profileStr.isNotEmpty) name = profileStr;
        }
      }

      // This writes directly to the "emergencies" collection that the Web Dashboard is explicitly listening to
      await _firestore.collection('emergencies').add({
        'patientLocation': {
          'lat': currentLat,
          'lng': currentLng,
        },
        'patientName': name, 
        'condition': conditionStr, // e.g. "Chest Pain" or "Car Accident"
        'age': 30, // Default fallback
        'gender': "U", // Default fallback
        'aiSeverityScore': aiSeverity, // 1 (Critical), 2 (Urgent), 3 (Standard)
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      print('SOS Successfully pushed to Web Dispatch Dashboard PEOL Engine!');
    } catch (e) {
      print('Error triggering web dashboard SOS: $e');
    }
  }

  Future<void> triggerEmergencySOSForAnother(
      double currentLat, 
      double currentLng, 
      String conditionStr, 
      int aiSeverity, 
      String name, 
      int age) async {
    try {
      await _firestore.collection('emergencies').add({
        'patientLocation': {
          'lat': currentLat,
          'lng': currentLng,
        },
        'patientName': name, 
        'condition': conditionStr,
        'age': age,
        'gender': "U", // Default fallback or could be added to form
        'aiSeverityScore': aiSeverity,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('SOS for Another Successfully pushed to Web Dispatch Dashboard PEOL Engine!');
    } catch (e) {
      print('Error triggering web dashboard SOS for another: $e');
    }
  }

  Stream<EmergencyEvent> listenToActiveEmergency(String emergencyId) {
    return _firestore
        .collection('active_emergencies')
        .doc(emergencyId)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            return EmergencyEvent.fromJson(snapshot.data()!);
          }
          throw Exception('Emergency event not found in stream');
        });
  }

  /// Creates a real user profile in Firestore only when newly registered.
  /// Fields not provided default to empty strings so no dummy data is stored.
  Future<void> createUserProfile(String uid, {String fullName = '', int? age}) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) return; // Don't overwrite if it already exists

      final profile = PatientProfile(
        uid: uid,
        fullName: fullName,
        age: age ?? 30, // temporary fallback
        bloodGroup: '',
        emergencyContacts: [],
        medicalContext: '',
      );

      await _firestore.collection('users').doc(uid).set(profile.toJson());
      print('User profile created for: $uid');
    } catch (e) {
      print('Error creating user profile: $e');
    }
  }

  Future<void> updateUserProfileNameAndAge(String uid, String name, int age) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'fullName': name,
        'age': age,
      }, SetOptions(merge: true));
      // Optionally update local hive if we want but mostly we push to firestore
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Future<void> updateMedicalHistoryFields({
    required String bloodType,
    required String allergies,
    required String medicalConditions,
    required String medications,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final medicalContext = [
        if (allergies.isNotEmpty) 'Allergies: $allergies',
        if (medicalConditions.isNotEmpty) 'Conditions: $medicalConditions',
        if (medications.isNotEmpty) 'Medications: $medications',
      ].join(' | ');

      await _firestore.collection('users').doc(uid).set({
        'bloodGroup': bloodType,
        'medicalContext': medicalContext,
        'medicalHistoryDetails': {
          'bloodType': bloodType,
          'allergies': allergies,
          'medicalConditions': medicalConditions,
          'medications': medications,
        }
      }, SetOptions(merge: true));
      print('Medical history updated in DB for: $uid');
    } catch (e) {
      print('Error updating medical history: $e');
    }
  }

  Future<void> updateEmergencyContacts(List<Map<String, String>> contacts) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      
      await _firestore.collection('users').doc(uid).set({
        'emergencyContacts': contacts,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating contacts: $e');
    }
  }
}
