import { Patient, PatientEvent } from "@/data/mockPatients";
import { Clock, Navigation, AlertCircle, CheckCircle2, Ambulance, Cpu } from "lucide-react";
import { formatDistanceToNow } from "date-fns";
import { useMemo } from "react";

interface EventTimelineProps {
  patients: Patient[];
  selectedPatient?: Patient | null;
}

const getEventIcon = (type: PatientEvent['type'] | string) => {
  switch (type as string) {
    case 'SYSTEM_DECISION': return <Cpu className="h-4 w-4 text-purple-500" />;
    case 'REQUESTED': return <AlertCircle className="h-4 w-4 text-red-500" />;
    case 'DISPATCHED': return <Ambulance className="h-4 w-4 text-blue-500" />;
    case 'EN_ROUTE': return <Navigation className="h-4 w-4 text-primary" />;
    case 'ARRIVED': return <CheckCircle2 className="h-4 w-4 text-green-500" />;
    case 'IN_TRANSIT': return <Ambulance className="h-4 w-4 text-yellow-500" />;
    case 'AT_HOSPITAL': return <CheckCircle2 className="h-4 w-4 text-green-600" />;
    default: return <Clock className="h-4 w-4 text-muted-foreground" />;
  }
};

export function EventTimeline({ patients, selectedPatient }: EventTimelineProps) {
  const events = useMemo(() => {
    if (!selectedPatient) return [];
    
    let allEvents: (PatientEvent & { patientName: string; patientId: string })[] = [];
    
    (selectedPatient.events || []).forEach(event => {
      allEvents.push({
        ...event,
        patientName: selectedPatient.patientName,
        patientId: selectedPatient.id
      });
    });

    // Sort by timestamp descending (newest first)
    return allEvents.sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime());
  }, [selectedPatient]);

  return (
    <div className="flex flex-col h-full bg-card rounded-xl border border-border shadow-xl overflow-hidden transition-colors duration-300">
      <div className="p-4 border-b border-border bg-slate-50/50 dark:bg-slate-800/50 backdrop-blur-sm shadow-sm flex items-center justify-between z-10">
        <h3 className="font-semibold text-foreground flex items-center gap-2">
          <Clock className="h-4 w-4 text-blue-500" />
          Real-time Updates
        </h3>
        {selectedPatient && (
          <span className="text-xs bg-primary/10 text-primary px-2 py-1 rounded-full font-medium">
            Timeline: {selectedPatient.id}
          </span>
        )}
      </div>
      
      <div className="flex-1 overflow-y-auto p-4 custom-scrollbar">
        {!selectedPatient ? (
          <div className="h-full flex flex-col items-center justify-center text-muted-foreground space-y-3 p-6 text-center">
            <div className="w-16 h-16 bg-blue-500/10 rounded-full flex items-center justify-center mb-2">
              <Navigation className="h-8 w-8 text-blue-500 opacity-80" />
            </div>
            <h4 className="font-semibold text-foreground">Select a Patient</h4>
            <p className="text-sm">Click on any patient in the Triage Board to view their real-time emergency timeline, fetched seamlessly via Flutter connected devices.</p>
          </div>
        ) : events.length === 0 ? (
          <div className="h-full flex flex-col items-center justify-center text-muted-foreground space-y-2">
            <Clock className="h-8 w-8 opacity-20" />
            <p className="text-sm">No recent events tracked yet.</p>
          </div>
        ) : (
          <div className="space-y-6">
            {events.map((event, i) => (
              <div key={`${event.id}-${i}`} className="relative flex gap-4">
                {/* Timeline connector visual (line) */}
                {i !== events.length - 1 && (
                  <div className="absolute left-[11px] top-7 bottom-[-24px] w-[2px] bg-border z-0"></div>
                )}
                
                <div className="relative z-10 flex-shrink-0 mt-1">
                  <div className={`w-6 h-6 rounded-full bg-background border-2 flex items-center justify-center shadow-sm ${event.type === 'SYSTEM_DECISION' ? 'border-purple-500' : 'border-border'}`}>
                    {getEventIcon(event.type)}
                  </div>
                </div>
                
                <div className={`flex-1 pb-1 ${event.type === 'SYSTEM_DECISION' ? 'bg-purple-500/10 p-3 rounded-lg border border-purple-500/30' : ''}`}>
                  <div className="flex justify-between items-start gap-2">
                    <p className={`text-sm font-medium leading-tight ${event.type === 'SYSTEM_DECISION' ? 'text-purple-500 dark:text-purple-400 font-bold' : 'text-foreground'}`}>
                      {event.description}
                    </p>
                    <span className="text-[10px] text-muted-foreground whitespace-nowrap bg-secondary px-1.5 py-0.5 rounded">
                      {formatDistanceToNow(new Date(event.timestamp), { addSuffix: true })}
                    </span>
                  </div>
                  <div className="mt-1 flex items-center gap-1">
                     <span className="text-[10px] uppercase tracking-wider font-semibold text-muted-foreground">Status:</span>
                     <span className={`text-[10px] uppercase tracking-wider font-bold ${event.type === 'SYSTEM_DECISION' ? 'text-purple-600 dark:text-purple-400' : 'text-blue-600 dark:text-blue-400'}`}>{event.type.replace('_', ' ')}</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
