"use client";

import { useEffect, useState, useMemo } from "react";
import { MapContainer, TileLayer, Marker, Popup, Polyline, useMap } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import { Patient } from "@/data/mockPatients";
import { RealHospital } from "@/lib/hospitalApi";
import { DbHospital } from "@/hooks/useFirebaseData";
import { useTheme } from "next-themes";
import { LiveETA } from "@/components/LiveETA";

// Haversine formula to calculate distance
function getDistanceFromLatLonInKm(lat1: number, lon1: number, lat2: number, lon2: number) {
  const R = 6371; // km
  const dLat = deg2rad(lat2 - lat1);
  const dLon = deg2rad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
    Math.sin(dLon / 2) * Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const d = R * c; 
  return d;
}

function deg2rad(deg: number) {
  return deg * (Math.PI / 180);
}

const hospitalIconHtml = `
  <div style="background-color: #ef4444; width: 20px; height: 20px; border-radius: 50%; border: 3px solid white; box-shadow: 0 0 10px rgba(0,0,0,0.5);"></div>
`;
const hospitalIcon = typeof window !== 'undefined' ? new L.DivIcon({
  className: 'custom-icon',
  html: hospitalIconHtml,
  iconSize: [20, 20],
  iconAnchor: [10, 10]
}) : null;

const patientIconHtml = `
  <div style="background-color: #eab308; width: 16px; height: 16px; border-radius: 50%; border: 2px solid white; box-shadow: 0 0 10px rgba(0,0,0,0.5);"></div>
`;
const patientIcon = typeof window !== 'undefined' ? new L.DivIcon({
  className: 'custom-icon',
  html: patientIconHtml,
  iconSize: [16, 16],
  iconAnchor: [8, 8]
}) : null;

// Custom Ambulance SVG wrapper for Leaflet divIcon
const ambulanceIconHtml = `
  <div style="
    background-color: #ffffff;
    border: 2px solid #3b82f6;
    border-radius: 5px;
    padding: 2px;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    display: flex;
    align-items: center;
    justify-content: center;
  ">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#3b82f6" width="20px" height="20px">
      <path d="M20.92,11.23a2,2,0,0,0-1.42-.58H17V7a1,1,0,0,0-1-1H4A1,1,0,0,0,3,7V17a1,1,0,0,0,1,1H5.43a2.5,2.5,0,0,0,4.72.63H13.63a2.49,2.49,0,0,0,4.68-.31h1.36a1,1,0,0,0,1-1v-4A2,2,0,0,0,20.92,11.23ZM5,14a.5.5,0,0,1,0-1,.5.5,0,0,1,0,1Zm2.5.5A1.5,1.5,0,1,1,9,13,1.5,1.5,0,0,1,7.5,14.5Zm6,0a.5.5,0,0,1,0-1,.5.5,0,0,1,0,1Zm2.5.5A1.5,1.5,0,1,1,17.5,13.5,1.5,1.5,0,0,1,16,15Zm1.5-.5a.5.5,0,0,1,0,1H17v-1h.5ZM4,12V8H15v4H4Zm15,0H17v-1.5h1.5A.5.5,0,0,1,19,11v1Z" />
    </svg>
  </div>
`;
const ambulanceIcon = typeof window !== 'undefined' ? new L.DivIcon({
  className: 'custom-icon bg-transparent border-0',
  html: ambulanceIconHtml,
  iconSize: [32, 32],
  iconAnchor: [16, 16],
  popupAnchor: [0, -16]
}) : null;

const otherHospitalIconHtml = `
  <div style="background-color: #22c55e; width: 14px; height: 14px; border-radius: 2px; border: 2px solid white; box-shadow: 0 0 5px rgba(0,0,0,0.5);"></div>
`;
const otherHospitalIcon = typeof window !== 'undefined' ? new L.DivIcon({
  className: 'custom-icon',
  html: otherHospitalIconHtml,
  iconSize: [14, 14],
  iconAnchor: [7, 7]
}) : null;

