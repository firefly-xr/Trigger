"use client";

import { useState, useMemo } from "react";
import { DbAmbulance } from "@/hooks/useFirebaseData";
import { Truck, CheckCircle2, Clock, Activity, MapPin } from "lucide-react";
import { Badge } from "@/components/ui/badge";

export function FleetStatusBoard({ ambulances }: { ambulances: DbAmbulance[] }) {
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const availableCount = useMemo(() => ambulances.filter(a => a.isAvailable).length, [ambulances]);
  const busyCount = ambulances.length - availableCount;

  return (
    <div className="rounded-md border border-border bg-card text-card-foreground shadow-md transition-colors duration-300 flex flex-col h-full overflow-hidden">
      <div className="bg-muted px-4 py-3 border-b-border border-b flex items-center justify-between">
        <h3 className="font-bold flex items-center gap-2 text-sm text-foreground">
          <Truck className="w-4 h-4 text-blue-500" />
          Active Fleet Radar
        </h3>
        <div className="flex gap-2 text-xs font-mono font-bold">
          <span className="text-emerald-500">{availableCount} AVAL</span>
          <span className="text-amber-500">{busyCount} BUSY</span>
        </div>
      </div>

      <div className="overflow-y-auto custom-scrollbar flex-1 p-2 space-y-2">
        {ambulances.length === 0 ? (
          <div className="p-4 text-center text-xs text-muted-foreground italic">
            Monitoring frequency... No vehicles registered in DB.
          </div>
        ) : (
          ambulances.map(amb => {
            const isExpanded = expandedId === amb.id;
            const p = amb.assignedPatient;
            
            return (
              <div 
                key={amb.id} 
                onClick={() => setExpandedId(isExpanded ? null : amb.id)}
                className="bg-muted/30 border border-border rounded p-3 flex flex-col group hover:bg-muted/50 transition cursor-pointer overflow-hidden"
              >
                <div className="flex justify-between items-center w-full">
                  <div className="flex flex-col">
                    <div className="flex items-center gap-2">
                      <span className={`w-2 h-2 rounded-full ${amb.isAvailable ? 'bg-emerald-500 animate-pulse' : 'bg-amber-500'}`}></span>
                      <span className="font-bold text-foreground text-sm tracking-wide">
                        {amb.driverName || "UNIT UNKNOWN"}
                      </span>
                    </div>
                    <span className="text-[10px] text-muted-foreground uppercase tracking-widest ml-4 mt-0.5 font-bold">
                      {amb.vehicleType || "STANDARD BLS"}
                    </span>
                  </div>
                  
                  <div className="text-right">
                    {amb.isAvailable ? (
                      <span className="flex items-center text-emerald-500 text-xs font-bold gap-1 bg-emerald-500/10 px-2 py-0.5 rounded-full">
                        <CheckCircle2 className="w-3 h-3" /> READY
                      </span>
                    ) : (
                      <span className="flex items-center text-amber-500 text-xs font-bold gap-1 bg-amber-500/10 px-2 py-0.5 rounded-full">
                        <Clock className="w-3 h-3" /> DEPLOYED
                      </span>
                    )}
                  </div>
                </div>

                {/* Expanded Details Row */}
                {isExpanded && (
                  <div className="mt-3 pt-3 border-t border-border/50 animate-in slide-in-from-top-2">
                    {!p ? (
                      <div className="text-xs text-muted-foreground italic flex items-center justify-center py-2">
                        Awaiting Dispatch Protocol
                      </div>
                    ) : (
                      <div className="flex flex-col gap-2">
                        <div className="flex justify-between items-start">
                          <div>
                            <p className="text-xs text-muted-foreground uppercase tracking-wider font-bold mb-1">Assigned Casualty</p>
                            <p className="font-semibold text-sm">{p.patientName}</p>
                            <p className="text-xs text-muted-foreground">{p.condition}</p>
                          </div>
                          <Badge variant="outline" className={`${p.aiSeverityScore <= 2 ? 'border-red-500 text-red-500' : 'border-amber-500 text-amber-500'} font-bold`}>
                            TIER {p.aiSeverityScore}
                          </Badge>
                        </div>
                        
                        <div className="grid grid-cols-2 gap-2 mt-1">
                          <div className="bg-background/50 rounded p-1.5 flex items-center gap-2">
                            <Activity className="w-3 h-3 text-blue-500" />
                            <span className="text-[10px] font-mono text-muted-foreground uppercase">ETA: {p.eta} MINS</span>
                          </div>
                          <div className="bg-background/50 rounded p-1.5 flex items-center gap-2">
                            <MapPin className="w-3 h-3 text-purple-500" />
                            <span className="text-[10px] font-mono text-muted-foreground uppercase">TO: {p.destinationHospitalId}</span>
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            );
          })
        )}
      </div>
    </div>
  );
}
