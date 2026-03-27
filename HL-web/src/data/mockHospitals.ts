export type Hospital = {
  id: string;
  name: string;
  specialties: string[];
  distance: number; // in miles/km
  bedAvailability: "High" | "Medium" | "Critical";
};

export const mockHospitals: Hospital[] = [
  {
    id: "H001",
    name: "City Central Trauma Center",
    specialties: ["Level 1 Trauma", "Neurology", "Cardiology"],
    distance: 3.2,
    bedAvailability: "Medium",
  },
  {
    id: "H002",
    name: "St. Jude Medical Center",
    specialties: ["Pediatrics", "General Surgery"],
    distance: 5.8,
    bedAvailability: "High",
  },
  {
    id: "H003",
    name: "Northview Regional Hospital",
    specialties: ["Burn Unit", "Orthopedics"],
    distance: 12.4,
    bedAvailability: "Critical",
  },
  {
    id: "H004",
    name: "Mercy Cardiac Institute",
    specialties: ["Cardiology", "Cardiothoracic Surgery"],
    distance: 7.1,
    bedAvailability: "High",
  }
];