// Component to handle auto-centering bounds based on patients & moving animations
function AutoCenterMap({ activePatients, animatedLocations, hospitalLocation, nearbyHospitals }: { activePatients: Patient[], animatedLocations: Record<string, {lat: number, lng: number}>, hospitalLocation: {lat: number, lng: number}, nearbyHospitals: RealHospital[] }) {
  const map = useMap();
  
  useEffect(() => {
    if (!map) return;
    
    const bounds = L.latLngBounds([hospitalLocation.lat, hospitalLocation.lng], [hospitalLocation.lat, hospitalLocation.lng]);
    
    activePatients.forEach(p => {
      bounds.extend([p.patientLocation.lat, p.patientLocation.lng]);
      const ambLoc = animatedLocations[p.id] || p.ambulanceLocation;
      bounds.extend([ambLoc.lat, ambLoc.lng]);
    });

    nearbyHospitals.forEach(h => {
      bounds.extend([h.lat, h.lng]);
    });

    if (activePatients.length > 0 || nearbyHospitals.length > 0) {
      // Pad bounds heavily so UI overlays don't block markers
      map.fitBounds(bounds, { padding: [50, 50], maxZoom: 15, animate: true, duration: 1 });
    } else {
      map.setView([hospitalLocation.lat, hospitalLocation.lng], 12);
    }
  }, [activePatients, animatedLocations, map, hospitalLocation, nearbyHospitals]);

  return null;
}

interface LiveMapProps {
  patients: Patient[];
  selectedPatient?: Patient | null;
  hospitalLocation: { lat: number, lng: number };
  nearbyHospitals: RealHospital[];
  dbHospitals?: DbHospital[];
  onPatientArrived?: (patientId: string) => void;
}

