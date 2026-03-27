export type PatientEvent = {
  id: string;
  timestamp: string; // ISO string or similar
  description: string;
  type: 'REQUESTED' | 'DISPATCHED' | 'EN_ROUTE' | 'ARRIVED' | 'IN_TRANSIT' | 'AT_HOSPITAL' | 'SYSTEM_DECISION';
};

export type Patient = {
  id: string;
  patientName: string;
  age: number;
  gender: string;
  condition: string;
  destinationHospitalId: string;
  aiSeverityScore: 1 | 2 | 3 | 4 | 5; // 1 = Critical, 2 = High, 3 = Moderate, 4 = Low, 5 = Very Low
  aiSummary: string;
  eta: number; // in minutes
  ambulanceLocation: {
    lat: number;
    lng: number;
  };
  patientLocation: {
    lat: number;
    lng: number;
  };
  events: PatientEvent[];
  status?: "REQUESTED" | "DISPATCHED" | "REROUTED" | "COMPLETED";
  rawSosMessage?: string;
  vitals?: {
    bpm: number;
    spO2: number;
    temp: number;
  };
  medicalHistory?: {
    bloodGroup: string;
    medicalContext: string;
    emergencyContact: {
      name: string;
      number: string;
    };
  };
  peol?: {
    survivalProb: number;
    delayImpact: number;
    decisionConfidence: number;
    systemActions: { id: string, message: string, timestamp: string }[];
  };
};

// NYC Default
export const HOSPITAL_LOCATION = { lat: 40.730610, lng: -73.935242 }; 

export const mockPatients: Patient[] = [
  // Keeping fallback data. Note: The app will now dynamically overwrite this if location is granted.
  {
    id: "P001",
    patientName: "John Doe",
    age: 45,
    gender: "M",
    condition: "Cardiac arrest",
    destinationHospitalId: "CEN-01",
    aiSeverityScore: 1,
    aiSummary: "Cardiac arrest. Unresponsive. Administered CPR, currently using AED.",
    eta: 4,
    ambulanceLocation: { lat: 40.7128, lng: -74.0060 },
    patientLocation: { lat: 40.7140, lng: -74.0100 },
    medicalHistory: {
      bloodGroup: "O+",
      medicalContext: "Previous STEMI in 2021. Prescribed Nitroglycerin.",
      emergencyContact: {
        name: "Jane Doe (Wife)",
        number: "+1 (555) 723-9912"
      }
    },
    events: [
      { id: "e1", timestamp: new Date(Date.now() - 1000 * 60 * 15).toISOString(), description: "Emergency app triggered", type: "REQUESTED" },
      { id: "e2", timestamp: new Date(Date.now() - 1000 * 60 * 12).toISOString(), description: "Ambulance Unit 4 dispatched", type: "DISPATCHED" },
    ]
  }
];

/**
 * Mathematically synthesizes realistic incoming emergencies scattered around 
 * the presenter's real GPS location (roughly 2km to 8km away randomly).
 */
export function generateLocalizedPatients(centerLat: number, centerLng: number): Patient[] {
  const generateOffset = (distKm: number, angleDegrees: number) => {
    // 1 degree lat is roughly 111km
    const radius = distKm / 111;
    const angle = angleDegrees * (Math.PI / 180);
    return {
      latOffset: Math.cos(angle) * radius,
      lngOffset: Math.sin(angle) * radius
    };
  };

  // Patient 1: Active outbound emergency (approx 3km Northeast)
  const p1Offset = generateOffset(3, 45); 
  const p1Lat = centerLat + p1Offset.latOffset;
  const p1Lng = centerLng + p1Offset.lngOffset;
  // Ambulance is halfway there
  const a1Lat = centerLat + (p1Offset.latOffset * 0.5);
  const a1Lng = centerLng + (p1Offset.lngOffset * 0.5);

  // Patient 2: Needs Inter-hospital Transfer (Currently at exact center hospital)
  const p2Lat = centerLat;
  const p2Lng = centerLng;
  const a2Lat = centerLat;
  const a2Lng = centerLng;

  return [
    {
      id: "P001",
      patientName: "Jane Smith",
      age: 28,
      gender: "F",
      condition: "Severe trauma from MVA.",
      destinationHospitalId: "CEN-01",
      aiSeverityScore: 2,
      aiSummary: "Severe trauma from MVA. Significant bleeding. Unit en route.",
      eta: 6,
      ambulanceLocation: { lat: a1Lat, lng: a1Lng },
      patientLocation: { lat: p1Lat, lng: p1Lng },
      events: [
        { id: "e1-1", timestamp: new Date(Date.now() - 1000 * 60 * 15).toISOString(), description: "Emergency app triggered natively", type: "REQUESTED" },
        { id: "e1-2", timestamp: new Date(Date.now() - 1000 * 60 * 5).toISOString(), description: "Ambulance unit officially dispatched", type: "DISPATCHED" as any }
      ],
      rawSosMessage: "HELP major car crash on highway!! my friend is bleeding really bad from her leg she is unconscious please hurry",
      vitals: { bpm: 142, spO2: 88, temp: 97.4 },
      medicalHistory: {
        bloodGroup: "O-Negative",
        medicalContext: "No known allergies. Previous appendectomy (2020).",
        emergencyContact: { name: "John Smith (Husband)", number: "+1 (555) 019-2831" }
      },
      peol: {
        survivalProb: 84.5,
        delayImpact: -2.1,
        decisionConfidence: 96.0,
        systemActions: [
          { id: "s1", message: "Trauma Team Delta Placed on Standby", timestamp: new Date().toISOString() },
          { id: "s2", message: "O-Negative Blood Reserves Secured", timestamp: new Date().toISOString() }
        ]
      }
    },
    {
      id: "P002",
      patientName: "Robert Johnson",
      age: 54,
      gender: "M",
      condition: "Subdural hematoma.",
      destinationHospitalId: "CEN-01",
      aiSeverityScore: 3,
      aiSummary: "Stable but requires specialized neurosurgery intervention. Awaiting reroute.",
      eta: 0,
      ambulanceLocation: { lat: a2Lat, lng: a2Lng },
      patientLocation: { lat: p2Lat, lng: p2Lng },
      events: [
        { id: "e2-1", timestamp: new Date(Date.now() - 1000 * 60 * 120).toISOString(), description: "Patient arrived at Central Hospital", type: "AT_HOSPITAL" as any },
        { id: "e2-2", timestamp: new Date(Date.now() - 1000 * 60 * 10).toISOString(), description: "Transfer authorization requested", type: "REQUESTED" }
      ],
      rawSosMessage: "(Transferred by EMS) Suspected cerebral hemorrhage. Stabilization protocol completed.",
      vitals: { bpm: 72, spO2: 98, temp: 98.6 },
      medicalHistory: {
        bloodGroup: "A-Positive",
        medicalContext: "Type 2 Diabetes. Hypertension. Prescribed Lisinopril 10mg.",
        emergencyContact: { name: "Sarah Johnson (Daughter)", number: "+1 (555) 912-3341" }
      },
      peol: {
        survivalProb: 72.3,
        delayImpact: -5.4,
        decisionConfidence: 89.5,
        systemActions: [
          { id: "s1", message: "Neurology Specialist Paged", timestamp: new Date().toISOString() },
          { id: "s2", message: "ICU Bed #4 Lock Requested", timestamp: new Date().toISOString() }
        ]
      }
    }
  ];
}
