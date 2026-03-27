"use client";

import { useState, useEffect } from "react";
import { collection, onSnapshot, query, getDoc, doc } from "firebase/firestore";
import { db } from "@/lib/firebase";

export interface DbAmbulance {
  id: string;
  driverName?: string;
  isAvailable?: boolean;
  vehicleType?: string;
  currentLocation?: any; 
  assignedPatient?: any;
}

const BASE_MOCK_FLEET: DbAmbulance[] = [
  { id: "mock-1", driverName: "Unit 04 [AUTO]", isAvailable: true, vehicleType: "ADVANCED ALS" },
  { id: "mock-2", driverName: "Unit 07 [AI-ASSIST]", isAvailable: false, vehicleType: "TRAUMA SURGERY" },
  { id: "mock-3", driverName: "Unit 09 [AUTO]", isAvailable: true, vehicleType: "STANDARD BLS" }
];

export interface DbHospital {
  id: string;
  name?: string;
  contactNumber?: string;
  mockAvailableBeds?: number;
  location?: any;
  facilities?: {
    hasBurnUnit?: boolean;
    hasCardiacCathLab?: boolean;
    hasTraumaCenter?: boolean;
  };
}

export function useFirebaseData() {
  const [ambulances, setAmbulances] = useState<DbAmbulance[]>([]);
  const [hospitals, setHospitals] = useState<DbHospital[]>([]);
  const [dbPatients, setDbPatients] = useState<any[]>([]);

  useEffect(() => {
    // Listen to Ambulances
    const ambRef = collection(db, "ambulances");
    const unsubAmbulances = onSnapshot(query(ambRef), (snapshot) => {
      const liveData: DbAmbulance[] = [];
      snapshot.forEach(doc => {
        liveData.push({ id: doc.id, ...doc.data() });
      });
      
      // Merge live database units with base mock fleet so the radar is never visually empty
      // Real-time updates from Flutter will instantly append to this array
      setAmbulances([...BASE_MOCK_FLEET, ...liveData]);
    }, (error) => {
      console.error("Firestore Ambulance Feed Error:", error);
    });

    // Listen to Hospitals
    const hospRef = collection(db, "hospitals");
    const unsubHospitals = onSnapshot(query(hospRef), (snapshot) => {
      const data: DbHospital[] = [];
      snapshot.forEach(doc => {
        data.push({ id: doc.id, ...doc.data() });
      });
      setHospitals(data);
    }, (error) => {
      console.error("Firestore Hospital Feed Error:", error);
    });

    // Listen to Mobile App SOS Triggers
    const patientsRef = collection(db, "emergencies"); // Change this to your friend's collection name!
    const unsubPatients = onSnapshot(query(patientsRef), async (snapshot) => {
      const promises = snapshot.docs.map(async (docSnapshot) => {
        const data = docSnapshot.data();
        let userDetails = {};
        
        // Dynamically fetch registered medical history if mobile app supplied a UID!
        if (data.uid || data.userId) {
          try {
            const uid = data.uid || data.userId;
            const userDoc = await getDoc(doc(db, "users", uid));
            if (userDoc.exists()) {
              userDetails = userDoc.data();
            }
          } catch (e) {
            console.error("Failed to fetch user details for SOS UID", e);
          }
        }
        
        return { id: docSnapshot.id, ...data, ...userDetails };
      });
      
      const pData = await Promise.all(promises);
      setDbPatients(pData);
    }, (error) => {
      console.error("Firestore SOS Feed Error:", error);
    });

    return () => {
      unsubAmbulances();
      unsubHospitals();
      unsubPatients();
    };
  }, []);

  return { ambulances, hospitals, dbPatients };
}
