"use client";

import { useEffect, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { AlertTriangle, X } from "lucide-react";
import { Patient } from "@/data/mockPatients";

interface ActiveAlertProps {
  patients: Patient[];
}

export function ActiveAlert({ patients }: ActiveAlertProps) {
  const [dismissedPatients, setDismissedPatients] = useState<Set<string>>(new Set());

  // Find critical patients that haven't been dismissed
  const criticalPatients = patients.filter(
    (p) => p.aiSeverityScore === 1 && !dismissedPatients.has(p.id)
  );

  const dismissAlert = (id: string) => {
    setDismissedPatients((prev) => {
      const newSet = new Set(prev);
      newSet.add(id);
      return newSet;
    });
  };

  return (
    <div className="fixed top-4 left-1/2 -translate-x-1/2 z-50 flex flex-col gap-2 w-full max-w-2xl px-4">
      <AnimatePresence>
        {criticalPatients.map((patient) => (
          <motion.div
            key={`alert-${patient.id}`}
            initial={{ opacity: 0, y: -50, scale: 0.9 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, scale: 0.9, transition: { duration: 0.2 } }}
            className="w-full bg-red-600 text-white rounded-lg shadow-2xl p-4 flex items-center justify-between border-2 border-red-400 border-opacity-50"
          >
            <div className="flex items-center gap-4">
              <motion.div
                animate={{ rotate: [0, -10, 10, -10, 10, 0] }}
                transition={{ repeat: Infinity, duration: 2, ease: "linear" }}
              >
                <AlertTriangle className="h-8 w-8 text-yellow-300" />
              </motion.div>
              <div>
                <h3 className="font-bold text-lg">CODE RED: INBOUND CRITICAL</h3>
                <p className="text-sm text-red-100">
                  {patient.patientName} (ETA: {patient.eta}m) - {patient.aiSummary}
                </p>
              </div>
            </div>
            <button
              onClick={() => dismissAlert(patient.id)}
              className="p-2 hover:bg-red-700 rounded-full transition-colors"
              aria-label="Dismiss Alert"
            >
              <X className="h-5 w-5" />
            </button>
          </motion.div>
        ))}
      </AnimatePresence>
    </div>
  );
}
