import { Patient } from "@/data/mockPatients";
import { RealHospital } from "@/lib/hospitalApi";
import { DbHospital } from "@/hooks/useFirebaseData";

/**
 * Predictive Emergency Orchestration Layer (PEOL) Engine
 * Calculates multi-dimensional survival probabilities and handles autonomous resource locking.
 */

// Math util: Haversine distance
function getDist(lat1: number, lon1: number, lat2: number, lon2: number) {
  const R = 6371; 
  const dLat = (lat2 - lat1) * (Math.PI / 180);
  const dLon = (lon2 - lon1) * (Math.PI / 180);
  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(lat1 * (Math.PI / 180)) * Math.cos(lat2 * (Math.PI / 180)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c; 
}

export class PEOLEngine {

  /**
   * Evaluates the active patient roster. Recalculates survival percentages
   * based on distance to their targeted destination.
   */
  static evaluatePredictiveOutcomes(
    patients: Patient[], 
    dbHospitals: DbHospital[], 
    osmHospitals: RealHospital[], 
    baseLat: number, 
    baseLng: number
  ): Patient[] {
    return patients.map(p => {
      if (p.status === "COMPLETED") return p;

      // Determine where the patient is heading (destination hospital or base)
      let targetLat = baseLat;
      let targetLng = baseLng;
      let targetHospInfo: any = null;

      if (p.status === "REROUTED" || p.destinationHospitalId !== "CEN-01") {
        const dbH = dbHospitals.find(h => h.id === p.destinationHospitalId);
        if (dbH && dbH.location) {
          targetLat = dbH.location.latitude || targetLat;
          targetLng = dbH.location.longitude || targetLng;
          targetHospInfo = dbH;
        } else {
          const osmH = osmHospitals.find(h => h.id === p.destinationHospitalId);
          if (osmH) {
            targetLat = osmH.lat;
            targetLng = osmH.lng;
            targetHospInfo = osmH;
          }
        }
      }

      const dist = getDist(p.patientLocation.lat, p.patientLocation.lng, targetLat, targetLng);
      const estEtaMins = (dist / 60) * 60; // 60km/h average

      // Survival Probability Algorithm (Simulation)
      // Base survival depends on triage tier (Tier 1 is most critical)
      let baseSurvival = 100;
      switch(p.aiSeverityScore) {
        case 1: baseSurvival = 50; break;
        case 2: baseSurvival = 75; break;
        case 3: baseSurvival = 90; break;
        case 4: baseSurvival = 97; break;
        case 5: baseSurvival = 99; break;
      }

      // Time penalty: Every minute costs % survival (harsher for Tier 1)
      const timePenaltyMulti = p.aiSeverityScore === 1 ? 0.8 : (p.aiSeverityScore === 2 ? 0.3 : 0.05);
      const delayImpact = estEtaMins * timePenaltyMulti;

      // Capability Bonus: If the hospital has trauma/burn units, survival jumps back up.
      let capabilityBonus = 0;
      if (targetHospInfo?.facilities?.hasTraumaCenter && p.aiSeverityScore <= 2) capabilityBonus += 15;
      if (targetHospInfo?.facilities?.hasBurnUnit && p.condition.toLowerCase().includes("burn")) capabilityBonus += 20;

      const finalSurvivalRaw = baseSurvival - delayImpact + capabilityBonus;
      const finalSurvival = Math.max(5, Math.min(99.9, finalSurvivalRaw));

      // Decision Confidence
      // DB verified hospitals trigger higher confidence than OSM hospitals
      const confidence = targetHospInfo && targetHospInfo.mockAvailableBeds !== undefined ? 96.5 : 78.4;

      return {
        ...p,
        eta: Math.round(estEtaMins),
        peol: {
          survivalProb: parseFloat(finalSurvival.toFixed(1)),
          delayImpact: parseFloat((-delayImpact).toFixed(1)),
          decisionConfidence: confidence,
          systemActions: p.peol?.systemActions || []
        }
      };
    });
  }

  /**
   * Scans for ICU capacity bottlenecks. If multiple critical patients are hitting a hospital
   * with no capacity, it forcibly reroutes the one with the best secondary ETA.
   */
  static runAutonomousConflictResolution(
    patients: Patient[], 
    dbHospitals: DbHospital[]
  ): { nextPatients: Patient[], actionsTaken: number } {
    
    let actionsTaken = 0;
    const nextPatients = [...patients];

    // Build capacity ledger
    const hospitalLoad = new Map<string, number>();
    
    // Count active inbound
    nextPatients.forEach(p => {
      if (p.status !== "COMPLETED") {
        const dest = p.destinationHospitalId;
        hospitalLoad.set(dest, (hospitalLoad.get(dest) || 0) + 1);
      }
    });

    // Resolve bottlenecks based on capacities
    dbHospitals.forEach(hosp => {
      const inboundCount = hospitalLoad.get(hosp.id) || 0;
      const maxBeds = hosp.mockAvailableBeds || 0;
      
      if (inboundCount > maxBeds && maxBeds > 0) {
        // Bottleneck detected! Find the lowest severity patient inbound here and reroute them.
        const inboundPatients = nextPatients.filter(p => p.destinationHospitalId === hosp.id && p.status !== "COMPLETED");
        inboundPatients.sort((a, b) => b.aiSeverityScore - a.aiSeverityScore); // Sort highest number (lowest severity) first
        
        const patientToEvict = inboundPatients[0];
        if (patientToEvict) {
          // Find alternative DB hospital with beds
          const alternativeHosp = dbHospitals.find(h => h.id !== hosp.id && (h.mockAvailableBeds || 0) > (hospitalLoad.get(h.id) || 0));
          if (alternativeHosp) {
            
            // Execute Autonomous Reroute Check
            const targetPatientIdx = nextPatients.findIndex(p => p.id === patientToEvict.id);
            if (targetPatientIdx > -1) {
              const target = nextPatients[targetPatientIdx];
              
              const sysAction = {
                id: `peol-${Date.now()}`,
                message: `[AUTONOMY LAYER] Rerouted from ${hosp.name} due to Critical Load Saturation. Preserving ${alternativeHosp.name} ICU buffer.`,
                timestamp: new Date().toISOString()
              };

              const newEvent = {
                id: `auto-reroute-${Date.now()}`,
                timestamp: new Date().toISOString(),
                description: `SYSTEM OVERRIDE: Capacity Saturation. Auto-Rerouted to ${alternativeHosp.name}`,
                type: "SYSTEM_DECISION" as any
              };

              // Safely ensure peol exists
              const currentPeol = target.peol || { survivalProb: 0, delayImpact: 0, decisionConfidence: 0, systemActions: [] };

              nextPatients[targetPatientIdx] = {
                ...target,
                status: "REROUTED",
                destinationHospitalId: alternativeHosp.id,
                events: [...target.events, newEvent],
                patientLocation: { lat: alternativeHosp.location?.latitude || 0, lng: alternativeHosp.location?.longitude || 0 },
                peol: {
                  ...currentPeol,
                  decisionConfidence: 99.9,
                  systemActions: [sysAction, ...currentPeol.systemActions]
                }
              };
              actionsTaken++;
              
              // Increment alternative load so we don't spam it
              hospitalLoad.set(alternativeHosp.id, (hospitalLoad.get(alternativeHosp.id) || 0) + 1);
            }
          }
        }
      }
    });

    return { nextPatients, actionsTaken };
  }
}
