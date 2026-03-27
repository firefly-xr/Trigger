"use client";

import { useMemo } from "react";
import { motion } from "framer-motion";
import { MapPin, Navigation } from "lucide-react";
import { Patient } from "@/data/mockPatients";

interface MapPlaceholderProps {
  patients: Patient[];
}

export function MapPlaceholder({ patients }: MapPlaceholderProps) {
  // We use a mock grid system for the placeholder.
  // The map simulates a 10x10 city grid.
  
  return (
    <div className="relative w-full h-[400px] bg-card rounded-lg overflow-hidden border border-border shadow-inner flex flex-col transition-colors duration-300">
      {/* Decorative Map Header */}
      <div className="absolute top-0 left-0 w-full bg-slate-100/80 dark:bg-slate-800/80 backdrop-blur-sm p-2 z-10 flex justify-between items-center px-4 border-b border-border">
        <div className="flex items-center gap-2 text-foreground">
          <Navigation className="h-4 w-4 text-blue-500 dark:text-blue-400" />
          <span className="text-sm font-semibold tracking-widest text-blue-700 dark:text-blue-200 uppercase">Live Ambulance Tracking</span>
        </div>
        <div className="text-xs text-muted-foreground font-mono tracking-wider flex items-center gap-2">
          <span className="h-2 w-2 rounded-full bg-green-500 animate-pulse"></span>
          GPS ACTIVE
        </div>
      </div>

      {/* Map Background Grid */}
      <div 
        className="absolute inset-0 z-0 opacity-20"
        style={{
          backgroundImage: `
            linear-gradient(to right, #475569 1px, transparent 1px),
            linear-gradient(to bottom, #475569 1px, transparent 1px)
          `,
          backgroundSize: '40px 40px'
        }}
      />
      
      {/* Radar Sweep Effect */}
      <motion.div 
        className="absolute top-1/2 left-1/2 w-[800px] h-[800px] -mt-[400px] -ml-[400px] rounded-full z-0 opacity-10 pointer-events-none"
        style={{
          background: 'conic-gradient(from 0deg, transparent 70%, rgba(59, 130, 246, 0.8) 100%)',
        }}
        animate={{ rotate: 360 }}
        transition={{ repeat: Infinity, duration: 4, ease: "linear" }}
      />
      
      <div className="absolute top-1/2 left-1/2 w-4 h-4 bg-blue-500 rounded-full -mt-2 -ml-2 z-0 animate-ping opacity-50" />

      {/* Patient Markers */}
      <div className="absolute inset-0 z-10 p-8 pt-16 mt-4">
        <div className="relative w-full h-full">
          {patients.map((patient, index) => {
            // Very hacky pseudo-random position based on index for the placeholder
            const top = 10 + (index * 15) % 80;
            const left = 10 + (index * 25) % 80;
            
            const isCritical = patient.aiSeverityScore === 1;

            return (
              <motion.div
                key={`map-pin-${patient.id}`}
                className="absolute transform -translate-x-1/2 -translate-y-1/2 flex flex-col items-center"
                style={{ top: `${top}%`, left: `${left}%` }}
                initial={{ scale: 0 }}
                animate={{ scale: 1 }}
                transition={{ delay: index * 0.1, type: "spring" }}
              >
                <div className={`
                  p-1.5 rounded-full border shadow-lg relative
                  ${isCritical ? 'bg-red-500 border-red-300' : 'bg-blue-500 border-blue-300'}
                `}>
                  {isCritical && (
                    <span className="absolute inset-0 rounded-full bg-red-500 animate-ping opacity-75"></span>
                  )}
                  <MapPin className="h-5 w-5 text-white relative z-10" />
                </div>
                <div className="mt-1 bg-background/90 backdrop-blur-3xl px-2 py-0.5 rounded text-[10px] font-bold text-foreground whitespace-nowrap border border-border shadow-md">
                  {patient.id} - {patient.eta}m
                </div>
              </motion.div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
