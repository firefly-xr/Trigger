import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import '../models/dispatch_alert.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // Hardcoded test driver location (Kochi center)
  final LatLng driverLocation = const LatLng(9.9667, 76.2667);
  final Distance _distanceCalc = const Distance();

  Stream<DispatchAlert?> listenToDriverDispatches(String driverId) {
    var controller = StreamController<DispatchAlert?>();
    
    StreamSubscription? sub1;

    void refreshData(_) async {
      try {
        final active = await _db.collection('active_emergencies').get();
        
        for (var doc in active.docs) {
          final data = doc.data() as Map<String, dynamic>?;
          if (data == null) continue;

          final alert = DispatchAlert.fromMap(doc.id, data);
          final alertLoc = LatLng(alert.latitude, alert.longitude);
          final miles = _distanceCalc.as(LengthUnit.Mile, driverLocation, alertLoc);
          
          if (miles <= 10.0) {
            final assigned = data['assignedDriverId'];
            // If it's unassigned or assigned to me, show it!
            if (assigned == null || assigned == driverId) {
              controller.add(alert);
              return; // Emit the first valid one we find
            }
          }
        }
        controller.add(null); // No valid alerts found
      } catch (e) {
        // Ignored in hackathon
      }
    }

    sub1 = _db.collection('active_emergencies').snapshots().listen(refreshData);

    controller.onCancel = () {
      sub1?.cancel();
    };

    return controller.stream;
  }

  Future<void> updateDispatchStatus(String docId, DispatchStatus status) async {
    final payload = {
      'status': status.name,
      'assignedDriverId': 'driver_1', // Take ownership
    };
    
    try { 
      await _db.collection('active_emergencies').doc(docId).update(payload); 
    } catch (_) {}
  }
}
