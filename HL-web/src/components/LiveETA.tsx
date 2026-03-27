"use client";

import { useEffect, useState } from "react";

export function LiveETA({ initialETA }: { initialETA: number }) {
  // initialETA is in minutes, convert to milliseconds
  const [msLeft, setMsLeft] = useState(initialETA * 60 * 1000);

  useEffect(() => {
    // If it's 0 (like for arrived or hospital-stationed patients), keep it at 0
    if (initialETA === 0) {
      setMsLeft(0);
      return;
    }

    const interval = setInterval(() => {
      setMsLeft((prev) => Math.max(0, prev - 37)); // 37ms tick rate gives it that fast cinematic refresh look
    }, 37);

    return () => clearInterval(interval);
  }, [initialETA]);

  const mins = Math.floor(msLeft / 60000);
  const secs = Math.floor((msLeft % 60000) / 1000);


  return (
    <span className="font-mono tabular-nums tracking-tighter">
      {mins.toString().padStart(2, '0')}:
      {secs.toString().padStart(2, '0')}

    </span>
  );
}
