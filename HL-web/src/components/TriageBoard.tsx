"use client";

import { useMemo } from "react";
import { Patient } from "@/data/mockPatients";
import { 
  Table, 
  TableBody, 
  TableCell, 
  TableHead, 
  TableHeader, 
  TableRow 
} from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { LiveETA } from "@/components/LiveETA";
import { Activity, CheckCircle2 } from "lucide-react";

interface TriageBoardProps {
  patients: Patient[];
  onSelectPatient: (patient: Patient) => void;
}

export function TriageBoard({ patients, onSelectPatient }: TriageBoardProps) {
  const activePatients = useMemo(() => {
    return [...patients].filter(p => p.status !== "COMPLETED").sort((a, b) => {
      if (a.aiSeverityScore !== b.aiSeverityScore) {
        return a.aiSeverityScore - b.aiSeverityScore;
      }
      return a.eta - b.eta;
    });
  }, [patients]);

  const dischargedPatients = useMemo(() => {
    return [...patients].filter(p => p.status === "COMPLETED").sort((a, b) => {
      return b.id.localeCompare(a.id);
    });
  }, [patients]);

  const getSeverityColor = (score: number) => {
    switch (score) {
      case 1:
        return "bg-red-500 hover:bg-red-600 animate-pulse";
      case 2:
        return "bg-orange-500 hover:bg-orange-600";
      case 3:
        return "bg-yellow-500 hover:bg-yellow-600 text-black";
      case 4:
      case 5:
        return "bg-green-500 hover:bg-green-600";
      default:
        return "bg-gray-500 hover:bg-gray-600";
    }
  };

  const getSeverityLabel = (score: number) => {
    switch (score) {
      case 1: return "CRITICAL";
      case 2: return "HIGH";
      case 3: return "MODERATE";
      case 4: return "LOW";
      case 5: return "VERY LOW";
      default: return "UNKNOWN";
    }
  };

  return (
    <div className="flex flex-col gap-6 w-full pb-2">
      {/* Active Emergencies */}
      <div className="rounded-md border border-border bg-card text-card-foreground shadow-md overflow-hidden transition-colors duration-300">
        <div className="bg-muted p-2.5 px-4 border-b border-border flex justify-between items-center">
          <h3 className="font-bold text-foreground flex items-center gap-2 text-sm uppercase tracking-wider">
            <Activity className="w-4 h-4 text-blue-500" /> Active Emergency Radar
          </h3>
          <Badge variant="secondary" className="font-mono">{activePatients.length} ACTIVE</Badge>
        </div>
        <div className="relative">
          <Table>
            <TableHeader className="bg-muted/90 sticky top-0 z-10 backdrop-blur-sm">
              <TableRow className="hover:bg-muted/50 border-b-border">
                <TableHead className="w-[80px] text-muted-foreground text-xs font-bold uppercase tracking-wider">ID</TableHead>
                <TableHead className="text-muted-foreground text-xs font-bold uppercase tracking-wider">Patient</TableHead>
                <TableHead className="text-muted-foreground text-xs font-bold uppercase tracking-wider">Severity</TableHead>
                <TableHead className="text-muted-foreground text-xs font-bold uppercase tracking-wider text-right">ETA</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {activePatients.map((patient) => (
                <TableRow 
                  key={patient.id} 
                  className="cursor-pointer hover:bg-muted/50 border-b-border transition-colors group"
                  onClick={() => onSelectPatient(patient)}
                >
                  <TableCell className="font-medium text-muted-foreground group-hover:text-foreground transition-colors">{patient.id}</TableCell>
                  <TableCell className="font-semibold text-foreground">{patient.patientName}</TableCell>
                  <TableCell>
                    <Badge className={`${getSeverityColor(patient.aiSeverityScore)} text-white font-bold tracking-wide shadow-sm py-0.5`}>
                      {getSeverityLabel(patient.aiSeverityScore)}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-muted-foreground font-mono font-bold text-right text-sm">
                    <LiveETA initialETA={patient.eta} />
                  </TableCell>
                </TableRow>
              ))}
              {activePatients.length === 0 && (
                <TableRow>
                  <TableCell colSpan={4} className="h-24 text-center text-muted-foreground">
                    <div className="flex flex-col items-center justify-center gap-2">
                      <Activity className="w-6 h-6 opacity-20" />
                      No active emergencies.
                    </div>
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </div>
      </div>

      {/* Discharged Ledger */}
      {dischargedPatients.length > 0 && (
        <div className="rounded-md border border-emerald-500/30 bg-card text-card-foreground shadow-sm overflow-hidden opacity-90 hover:opacity-100 transition-all duration-300">
          <div className="bg-emerald-500/10 p-2.5 px-4 border-b border-emerald-500/20 flex justify-between items-center">
            <h3 className="font-bold text-emerald-600 dark:text-emerald-500 flex items-center gap-2 text-sm uppercase tracking-wider">
              <CheckCircle2 className="w-4 h-4" /> Discharged Ledger
            </h3>
            <Badge className="bg-emerald-500 hover:bg-emerald-600 font-mono text-white shadow-sm border-0">{dischargedPatients.length} CLEARED</Badge>
          </div>
          <div className="relative">
            <Table>
              <TableHeader className="bg-emerald-500/10 sticky top-0 z-10 backdrop-blur-sm">
                <TableRow className="hover:bg-muted/30 border-b-border">
                  <TableHead className="w-[80px] text-muted-foreground text-xs font-bold uppercase tracking-wider">ID</TableHead>
                  <TableHead className="text-muted-foreground text-xs font-bold uppercase tracking-wider">Patient</TableHead>
                  <TableHead className="text-muted-foreground text-xs font-bold uppercase tracking-wider">Status</TableHead>
                  <TableHead className="text-muted-foreground text-xs font-bold uppercase tracking-wider text-right"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {dischargedPatients.map((patient) => (
                  <TableRow 
                    key={patient.id} 
                    className="cursor-pointer hover:bg-emerald-500/5 border-b-border transition-colors group"
                    onClick={() => onSelectPatient(patient)}
                  >
                    <TableCell className="font-medium text-emerald-600/50 dark:text-emerald-500/50">{patient.id}</TableCell>
                    <TableCell className="font-semibold text-foreground/80 decoration-emerald-500/30">{patient.patientName}</TableCell>
                    <TableCell>
                      <Badge className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border border-emerald-500/30 shadow-none hover:bg-emerald-500/20 py-0.5">
                        TREATED
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right text-[10px] text-muted-foreground font-mono uppercase tracking-widest opacity-50">Archived</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      )}
    </div>
  );
}
