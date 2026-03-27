"use client";

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Patient } from "@/data/mockPatients";
import { Hospital, mockHospitals } from "@/data/mockHospitals";
import { RealHospital } from "@/lib/hospitalApi";
import { DbHospital } from "@/hooks/useFirebaseData";
import { Badge } from "@/components/ui/badge";
import { Clock, Activity, FileText, CheckCircle2, ArrowRightLeft, Building2, ChevronLeft, Bot, Video, Radio, Cpu, History as HistoryIcon, UserCircle, Droplet, Phone, Layers, PlayCircle } from "lucide-react";
import { EventTimeline } from "./EventTimeline";
import { toast } from "sonner";
import { useState, useEffect } from "react";
import { motion } from "framer-motion";

interface PatientDetailModalProps {
  patient: Patient;
  onClose: () => void;
  hospitalLocation?: {lat: number, lng: number};
  nearbyHospitals?: RealHospital[];
  dbHospitals?: DbHospital[];
  onReroute?: (patientId: string, targetHospital: RealHospital | DbHospital) => void;
  onCompleteTreatment?: (patientId: string) => void;
}

function getDistanceFromLatLonInKm(lat1: number, lon1: number, lat2: number, lon2: number) {
  const R = 6371; 
  const dLat = (lat2 - lat1) * (Math.PI / 180);
  const dLon = (lon2 - lon1) * (Math.PI / 180);
  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(lat1 * (Math.PI / 180)) * Math.cos(lat2 * (Math.PI / 180)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c; 
}

export function PatientDetailModal({ patient, onClose, hospitalLocation, nearbyHospitals = [], dbHospitals = [], onReroute, onCompleteTreatment }: PatientDetailModalProps) {
  const [activeTab, setActiveTab] = useState<"overview" | "history" | "triage" | "telemedicine">("overview");
  const [isTransferMode, setIsTransferMode] = useState(false);
  const [isTransferring, setIsTransferring] = useState<string | null>(null);

  // AI Post-Treatment Report
  const [isGeneratingReport, setIsGeneratingReport] = useState(false);
  const [generatedReport, setGeneratedReport] = useState<string | null>(null);

  // For Telemedicine demo blink effect
  const [recording, setRecording] = useState(true);
  useEffect(() => {
    const int = setInterval(() => setRecording(r => !r), 1000);
    return () => clearInterval(int);
  }, []);

  if (!patient) return null;

  const handleClose = () => {
    onClose();
    setTimeout(() => setIsTransferMode(false), 200);
  };

  const getSeverityBadge = (score: number) => {
    switch (score) {
      case 1: return <Badge className="bg-red-500 hover:bg-red-600 text-white animate-pulse">Critical/Code Red</Badge>;
      case 2: return <Badge className="bg-orange-500 hover:bg-orange-600">High Priority</Badge>;
      case 3: return <Badge className="bg-yellow-500 hover:bg-yellow-600 text-black">Moderate</Badge>;
      case 4: 
      case 5: return <Badge className="bg-green-500 hover:bg-green-600">Low Priority</Badge>;
      default: return <Badge>Unknown</Badge>;
    }
  };

  const handleTransfer = (hospitalId: string, hospitalName: string) => {
    setIsTransferring(hospitalId);
    
    // Check DB first, then fallback to OSM API map hospitals
    const targetDbHosp = dbHospitals.find(h => h.id === hospitalId);
    const targetOmsHosp = nearbyHospitals.find(h => h.id === hospitalId) as unknown as RealHospital;
    
    // Normalize coordinates for the reroute engine
    let rerouteTarget: any = null;
    if (targetDbHosp) {
      rerouteTarget = { id: targetDbHosp.id, name: targetDbHosp.name, lat: targetDbHosp.location?.latitude || 0, lng: targetDbHosp.location?.longitude || 0 };
    } else if (targetOmsHosp) {
      rerouteTarget = targetOmsHosp;
    }

    setTimeout(() => {
      setIsTransferring(null);
      toast.success("Transfer Request Sent", {
        description: `Patient ${patient.patientName} is being rerouted to ${hospitalName}.`,
        icon: <CheckCircle2 className="h-4 w-4 text-green-500" />
      });
      
      if (onReroute && rerouteTarget) {
        onReroute(patient.id, rerouteTarget);
      }
      
      handleClose();
    }, 1500);
  };

  const handleGenerateReport = () => {
    setIsGeneratingReport(true);
    // Simulate AI thinking delay
    setTimeout(() => {
      setGeneratedReport(`**AI-Generated Post-Treatment Summary**\n\n**Patient:** ${patient.patientName} (${patient.medicalHistory?.bloodGroup || 'Unknown Blood Type'})\n**Initial Triage:** Severity Tier ${patient.aiSeverityScore}\n\n**Synopsis:** Patient was admitted following a priority dispatch with SOS transcript indicating: "${patient.rawSosMessage?.slice(0, 30)}...". Vitals stabilized rapidly upon facility intake. Primary trauma has been effectively managed via specialized care protocol. \n\n**Prognosis:** Stable. Recommended 48-hour observation pending final neuro/ortho clearance. Outpatient physical therapy plan to be determined post-discharge.\n\n*Generated by Health AI Reporting Engine.*`);
      setIsGeneratingReport(false);
      toast.success("Discharge Report Generated successfully");
    }, 2000);
  };

  return (
    <Dialog open={!!patient} onOpenChange={(open) => !open && handleClose()}>
      <DialogContent className="sm:max-w-2xl bg-background text-foreground border-border max-h-[90vh] overflow-y-auto custom-scrollbar">
        <DialogHeader className="border-b border-border pb-4">
          <div className="flex justify-between items-start">
            <div>
              <DialogTitle className="text-2xl font-bold flex items-center gap-2">
                {patient.patientName}
                <span className="text-sm font-mono text-muted-foreground bg-muted px-2 py-0.5 rounded">
                  {patient.id}
                </span>
              </DialogTitle>
              <DialogDescription className="text-muted-foreground mt-1">
                Incoming Emergency Details
              </DialogDescription>
            </div>
            {getSeverityBadge(patient.aiSeverityScore)}
          </div>
        </DialogHeader>
        
        {!isTransferMode ? (
          <>
            <div className="grid gap-6 py-4">
              <div className="grid grid-cols-2 gap-4">
                <div className="bg-secondary/50 p-4 rounded-lg border border-border flex flex-col gap-1 items-start">
                  <div className="text-muted-foreground text-xs flex items-center gap-1 uppercase tracking-wider font-semibold">
                    <Clock className="w-3 h-3" /> ETA
                  </div>
                  <div className="text-2xl font-mono font-bold text-blue-400">
                    {patient.eta} <span className="text-sm text-blue-400/70">mins</span>
                  </div>
                </div>
                
                <div className="bg-secondary/50 p-4 rounded-lg border border-border flex flex-col gap-1 items-start">
                  <div className="text-muted-foreground text-xs flex items-center gap-1 uppercase tracking-wider font-semibold">
                    <Activity className="w-3 h-3" /> Triage Level
                  </div>
                  <div className="text-xl font-bold">
                    Level {patient.aiSeverityScore}
                  </div>
                </div>
              </div>

            <div className="flex border-b border-border bg-muted/20 overflow-x-auto custom-scrollbar">
                <button 
                  onClick={() => setActiveTab("overview")}
                  className={`flex-1 py-3 px-4 text-xs lg:text-sm font-bold border-b-2 whitespace-nowrap transition-colors ${activeTab === "overview" ? "border-primary text-primary bg-primary/5" : "border-transparent text-muted-foreground hover:bg-muted/50"}`}
                >
                  <Activity className="w-4 h-4 inline-block mr-2" /> Triage Summary
                </button>
                <button 
                  onClick={() => setActiveTab("history")}
                  className={`flex-1 py-3 px-4 text-xs lg:text-sm font-bold border-b-2 whitespace-nowrap transition-colors ${activeTab === "history" ? "border-emerald-500 text-emerald-500 bg-emerald-500/5" : "border-transparent text-muted-foreground hover:bg-muted/50"}`}
                >
                  <HistoryIcon className="w-4 h-4 inline-block mr-2" /> Med History
                </button>
                <button 
                  onClick={() => setActiveTab("triage")}
                  className={`flex-1 py-3 px-4 text-xs lg:text-sm font-bold border-b-2 whitespace-nowrap transition-colors ${activeTab === "triage" ? "border-amber-500 text-amber-500 bg-amber-500/5" : "border-transparent text-muted-foreground hover:bg-muted/50"}`}
                >
                  <Cpu className="w-4 h-4 inline-block mr-2" /> AI Triage Docs
                </button>
                <button 
                  onClick={() => setActiveTab("telemedicine")}
                  className={`flex-1 py-3 px-4 text-xs lg:text-sm font-bold border-b-2 whitespace-nowrap transition-colors ${activeTab === "telemedicine" ? "border-blue-500 text-blue-500 bg-blue-500/5" : "border-transparent text-muted-foreground hover:bg-muted/50"}`}
                >
                  <Video className="w-4 h-4 inline-block mr-2" /> Live Vitals
                </button>
              </div>

              <motion.div 
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                className="p-6"
              >
                {activeTab === "overview" && (
                  <div className="space-y-6">
                    {patient.peol && (
                      <div className="grid grid-cols-2 lg:grid-cols-3 gap-4">
                        <div className="bg-secondary/30 border border-emerald-500/30 rounded-xl p-4 flex flex-col items-center justify-center text-center shadow-sm">
                          <div className="text-[10px] font-bold text-muted-foreground mb-1 uppercase tracking-widest">Survival Probability</div>
                          <div className={`text-4xl font-black ${patient.peol.survivalProb > 80 ? 'text-emerald-500' : (patient.peol.survivalProb > 50 ? 'text-amber-500' : 'text-red-500')}`}>
                            {patient.peol.survivalProb}%
                          </div>
                          <div className="text-[10px] text-muted-foreground mt-1 font-mono">PEOL ORCHESTRATED</div>
                        </div>

                        <div className="bg-secondary/30 border border-blue-500/30 rounded-xl p-4 flex flex-col items-center justify-center text-center shadow-sm">
                          <div className="text-[10px] font-bold text-muted-foreground mb-1 uppercase tracking-widest">Delay Impact</div>
                          <div className="text-4xl font-black text-red-400">
                            {patient.peol.delayImpact}%
                          </div>
                          <div className="text-[10px] text-muted-foreground mt-1 font-mono">TRANSIT PENALTY</div>
                        </div>

                        <div className="bg-secondary/30 border border-purple-500/30 rounded-xl p-4 flex flex-col items-center justify-center text-center shadow-sm col-span-2 lg:col-span-1">
                          <div className="text-[10px] font-bold text-muted-foreground mb-1 uppercase tracking-widest">Routing Confidence</div>
                          <div className="text-4xl font-black text-purple-500">
                            {patient.peol.decisionConfidence}%
                          </div>
                          <div className="text-[10px] text-muted-foreground mt-1 font-mono">FACILITY MATCH</div>
                        </div>

                        {patient.peol.systemActions.length > 0 && (
                          <div className="col-span-2 lg:col-span-3 bg-card border border-border shadow-sm rounded-xl p-4 mt-2">
                            <h4 className="text-[11px] font-black text-foreground mb-3 flex items-center gap-2 uppercase tracking-widest">
                              <Cpu className="w-4 h-4 text-blue-500" /> Pre-Arrival Resource Auto-Allocation
                            </h4>
                            <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                              {patient.peol.systemActions.map((action, i) => (
                                <div key={i} className="flex items-center gap-3 text-sm bg-secondary/50 p-2.5 rounded-lg border border-border/50">
                                  <div className="bg-emerald-500/20 p-1.5 rounded-md">
                                    <CheckCircle2 className="w-4 h-4 text-emerald-500" />
                                  </div>
                                  <div>
                                    <p className="font-semibold text-foreground text-xs">{action.message}</p>
                                    <p className="text-[10px] text-muted-foreground font-mono mt-0.5">{new Date(action.timestamp).toLocaleTimeString()}</p>
                                  </div>
                                </div>
                              ))}
                            </div>
                          </div>
                        )}
                      </div>
                    )}

                    <div className="bg-muted/20 border border-border rounded-lg p-5">
                      <h3 className="text-sm font-bold flex items-center gap-2 mb-3 text-foreground">
                        <FileText className="w-4 h-4 text-blue-500" />
                        AI Pre-Treatment Intake Summary
                      </h3>
                      <p className="text-muted-foreground text-sm leading-relaxed">{patient.aiSummary}</p>
                    </div>

                    {patient.status === "COMPLETED" ? (
                      <div className="bg-emerald-500/10 border border-emerald-500/30 rounded-lg p-5">
                        <h4 className="font-bold text-emerald-500 mb-2 font-mono flex items-center gap-2">
                          <CheckCircle2 className="w-5 h-5" /> TREATMENT COMPLETED
                        </h4>
                        <p className="text-sm text-foreground/80 mb-4">Patient has been officially treated by facility doctors. Medical files are now finalized and uncoupled from active triage. Proceed to generate algorithmic discharge documents for central database serialization.</p>
                        
                        {!generatedReport && (
                          <Button 
                            onClick={handleGenerateReport}
                            disabled={isGeneratingReport}
                            className="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-bold py-6 shadow-lg border border-emerald-400 rounded-lg text-lg group transition-all"
                          >
                            {isGeneratingReport ? (
                              <span className="flex items-center gap-3">
                                <span className="animate-spin w-5 h-5 border-4 border-white/30 border-t-white rounded-full shadow-sm"></span>
                                Synthesizing Final Discharge Analysis...
                              </span>
                            ) : (
                              <span className="flex items-center gap-2">
                                <Bot className="w-6 h-6 mr-1 group-hover:scale-110 transition-transform" />
                                Generate Post-Treatment AI Report
                              </span>
                            )}
                          </Button>
                        )}
                      </div>
                    ) : (
                      <div className="bg-amber-500/10 border border-amber-500/30 rounded-lg p-5 border-dashed mb-6 mt-4">
                        <div className="text-sm font-bold text-amber-500 flex items-center gap-2">
                           <Activity className="w-4 h-4 animate-pulse" /> Patient actively receiving emergency treatment.
                        </div>
                        <p className="text-xs text-muted-foreground mt-2 font-mono">
                          Post-Treatment AI Discharge Generator locked until patient finishes operations.
                        </p>
                      </div>
                    )}

                    {generatedReport && (
                      <motion.div 
                        initial={{ opacity: 0, height: 0 }}
                        animate={{ opacity: 1, height: "auto" }}
                        className="bg-emerald-500/5 border border-emerald-500/30 rounded-lg p-5"
                      >
                         <h3 className="text-sm font-bold flex items-center gap-2 mb-3 text-emerald-500">
                           <CheckCircle2 className="w-4 h-4" />
                           AI Post-Treatment Discharge Report
                         </h3>
                         <div className="text-sm text-foreground whitespace-pre-wrap leading-relaxed">
                           {generatedReport}
                         </div>
                      </motion.div>
                    )}

                    <div className="space-y-3">
                      <h3 className="text-sm font-bold text-foreground">Dispatch Timeline</h3>
                      <div className="bg-card border border-border rounded-lg p-1">
                        <EventTimeline patients={[]} selectedPatient={patient} />
                      </div>
                    </div>
                  </div>
                )}

                {activeTab === "history" && (
                  <div className="space-y-4">
                    <div className="grid grid-cols-2 gap-4">
                      <div className="bg-muted/20 border border-border rounded-lg p-4 flex items-center gap-4">
                        <div className="bg-red-500/10 p-3 rounded-full">
                          <Droplet className="w-6 h-6 text-red-500" />
                        </div>
                        <div>
                          <p className="text-xs font-bold text-muted-foreground uppercase tracking-widest">Blood Group</p>
                          <p className="text-xl font-black text-foreground">{patient.medicalHistory?.bloodGroup || "Unknown"}</p>
                        </div>
                      </div>
                      <div className="bg-muted/20 border border-border rounded-lg p-4 flex items-center gap-4">
                        <div className="bg-blue-500/10 p-3 rounded-full">
                          <Phone className="w-6 h-6 text-blue-500" />
                        </div>
                        <div>
                          <p className="text-xs font-bold text-muted-foreground uppercase tracking-widest">Emergency Contact</p>
                          <p className="text-sm font-bold text-foreground truncate max-w-[120px]">{patient.medicalHistory?.emergencyContact.name}</p>
                          <p className="text-xs font-mono text-muted-foreground mt-0.5">{patient.medicalHistory?.emergencyContact.number}</p>
                        </div>
                      </div>
                    </div>
                    
                    <div className="bg-background border border-border rounded-lg p-5 shadow-inner">
                      <h3 className="text-sm font-bold flex items-center gap-2 mb-3 text-foreground">
                        <Layers className="w-4 h-4 text-primary" />
                        Known Medical Context (DB Sync)
                      </h3>
                      <p className="text-muted-foreground text-sm leading-relaxed whitespace-pre-wrap">
                        {patient.medicalHistory?.medicalContext || "No prior records located in the centralized database for this individual."}
                      </p>
                    </div>

                    <div className="bg-amber-500/10 border border-amber-500/30 rounded-lg p-4 flex items-start gap-3">
                      <CheckCircle2 className="w-4 h-4 text-amber-500 mt-0.5" />
                      <p className="text-xs text-amber-600 dark:text-amber-400 font-medium leading-relaxed">
                        Data retrieved successfully from the global healthcare database via User ID biometric handshake. Information represents the patient's pre-existing conditions solely.
                      </p>
                    </div>
                  </div>
                )}

                {activeTab === "triage" && (
                  <div className="space-y-6">
                    <div className="bg-amber-500/10 border border-amber-500/30 rounded-lg p-5">
                      <h3 className="text-sm font-bold flex items-center gap-2 mb-3 text-amber-500">
                        <Bot className="w-4 h-4" />
                        NLP Engine: Raw SOS Analysis
                      </h3>
                      <div className="bg-background/80 rounded border border-border p-4 font-mono text-sm leading-relaxed text-muted-foreground shadow-inner">
                        <div className="flex items-center gap-2 mb-2 text-xs font-bold font-sans text-foreground">
                          <Radio className="w-3 h-3 text-blue-500 animate-pulse" />
                          RAW INGEST FROM FIELD APP:
                        </div>
                        {patient.rawSosMessage ? (
                          <div dangerouslySetInnerHTML={{
                            __html: patient.rawSosMessage
                              .replace(/(bleeding|unconscious|crash|hemorrhage|trauma|arrest|severe)/gi, '<span class="bg-red-500/20 text-red-500 px-1 rounded font-bold border border-red-500/30">$&</span>')
                          }} />
                        ) : (
                          "NO RAW TRANSCRIPT AVAILABLE"
                        )}
                      </div>
                    </div>
                    
                    <div className="grid grid-cols-2 gap-4">
                      <div className="bg-muted/20 border border-border rounded-lg p-4">
                        <div className="text-xs font-bold text-muted-foreground uppercase mb-1">Algorithmic Severity</div>
                        <div className="text-2xl font-black text-foreground">Tier {patient.aiSeverityScore}</div>
                      </div>
                      <div className="bg-muted/20 border border-border rounded-lg p-4">
                        <div className="text-xs font-bold text-muted-foreground uppercase mb-1">Queue Priority</div>
                        <div className="text-2xl font-black text-foreground">Immediate</div>
                      </div>
                    </div>
                  </div>
                )}

                {activeTab === "telemedicine" && (
                  <div className="space-y-4">
                    <div className="relative w-full h-48 bg-black rounded-lg overflow-hidden border border-border flex flex-col items-center justify-center shadow-inner">
                      <div className="absolute top-3 left-3 flex items-center gap-2">
                        {recording && <div className="w-2.5 h-2.5 rounded-full bg-red-500"></div>}
                        <span className="text-xs font-mono text-white/80 font-bold tracking-widest">LIVE SAT-LINK</span>
                      </div>
                      <Video className="w-12 h-12 text-white/20 mb-3" />
                      <p className="text-white/50 text-sm font-mono uppercase tracking-widest">Waiting for field camera...</p>
                      
                      <Button variant="secondary" size="sm" className="mt-4 bg-blue-600 hover:bg-blue-700 text-white border-0 font-bold">
                        Force Connection
                      </Button>
                    </div>

                    <div className="grid grid-cols-3 gap-3">
                      <div className="bg-muted/30 border border-border rounded-lg p-3 text-center">
                        <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest mb-1">Heart Rate</div>
                        <div className="flex items-end justify-center gap-1">
                          <span className="text-2xl font-black text-red-500 font-mono">{patient.vitals?.bpm || "—"}</span>
                          <span className="text-xs text-muted-foreground mb-1">bpm</span>
                        </div>
                      </div>
                      <div className="bg-muted/30 border border-border rounded-lg p-3 text-center">
                        <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest mb-1">Blood Oxygen</div>
                        <div className="flex items-end justify-center gap-1">
                          <span className="text-2xl font-black text-blue-500 font-mono">{patient.vitals?.spO2 || "—"}</span>
                          <span className="text-xs text-muted-foreground mb-1">%</span>
                        </div>
                      </div>
                      <div className="bg-muted/30 border border-border rounded-lg p-3 text-center">
                        <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest mb-1">Temp</div>
                        <div className="flex items-end justify-center gap-1">
                          <span className="text-2xl font-black text-orange-500 font-mono">{patient.vitals?.temp || "—"}</span>
                          <span className="text-xs text-muted-foreground mb-1">°F</span>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </motion.div>
            </div>
            
            <div className="pt-2 flex flex-col gap-3">
              <div className="grid grid-cols-2 gap-3">
                <Button 
                  variant="outline" 
                  disabled={patient.status === "COMPLETED"}
                  onClick={() => setIsTransferMode(true)}
                  className="w-full border-blue-500/30 text-blue-500 hover:bg-blue-500/10 hover:text-blue-400 transition-all font-bold disabled:opacity-50"
                >
                  <ArrowRightLeft className="w-4 h-4 mr-2" />
                  Reroute
                </Button>
                <Button 
                  variant="outline" 
                  disabled={patient.status === "COMPLETED"}
                  onClick={() => onCompleteTreatment && onCompleteTreatment(patient.id)}
                  className="w-full border-emerald-500/30 text-emerald-500 hover:bg-emerald-500/10 hover:text-emerald-400 transition-all font-bold disabled:opacity-50"
                >
                  <CheckCircle2 className="w-4 h-4 mr-2" />
                  Mark Treated
                </Button>
              </div>
              <Button variant="ghost" onClick={handleClose} className="text-muted-foreground hover:text-foreground hover:bg-muted w-full">
                Close Active Feed
              </Button>
            </div>
          </>
        ) : (
          <motion.div 
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            className="flex flex-col gap-4 py-2"
          >
            <DialogHeader>
              <div className="flex items-center gap-2">
                <Button variant="ghost" size="icon" onClick={() => setIsTransferMode(false)} className="h-8 w-8 text-muted-foreground hover:text-foreground hover:bg-muted">
                  <ChevronLeft className="h-5 w-5" />
                </Button>
                <DialogTitle className="font-semibold text-lg">Select Destination Facility</DialogTitle>
              </div>
              <DialogDescription className="text-muted-foreground pb-4 border-b border-border">
                Select a verified facility below to officially reroute Unit {patient.id.replace('P','')}. Distances are dynamically calculated from the patient's current location to the target facility.
              </DialogDescription>
            </DialogHeader>
            
            <div className="grid gap-3 py-4 max-h-[50vh] overflow-y-auto custom-scrollbar pr-2">
              {dbHospitals.length > 0 && (
                <div className="mb-4">
                  <div className="text-[10px] font-bold text-emerald-500 uppercase tracking-widest mb-2 flex items-center gap-1">
                    <CheckCircle2 className="w-3 h-3" /> VERIFIED NETWORK PARTNERS
                  </div>
                  {dbHospitals.map((hosp) => (
                    <div 
                      key={hosp.id}
                      className="flex items-center justify-between p-3 rounded-lg border border-emerald-500/30 bg-emerald-500/5 mb-2 hover:bg-emerald-500/10 transition-colors group"
                    >
                      <div className="flex items-start gap-3">
                        <div className="bg-emerald-500/10 p-2 rounded-md mt-1 group-hover:bg-emerald-500/20 transition-colors">
                          <Building2 className="w-5 h-5 text-emerald-500" />
                        </div>
                        <div>
                          <p className="font-semibold text-sm text-foreground">{hosp.name}</p>
                          <div className="flex gap-2 mt-2">
                            {hosp.mockAvailableBeds !== undefined && (
                              <Badge variant="outline" className="text-[10px] bg-background">
                                {hosp.mockAvailableBeds} Beds Avail.
                              </Badge>
                            )}
                            {hosp.facilities?.hasTraumaCenter && (
                              <Badge variant="outline" className="text-[10px] bg-red-500/10 text-red-500 border-red-500/20">
                                Trauma Ctr
                              </Badge>
                            )}
                            {hosp.facilities?.hasBurnUnit && (
                              <Badge variant="outline" className="text-[10px] bg-orange-500/10 text-orange-500 border-orange-500/20">
                                Burn Unit
                              </Badge>
                            )}
                          </div>
                        </div>
                      </div>
                      <Button 
                        size="sm"
                        variant={isTransferring === hosp.id ? "default" : "secondary"}
                        disabled={isTransferring !== null}
                        onClick={() => handleTransfer(hosp.id, hosp.name || "Unknown Hospital")}
                        className="font-medium min-w-[100px] bg-primary hover:bg-primary/90 text-primary-foreground"
                      >
                        {isTransferring === hosp.id ? (
                          <span className="flex items-center gap-2">
                            <span className="animate-spin w-3 h-3 border-2 border-white/30 border-t-white rounded-full"></span>
                            Routing...
                          </span>
                        ) : "Select"}
                      </Button>
                    </div>
                  ))}
                </div>
              )}

              <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest mb-2 flex items-center gap-1 mt-4 border-t border-border pt-4">
                <Building2 className="w-3 h-3" /> PUBLIC MAP DIRECTORY
              </div>
              
              {nearbyHospitals.length > 0 ? (
                nearbyHospitals
                  .map(h => ({
                    ...h,
                    calcDistKm: getDistanceFromLatLonInKm(patient.patientLocation.lat, patient.patientLocation.lng, h.lat, h.lng).toFixed(2)
                  }))
                  .sort((a, b) => parseFloat(a.calcDistKm) - parseFloat(b.calcDistKm))
                  .map((hospital) => (
                  <div 
                    key={hospital.id} 
                    className="flex items-center justify-between p-4 rounded-lg border border-border bg-card/50 hover:bg-accent hover:border-accent-foreground/20 transition-all group mb-2"
                  >
                    <div className="flex items-start gap-3">
                      <div className="bg-primary/10 p-2 rounded-md mt-1 group-hover:bg-primary/20 transition-colors">
                        <Building2 className="w-5 h-5 text-primary" />
                      </div>
                      <div>
                        <h4 className="font-medium text-foreground">{hospital.name}</h4>
                        <div className="flex items-center gap-3 text-xs text-muted-foreground mt-1">
                          <span className="flex items-center gap-1 font-mono bg-secondary/50 px-1.5 py-0.5 rounded">
                            <Clock className="w-3 h-3" />
                            {hospital.calcDistKm} km approx.
                          </span>
                          <span className="flex items-center gap-1 font-mono bg-secondary/50 px-1.5 py-0.5 rounded">
                            <Activity className="w-3 h-3" />
                            {Math.round(parseFloat(hospital.calcDistKm) * 3)} min ETA
                          </span>
                        </div>
                      </div>
                    </div>
                    <Button 
                      size="sm" 
                      variant={isTransferring === hospital.id ? "default" : "secondary"}
                      disabled={isTransferring !== null}
                      onClick={() => handleTransfer(hospital.id, hospital.name)}
                      className="font-medium min-w-[100px]"
                    >
                      {isTransferring === hospital.id ? (
                        <span className="flex items-center gap-2">
                          <div className="w-4 h-4 rounded-full border-2 border-primary-foreground border-t-transparent animate-spin"></div>
                          Routing...
                        </span>
                      ) : "Select"}
                    </Button>
                  </div>
                  ))
              ) : (
                mockHospitals.map((hospital) => (
                  <div 
                    key={hospital.id} 
                    className="flex items-center justify-between p-4 rounded-lg border border-border bg-card/50 hover:bg-accent hover:border-accent-foreground/20 transition-all group mb-2"
                  >
                    <div className="flex items-start gap-3">
                      <div className="bg-primary/10 p-2 rounded-md mt-1 group-hover:bg-primary/20 transition-colors">
                        <Building2 className="w-5 h-5 text-primary" />
                      </div>
                      <div>
                        <h4 className="font-medium text-foreground">{hospital.name}</h4>
                        <div className="flex items-center gap-3 text-xs text-muted-foreground mt-1">
                          <span className="flex items-center gap-1 font-mono bg-secondary/50 px-1.5 py-0.5 rounded">
                            <Clock className="w-3 h-3" />
                            {hospital.distance} away
                          </span>
                          <span className="flex items-center gap-1 font-mono bg-secondary/50 px-1.5 py-0.5 rounded">
                            <Activity className="w-3 h-3" />
                            {hospital.bedAvailability} capacity
                          </span>
                        </div>
                      </div>
                    </div>
                    <Button 
                      size="sm" 
                      variant={isTransferring === hospital.id ? "default" : "secondary"}
                      disabled={isTransferring !== null}
                      onClick={() => handleTransfer(hospital.id, hospital.name)}
                      className="font-medium min-w-[100px]"
                    >
                      {isTransferring === hospital.id ? (
                        <span className="flex items-center gap-2">
                          <div className="w-4 h-4 rounded-full border-2 border-primary-foreground border-t-transparent animate-spin"></div>
                          Routing...
                        </span>
                      ) : "Select"}
                    </Button>
                  </div>
                ))
              )}
            </div>
          </motion.div>
        )}
      </DialogContent>
    </Dialog>
  );
}
