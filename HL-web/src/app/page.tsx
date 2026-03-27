"use client";

import { useState, useEffect, useMemo, useRef } from "react";
import { generateLocalizedPatients, Patient } from "@/data/mockPatients";
import { fetchNearbyHospitals, RealHospital } from "@/lib/hospitalApi";
import { db } from "@/lib/firebase";
import { doc, setDoc } from "firebase/firestore";
import { TriageBoard } from "@/components/TriageBoard";
import { FleetStatusBoard } from "@/components/FleetStatusBoard";
import { ActiveAlert } from "@/components/ActiveAlert";
import { PatientDetailModal } from "@/components/PatientDetailModal";
import { Activity, ShieldAlert, HeartPulse, LogOut, MapPin, Wifi, WifiOff, Cpu, CheckSquare } from "lucide-react";
import { ModeToggle } from "@/components/mode-toggle";
import { motion, AnimatePresence } from "framer-motion";
import LiveMap from "@/components/LiveMap";
import { PEOLEngine } from "@/lib/peolEngine";
import { useFirebaseData } from "@/hooks/useFirebaseData";
import { useAuth } from "@/lib/auth-context";
import { toast } from "sonner";

export default function Dashboard() {
  const [selectedPatient, setSelectedPatient] = useState<Patient | null>(null);
  const [activeAlerts, setActiveAlerts] = useState<number>(3);
  const { logout } = useAuth();

  const [hospitalLocation, setHospitalLocation] = useState<{lat: number, lng: number} | null>(null);
  const [nearbyHospitals, setNearbyHospitals] = useState<RealHospital[]>([]);
  const [patients, setPatients] = useState<Patient[]>([]);
  // Autonomous & Offline Capabilities
  const [isOfflineMode, setIsOfflineMode] = useState(false);
  const [isAutonomous, setIsAutonomous] = useState(false);
  const [locating, setLocating] = useState(true);

  // Firestore Real-Time Flutter Bridge
  const { ambulances, hospitals: dbHospitals, dbPatients } = useFirebaseData();

  // Dynamically map actual dispatch availability strictly off local Triage counts
  const dynamicAmbulances = useMemo(() => {
    const activeEmergencies = patients.filter(p => p.status !== "COMPLETED");
    
    return ambulances.map((amb, index) => {
      const isAvailable = index >= activeEmergencies.length;
      return {
        ...amb,
        isAvailable,
        assignedPatient: isAvailable ? null : activeEmergencies[index]
      };
    });
  }, [ambulances, patients]);

  // Bi-directional sync back to Firebase Dispatch for Flutter Drivers
  const previousAssignments = useRef<Record<string, string | null>>({});

  useEffect(() => {
    dynamicAmbulances.forEach(async (amb) => {
      const prevPatientId = previousAssignments.current[amb.id] || null;
      const currentPatientId = amb.assignedPatient ? amb.assignedPatient.id : null;

      if (prevPatientId !== currentPatientId) {
        previousAssignments.current[amb.id] = currentPatientId;
        
        try {
          // Point to the 'dispatches' collection where the driver app listens for popups!
          const ambRef = doc(db, "dispatches", amb.id);
          if (currentPatientId && amb.assignedPatient) {
            // Deploying to rescue patient
            await setDoc(ambRef, {
              status: "DEPLOYED",
              ambulanceId: amb.id,
              assignedPatientId: currentPatientId,
              targetLat: amb.assignedPatient.patientLocation.lat,
              targetLng: amb.assignedPatient.patientLocation.lng,
              patientName: amb.assignedPatient.patientName,
              destinationHospitalId: amb.assignedPatient.destinationHospitalId,
              timestamp: new Date().toISOString()
            }, { merge: true });
          } else {
            // Returning to READY, discharging patient
            await setDoc(ambRef, {
              status: "READY",
              assignedPatientId: null,
              targetLat: null,
              targetLng: null,
              patientName: null,
              destinationHospitalId: null
            }, { merge: true });
          }
        } catch (e) {
          console.error("Failed to sync ambulance state to firebase", e);
        }
      }
    });
  }, [dynamicAmbulances]);

  useEffect(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        async (pos) => {
          const lat = pos.coords.latitude;
          const lng = pos.coords.longitude;
          setHospitalLocation({ lat, lng });
          setPatients(generateLocalizedPatients(lat, lng));
          let hosps = await fetchNearbyHospitals(lat, lng, 15000); // 15km search radius
          
          if (hosps.length === 0) {
            // Hackathon Fallback: If Overpass fails or no mapped hospitals exist in area, generate dummy ones relative to the presenter.
            hosps = [
              { id: "fallback_1", name: "Apollo Hospitals - ER Dept", lat: lat + 0.02, lng: lng + 0.02, tags: {} },
              { id: "fallback_2", name: "Fortis Escorts Heart Institute", lat: lat - 0.03, lng: lng + 0.015, tags: {} },
              { id: "fallback_3", name: "City Civil Hospital", lat: lat + 0.015, lng: lng - 0.03, tags: {} }
            ];
          }
          
          setNearbyHospitals(hosps);
          setLocating(false);
        },
        (err) => {
          console.error("GPS Error:", err);
          toast.error("Location permission denied. Falling back to NYC demo mode.");
          const lat = 40.730610, lng = -73.935242;
          setHospitalLocation({ lat, lng });
          setPatients(generateLocalizedPatients(lat, lng));
          // Provide some fake nearby hospitals just in case
          setNearbyHospitals([
            { id: "h1", name: "NYU Langone", lat: 40.7423, lng: -73.9740, tags: {} },
            { id: "h2", name: "Mount Sinai", lat: 40.7891, lng: -73.9532, tags: {} }
          ]);
          setLocating(false);
        },
        { enableHighAccuracy: true, timeout: 10000, maximumAge: 0 }
      );
    } else {
      toast.error("Geolocation is not supported by this browser.");
      const lat = 40.730610, lng = -73.935242;
      setHospitalLocation({ lat, lng });
      setPatients(generateLocalizedPatients(lat, lng));
      setLocating(false);
    }
  }, []);

  const handleLogout = async () => {
    try {
      await logout();
      toast.success("Logged out successfully");
    } catch (error) {
      console.error("Logout error:", error);
      toast.error("Failed to log out");
    }
  };

  const handleReroutePatient = (patientId: string, targetHospital: any) => {
    const newLocation = { lat: targetHospital.lat, lng: targetHospital.lng };
    const newEvent = {
      id: `reroute-${Date.now()}`,
      timestamp: new Date().toISOString(),
      description: `Unit rerouted to ${targetHospital.name}`,
      type: "DISPATCHED" as any
    };

    setPatients(prev => prev.map(p => {
      if (p.id === patientId) {
        return {
          ...p,
          patientLocation: newLocation,
          status: "REROUTED" as any,
          events: [...p.events, newEvent]
        };
      }
      return p;
    }));

    if (selectedPatient?.id === patientId) {
      setSelectedPatient(prev => prev ? {
        ...prev,
        patientLocation: newLocation,
        status: "REROUTED" as any,
        events: [...prev.events, newEvent]
      } : null);
    }
  };

  // Merge Live Flutter Firebase SOS Data
  useEffect(() => {
    if (dbPatients.length > 0) {
      setPatients(prev => {
        // Only absorb SOS triggers we haven't seen locally yet
        const newEmergencies = dbPatients.filter(dbp => !prev.some(p => p.id === dbp.id));
        if (newEmergencies.length === 0) return prev;
        
        const destinationHospitalId = dbHospitals.length > 0 ? dbHospitals[0].id : "CEN-01";
        
        const formatted = newEmergencies.map(dbp => {
           // Resiliently extract Geography from potentially messy Flutter/Firebase schemas (GeoPoint, Map, or Flat)
           const rawLat = dbp.patientLocation?.lat ?? dbp.patientLocation?.latitude ?? dbp.patientLocation?._lat ?? dbp.latitude ?? dbp.lat ?? null;
           const rawLng = dbp.patientLocation?.lng ?? dbp.patientLocation?.longitude ?? dbp.patientLocation?._long ?? dbp.longitude ?? dbp.lng ?? null;
           
           const finalLat = parseFloat(rawLat) || ((hospitalLocation?.lat || 0) + 0.015);
           const finalLng = parseFloat(rawLng) || ((hospitalLocation?.lng || 0) + 0.015);

           // Guaranteed random fallback - always generates realistic medical history regardless of Firebase data
           const BLOOD_GROUPS = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
           const MED_CONTEXTS = [
             "No known allergies. Generally healthy.",
             "Type II Diabetes. On Metformin 500mg.",
             "Penicillin allergy. History of Hypertension.",
             "Asthma. Prescribed Albuterol inhaler.",
             "History of cardiac arrhythmia. On beta-blockers.",
             "Lactose intolerant. No major conditions.",
             "Epilepsy. Prescribed Levetiracetam.",
             "Prior knee surgery (2022). No current medications."
           ];
           const CONTACT_NAMES = ["Spouse", "Parent", "Sibling", "Close Friend", "Emergency Next of Kin"];
           
           // Always generate fresh random values - Firebase data overrides only if explicitly provided
           const bloodGroupRandom = BLOOD_GROUPS[Math.floor(Math.random() * BLOOD_GROUPS.length)];
           const medCtxRandom = MED_CONTEXTS[Math.floor(Math.random() * MED_CONTEXTS.length)];
           const contactNameRandom = CONTACT_NAMES[Math.floor(Math.random() * CONTACT_NAMES.length)];
           
           const bloodGroup = dbp.bloodGroup ?? bloodGroupRandom;
           const medCtx = (typeof dbp.medicalHistory === "string" ? dbp.medicalHistory : null) ?? medCtxRandom;

           return {
             id: dbp.id,
             patientName: dbp.patientName ?? dbp.name ?? "Mobile SOS User",
             age: Number(dbp.age || (Math.floor(Math.random() * 40) + 20)),
             gender: dbp.gender ?? "U",
             condition: [dbp.condition, dbp.description].filter(Boolean).join(" | ") || "Live App Triggered Emergency",
             status: "REQUESTED" as const,
             eta: 15, // Evaluator will overwrite this
             aiSeverityScore: Number(dbp.aiSeverityScore ?? dbp.severity ?? (Math.floor(Math.random() * 3) + 1)) as 1|2|3|4|5,
             patientLocation: { lat: finalLat, lng: finalLng },
             ambulanceLocation: hospitalLocation || { lat: 0, lng: 0 },
             destinationHospitalId,
             medicalHistory: {
               bloodGroup,
               medicalContext: medCtx,
               emergencyContact: {
                 name: contactNameRandom,
                 number: "+1 (555) " + Math.floor(100 + Math.random() * 900) + "-" + Math.floor(1000 + Math.random() * 9000)
               }
             },
             events: [{ id: `evt-${Date.now()}`, timestamp: new Date().toISOString(), description: `Live Flutter Mobile SOS Trigger Received. UID Match: ${dbp.uid != null ? "VERIFIED" : "GUEST"}`, type: "REQUESTED" as const }],
             aiSummary: `[FLUTTER INTEGRATION] Live SOS intercepted. Blood Group: ${bloodGroup} | ${medCtx}`
           };
        });

        const fullRoster = [...prev, ...formatted];
        const evaluated = PEOLEngine.evaluatePredictiveOutcomes(
           fullRoster, 
           dbHospitals, 
           nearbyHospitals, 
           hospitalLocation?.lat || 0, 
           hospitalLocation?.lng || 0
        );

        if (isAutonomous) {
           const result = PEOLEngine.runAutonomousConflictResolution(evaluated, dbHospitals);
           if (result.actionsTaken > 0) {
              toast.info(`PEOL Autonomous Engine intercepted ${result.actionsTaken} live Mobile SOS capacity conflicts!`, {
                 icon: <Cpu className="w-4 h-4 text-emerald-500" />
              });
           }
           return result.nextPatients;
        }

        return evaluated;
      });
    }
  }, [dbPatients, dbHospitals, nearbyHospitals, hospitalLocation, isAutonomous]);

  const handleCompleteTreatment = (patientId: string) => {
    const patientObj = patients.find(p => p.id === patientId);
    if (!patientObj) return;

    setPatients(prev => prev.map(p => 
      p.id === patientId ? { ...p, status: "COMPLETED" as const, eta: 0 } : p
    ));
    toast.success("Emergency Treatment Completed", {
      description: `${patientObj.patientName} safely transitioned to Hospital ICU. Auto-Archived.`,
      icon: <CheckSquare className="w-5 h-5 text-emerald-500" />
    });
  };

  const handleAutoArrived = (patientId: string) => {
    const patientObj = patients.find(p => p.id === patientId && p.status !== "COMPLETED");
    if (patientObj) {
      handleCompleteTreatment(patientId);
    }
  };

  if (locating) {
    return (
      <div className="min-h-screen bg-background flex flex-col items-center justify-center p-4">
        <motion.div 
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          className="flex flex-col items-center gap-6"
        >
          <div className="relative">
            <div className="absolute inset-0 bg-blue-500/20 rounded-full animate-ping"></div>
            <div className="relative bg-background border-2 border-blue-500 rounded-full p-4">
              <MapPin className="w-12 h-12 text-blue-500 animate-pulse" />
            </div>
          </div>
          <div className="text-center space-y-2">
            <h2 className="text-2xl font-bold tracking-tight text-foreground">Acquiring Local GPS Signal</h2>
            <p className="text-muted-foreground">Please allow location access to synthesize regional medical data.</p>
          </div>
        </motion.div>
      </div>
    );
  }

  // If locating failed absolutely but we have fallbacks, we still proceed.
  if (!hospitalLocation) return null; 

  return (
    <div className="min-h-screen bg-background">
      {/* Top Navigation */}
      <header className="sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
        <div className="container px-4 h-16 flex items-center justify-between mx-auto max-w-[1600px]">
          <div 
            className="flex items-center gap-3 cursor-pointer group"
            onDoubleClick={() => {
              toast.error("MASS CASUALTY EVENT DETECTED", { description: "Simulating 4 Critical patients spawning simultaneously in radius." });
              const lat = hospitalLocation?.lat || 0;
              const lng = hospitalLocation?.lng || 0;
              const destinationHospitalId = dbHospitals.length > 0 ? dbHospitals[0].id : "CEN-01";
              
              const mcePatients = [
                { id: `MCE1-${Date.now()}`, patientName: "MCE Victim Alpha", age: 34, gender: "F", condition: "Blunt force trauma.", aiSeverityScore: 1 as const, eta: 12, status: "DISPATCHED" as const, patientLocation: { lat: lat + 0.012, lng: lng - 0.008 }, ambulanceLocation: { lat: lat + 0.012, lng: lng - 0.008 }, destinationHospitalId, events: [], aiSummary: "[AUTOMATED INCIDENT] Multi-vehicle collision.", medicalHistory: { bloodGroup: "A+", medicalContext: "No known allergies. Active runner.", emergencyContact: { name: "Mother", number: "555-0101" } } },
                { id: `MCE2-${Date.now()}`, patientName: "MCE Victim Bravo", age: 45, gender: "M", condition: "Severe burns.", aiSeverityScore: 2 as const, eta: 15, status: "DISPATCHED" as const, patientLocation: { lat: lat + 0.005, lng: lng + 0.015 }, ambulanceLocation: { lat: lat + 0.005, lng: lng + 0.015 }, destinationHospitalId, events: [], aiSummary: "[AUTOMATED INCIDENT] Multi-vehicle collision.", medicalHistory: { bloodGroup: "O-", medicalContext: "History of Asthma. Albuterol inhaler prescribed.", emergencyContact: { name: "Spouse", number: "555-0202" } } },
                { id: `MCE3-${Date.now()}`, patientName: "MCE Victim Charlie", age: 22, gender: "M", condition: "Fractured femur, shock.", aiSeverityScore: 2 as const, eta: 10, status: "DISPATCHED" as const, patientLocation: { lat: lat - 0.018, lng: lng - 0.004 }, ambulanceLocation: { lat: lat - 0.018, lng: lng - 0.004 }, destinationHospitalId, events: [], aiSummary: "[AUTOMATED INCIDENT] Multi-vehicle collision.", medicalHistory: { bloodGroup: "B+", medicalContext: "Penicillin allergy. Previously fractured wrist (2021).", emergencyContact: { name: "Roommate", number: "555-0303" } } },
                { id: `MCE4-${Date.now()}`, patientName: "MCE Victim Delta", age: 59, gender: "F", condition: "Unconscious, head trauma.", aiSeverityScore: 1 as const, eta: 18, status: "DISPATCHED" as const, patientLocation: { lat: lat - 0.007, lng: lng + 0.02 }, ambulanceLocation: { lat: lat - 0.007, lng: lng + 0.02 }, destinationHospitalId, events: [], aiSummary: "[AUTOMATED INCIDENT] Multi-vehicle collision.", medicalHistory: { bloodGroup: "AB-", medicalContext: "Type 2 Diabetes. Hypertension. Lisinopril 10mg.", emergencyContact: { name: "Son", number: "555-0404" } } }
              ];
              
              const evaluatedMCE = PEOLEngine.evaluatePredictiveOutcomes(
                mcePatients, 
                dbHospitals, 
                nearbyHospitals, 
                hospitalLocation?.lat || 0, 
                hospitalLocation?.lng || 0
              );
              
              setPatients(prev => {
                const combined = [...prev, ...evaluatedMCE];
                if (isAutonomous) {
                  const result = PEOLEngine.runAutonomousConflictResolution(combined, dbHospitals);
                  if (result.actionsTaken > 0) {
                     toast.info(`PEOL Engine instantaneously intercepted ${result.actionsTaken} capacity conflicts on spawn!`, {
                        icon: <Cpu className="w-4 h-4 text-emerald-500" />
                     });
                  }
                  return result.nextPatients;
                }
                return combined;
              });
            }}
          >
            <div className="bg-primary/10 p-2 rounded-lg group-hover:bg-red-500/20 transition-colors">
              <HeartPulse className="w-6 h-6 text-primary group-hover:text-red-500 transition-colors" />
            </div>
            <div className="select-none">
              <h1 className="text-xl font-bold tracking-tight text-foreground -mt-1"><span className="text-red-500 font-black tracking-tighter">TRIGGER</span> Dispatch Hub</h1>
              <p className="text-xs text-muted-foreground font-mono">LIVE DISPATCH DASHBOARD</p>
            </div>
          </div>
          
          <div className="flex items-center gap-3">
            <button 
              onClick={() => {
                setIsAutonomous(!isAutonomous);
                toast(isAutonomous ? "Manual Override Engaged" : "Autonomous Mode Activated", {
                  description: isAutonomous 
                    ? "Dispatch logic returned to human operators." 
                    : "PEOL Engine assumes full routing & conflict resolution.",
                  icon: <Cpu className="h-4 w-4" />
                });
              }}
              className={`flex items-center gap-2 px-3 py-1.5 rounded-full text-xs font-bold ring-1 transition-colors shadow-sm ${
                isAutonomous ? "ring-emerald-500/50 bg-emerald-500/10 text-emerald-500 hover:bg-emerald-500/20" : "ring-muted-foreground/30 bg-muted/50 text-muted-foreground hover:bg-muted"
              }`}
            >
              <div className={`h-2 w-2 rounded-full ${isAutonomous ? "bg-emerald-500 animate-pulse" : "bg-muted-foreground"}`}></div>
              <span className="hidden sm:inline">PEOL Auto</span>
            </button>

            <div className="w-px h-6 bg-border mx-1 hidden sm:block"></div>

            <button 
              onClick={() => {
                setIsOfflineMode(!isOfflineMode);
                toast(isOfflineMode ? "Network Synced" : "Offline Mode Triggered", {
                  description: isOfflineMode 
                    ? "Live bidirectional cloud sync restored." 
                    : "No internet connection. Dispatches will cache locally.",
                  icon: isOfflineMode ? <Wifi className="h-4 w-4 text-emerald-500"/> : <WifiOff className="h-4 w-4 text-amber-500"/>
                });
              }}
              className={`hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full text-xs font-bold font-mono tracking-widest border transition-colors ${
                isOfflineMode 
                  ? "bg-amber-500/10 border-amber-500/40 text-amber-600 dark:text-amber-400" 
                  : "bg-emerald-500/10 border-emerald-500/40 text-emerald-600 dark:text-emerald-400"
              }`}
            >
              <div className="relative flex h-2 w-2">
                {!isOfflineMode && <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>}
                <span className={`relative inline-flex rounded-full h-2 w-2 ${isOfflineMode ? "bg-amber-500" : "bg-emerald-500"}`}></span>
              </div>
              {isOfflineMode ? "EDGE-CACHE ENABLED" : "CLOUD SYNCED"}
            </button>
            <div className="h-6 w-px bg-border hidden sm:block"></div>
            <ActiveAlert patients={patients} />
            <div className="h-6 w-px bg-border hidden sm:block"></div>
            <ModeToggle />
            <button 
              onClick={handleLogout}
              className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-destructive hover:bg-destructive/10 rounded-md transition-colors"
            >
              <LogOut className="w-4 h-4" />
              <span className="hidden sm:inline">Dispatch Off</span>
            </button>
          </div>
        </div>
      </header>

      <main className="container mx-auto p-4 lg:p-6 max-w-[1600px]">
        {/* Main Grid Layout */}
        <div className="grid grid-cols-1 lg:grid-cols-8 gap-6 h-[calc(100vh-8rem)]">
          {/* Left Column: Triage List */}
          <section className="lg:col-span-3 flex flex-col gap-4 overflow-hidden h-full border border-border rounded-xl p-4 bg-card/50">
            <div className="flex items-center justify-between pb-2 border-b border-border">
              <h2 className="text-lg font-bold flex items-center gap-2 tracking-tight text-foreground">
                <ShieldAlert className="w-5 h-5 text-red-500" />
                Active Triage 
                <span className="bg-red-500/10 text-red-500 text-xs px-2 py-0.5 rounded-full font-mono ml-2">
                  {patients.length} INCIDENTS
                </span>
              </h2>
            </div>
            
            <div className="overflow-y-auto custom-scrollbar flex-1 pr-2 space-y-4">
              <TriageBoard 
                patients={patients} 
                onSelectPatient={(p) => setSelectedPatient(p)}
              />
              <div className="h-[250px]">
                <FleetStatusBoard ambulances={dynamicAmbulances} />
              </div>
            </div>
          </section>

          {/* Right Column: Map */}
          <section className="lg:col-span-5 flex flex-col gap-4 h-[800px] lg:h-auto border border-border rounded-xl overflow-hidden shadow-xl shadow-black/5 dark:shadow-black/50">
            <div className="flex-1 w-full h-full relative">
              <LiveMap 
                patients={patients} 
                selectedPatient={selectedPatient} 
                hospitalLocation={hospitalLocation}
                nearbyHospitals={nearbyHospitals}
                dbHospitals={dbHospitals}
                onPatientArrived={handleAutoArrived}
              />
            </div>
          </section>
        </div>
      </main>

      <AnimatePresence>
        {selectedPatient && (
          <PatientDetailModal 
            patient={selectedPatient} 
            hospitalLocation={hospitalLocation}
            nearbyHospitals={nearbyHospitals}
            dbHospitals={dbHospitals}
            onReroute={handleReroutePatient}
            onCompleteTreatment={handleCompleteTreatment}
            onClose={() => setSelectedPatient(null)} 
          />
        )}
      </AnimatePresence>
    </div>
  );
}