export default function LiveMap({ patients, selectedPatient, hospitalLocation, nearbyHospitals, dbHospitals, onPatientArrived }: LiveMapProps) {
  const [mounted, setMounted] = useState(false);
  const [animatedLocations, setAnimatedLocations] = useState<Record<string, {lat: number, lng: number}>>({});
  const { theme, systemTheme } = useTheme();
  
  const isDarkMode = theme === "dark" || (theme === "system" && systemTheme === "dark");

  useEffect(() => {
    setMounted(true);
  }, []);

  const activePatients = patients.filter(p => p.status !== "COMPLETED");

  // Animation simulator
  useEffect(() => {
    if (!mounted) return;

    const initialLocs: Record<string, {lat: number, lng: number}> = {};
    activePatients.forEach(p => {
      if (!animatedLocations[p.id]) {
        initialLocs[p.id] = { ...p.ambulanceLocation };
      } else {
        initialLocs[p.id] = animatedLocations[p.id];
      }
    });

    if (Object.keys(animatedLocations).length === 0) {
      setAnimatedLocations(initialLocs);
    }

    const interval = setInterval(() => {
      const newlyArrivedIds: string[] = [];

      setAnimatedLocations(prev => {
        const next = { ...prev };
        activePatients.forEach(p => {
          const current = next[p.id] || p.ambulanceLocation;
          
          const distToPatient = getDistanceFromLatLonInKm(current.lat, current.lng, p.patientLocation.lat, p.patientLocation.lng);
          
          let targetLat = p.patientLocation.lat;
          let targetLng = p.patientLocation.lng;
          
          // Phase 2: Picked Up. Now drive to destination hospital.
          if (distToPatient < 0.2) {
            let destHosp = dbHospitals?.find(h => h.id === p.destinationHospitalId);
            if (destHosp && destHosp.location) {
              targetLat = destHosp.location.latitude;
              targetLng = destHosp.location.longitude;
            } else {
              const osmHosp = nearbyHospitals.find(h => h.id === p.destinationHospitalId);
              if (osmHosp) {
                targetLat = osmHosp.lat;
                targetLng = osmHosp.lng;
              } else {
                targetLat = hospitalLocation.lat;
                targetLng = hospitalLocation.lng;
              }
            }
          }
          
          const latDiff = targetLat - current.lat;
          const lngDiff = targetLng - current.lng;
          
          if (Math.abs(latDiff) < 0.0001 && Math.abs(lngDiff) < 0.0001) {
            next[p.id] = { lat: targetLat, lng: targetLng };
            
            // Collect the arrival event if patient was successfully picked up
            if (distToPatient < 0.2 && onPatientArrived) {
              newlyArrivedIds.push(p.id);
            }
            return;
          }

          next[p.id] = {
            lat: current.lat + (latDiff * 0.15), // Triple simulation drive speed
            lng: current.lng + (lngDiff * 0.15)
          };
        });
        return next;
      });

      // Execute side-effects outside of the setState reactivity pure execution scope
      if (newlyArrivedIds.length > 0 && onPatientArrived) {
        newlyArrivedIds.forEach(id => onPatientArrived(id));
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [mounted, activePatients]);

  if (!mounted || !hospitalIcon || !patientIcon || !ambulanceIcon || !otherHospitalIcon) {
    return (
      <div className="w-full h-full bg-slate-100 dark:bg-slate-800 rounded-lg flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  // Grayscale OpenStreetMap tiles
  const TILE_URL = isDarkMode 
    ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
    : 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png';
  const TILE_ATTRIBUTION = '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>';

  return (
    <div className="relative w-full h-[400px] lg:h-full bg-card rounded-lg overflow-hidden border border-border shadow-inner flex flex-col transition-colors duration-300">
      <div className="absolute top-0 left-0 w-full bg-slate-100/90 dark:bg-slate-800/90 backdrop-blur-md p-2 z-10 flex justify-between items-center px-4 border-b border-border shadow-sm">
        <div className="flex items-center gap-2 text-foreground">
          <span className="text-sm font-bold tracking-widest text-blue-700 dark:text-blue-400 uppercase">Unit Dispatch Map</span>
        </div>
        <div className="text-xs text-muted-foreground font-mono tracking-wider flex items-center gap-2 bg-blue-500/10 px-2 py-1 rounded-full border border-blue-500/20">
          <span className="h-2 w-2 rounded-full bg-blue-500 animate-pulse"></span>
          LIVE RADAR
        </div>
      </div>

      <MapContainer 
        center={[hospitalLocation.lat, hospitalLocation.lng]} 
        zoom={12} 
        style={{ height: "100%", width: "100%", zIndex: 0 }}
        zoomControl={false}
      >
        <TileLayer
          attribution={TILE_ATTRIBUTION}
          url={TILE_URL}
        />

        {/* Real Central Hospital Marker */}
        <Marker position={[hospitalLocation.lat, hospitalLocation.lng]} icon={hospitalIcon as L.DivIcon}>
          <Popup className="custom-popup">
            <div className="font-sans">
              <strong className="text-red-600 block mb-1">Central Hospital (Your Location)</strong>
              <div className="text-xs text-muted-foreground leading-tight">Emergency Base<br/>Dispatch Origin point.</div>
            </div>
          </Popup>
        </Marker>

        {/* Real Nearby Hospitals (OpenStreetMap Data) */}
        {nearbyHospitals.map(h => (
          <Marker key={h.id} position={[h.lat, h.lng]} icon={otherHospitalIcon as L.DivIcon}>
            <Popup className="custom-popup">
              <div className="font-sans">
                <strong className="text-green-600 block mb-1 break-words max-w-[150px]">{h.name}</strong>
                <div className="text-xs text-muted-foreground leading-tight">Verified alternative<br/>medical facility.</div>
              </div>
            </Popup>
          </Marker>
        ))}

        {activePatients.map((p, index) => {
          const currentLoc = animatedLocations[p.id] || p.ambulanceLocation;
          const isPickedUp = getDistanceFromLatLonInKm(currentLoc.lat, currentLoc.lng, p.patientLocation.lat, p.patientLocation.lng) < 0.2;

          let targetLat = p.patientLocation.lat;
          let targetLng = p.patientLocation.lng;
          
          if (isPickedUp) {
            let destHosp = dbHospitals?.find(h => h.id === p.destinationHospitalId);
            if (destHosp && destHosp.location) {
              targetLat = destHosp.location.latitude;
              targetLng = destHosp.location.longitude;
            } else {
              const osmHosp = nearbyHospitals.find(h => h.id === p.destinationHospitalId);
              if (osmHosp) {
                targetLat = osmHosp.lat;
                targetLng = osmHosp.lng;
              } else {
                targetLat = hospitalLocation.lat;
                targetLng = hospitalLocation.lng;
              }
            }
          }

          const objectiveDistKm = getDistanceFromLatLonInKm(currentLoc.lat, currentLoc.lng, targetLat, targetLng);

          return (
            <div key={p.id}>
              {/* Patient Marker - ONLY visible if not yet picked up */}
              {!isPickedUp && (
                <Marker position={[p.patientLocation.lat, p.patientLocation.lng]} icon={patientIcon as L.DivIcon}>
                  <Popup className="custom-popup">
                    <div className="font-sans">
                      <strong className="text-amber-600 block mb-1">Patient: {p.patientName}</strong>
                      <div className="text-xs text-muted-foreground leading-tight">Patient Location pinpoint.<br/>Awaiting pickup.</div>
                    </div>
                  </Popup>
                </Marker>
              )}

              {/* Ambulance Marker */}
              <Marker position={[currentLoc.lat, currentLoc.lng]} icon={ambulanceIcon as L.DivIcon}>
                <Popup className="custom-popup p-0">
                  <div className="text-foreground font-sans min-w-[120px] p-2">
                    <div className="flex items-center gap-2 border-b border-border pb-1 mb-2">
                      <div className="w-2 h-2 rounded-full bg-blue-500 animate-pulse shadow-[0_0_5px_rgba(59,130,246,0.8)]"></div>
                      <strong className="text-sm text-blue-600 font-bold tracking-wide leading-none">UNIT {String(index + 1).padStart(2, '0')}</strong>
                    </div>
                    <div className="text-xl font-bold tracking-tighter leading-none mb-1 text-slate-800 dark:text-slate-200">
                      <LiveETA initialETA={p.eta} />
                    </div>
                    <div className="text-xs font-medium tracking-wide flex justify-between w-full">
                      <span className={isPickedUp ? "text-emerald-500" : "text-amber-500"}>
                        {isPickedUp ? "DELIVERING" : "EN ROUTE"}
                      </span>
                      <span className="text-slate-500 font-mono">
                        ~{objectiveDistKm.toFixed(1)} km
                      </span>
                    </div>
                  </div>
                </Popup>
              </Marker>

              {/* Lines Connecting Them */}
              <Polyline 
                positions={[
                  [currentLoc.lat, currentLoc.lng],
                  [targetLat, targetLng]
                ]} 
                color="#3b82f6" 
                weight={4}
                opacity={0.8}
              />
              
              {!isPickedUp && (
                <Polyline 
                  positions={[
                    [p.patientLocation.lat, p.patientLocation.lng],
                    [hospitalLocation.lat, hospitalLocation.lng]
                  ]} 
                  color="#ef4444" 
                  dashArray="5, 10" 
                  weight={2}
                  opacity={0.4}
                />
              )}
            </div>
          );
        })}

        <AutoCenterMap activePatients={activePatients} animatedLocations={animatedLocations} hospitalLocation={hospitalLocation} nearbyHospitals={nearbyHospitals} />
      </MapContainer>
      
      {/* Light CSS injection to overwrite Leaflet popup default styles for our theme */}
      <style dangerouslySetInnerHTML={{__html: `
        .leaflet-popup-content-wrapper {
          border-radius: 8px;
          border: 1px solidhsl(var(--border) / 1);
          background-color:hsl(var(--card) / 1);
          color:hsl(var(--card-foreground) / 1);
          box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }
        .leaflet-popup-tip {
          background-color:hsl(var(--card) / 1);
          border: 1px solidhsl(var(--border) / 1);
        }
        .leaflet-popup-content { margin: 8px 10px; }
      `}} />
    </div>
  );
}
