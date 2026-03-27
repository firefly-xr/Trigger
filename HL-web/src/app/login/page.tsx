"use client";

import { useState } from "react";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "@/lib/firebase";
import { useAuth } from "@/lib/auth-context";
import { HeartPulse, Lock, CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";
import { motion } from "framer-motion";
import { Input } from "@/components/ui/input";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const { mockLogin } = useAuth();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await signInWithEmailAndPassword(auth, email, password);
      toast.success("Login Successful", {
        icon: <CheckCircle2 className="h-5 w-5 text-green-500" />
      });
    } catch (error: any) {
      console.error(error);
      toast.error("Authentication Failed", {
        description: error.message || "Invalid credentials."
      });
    } finally {
      setLoading(false);
    }
  };

  const handleDemoLogin = () => {
    toast.success("Using Demo Account", {
      description: "Bypassing Firebase Auth for Hackathon Demo.",
      icon: <CheckCircle2 className="h-5 w-5 text-green-500" />
    });
    mockLogin();
  };

  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-4 selection:bg-blue-500/30">
      {/* Abstract Background Elements */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-1/4 -right-1/4 w-[800px] h-[800px] bg-blue-600/10 rounded-full blur-[120px]" />
        <div className="absolute -bottom-1/4 -left-1/4 w-[600px] h-[600px] bg-emerald-600/10 rounded-full blur-[100px]" />
      </div>

      <motion.div
        initial={{ opacity: 0, scale: 0.95, y: 10 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        transition={{ duration: 0.4 }}
        className="w-full max-w-md relative z-10"
      >
        <div className="bg-card border border-border shadow-2xl rounded-2xl overflow-hidden backdrop-blur-sm">
          <div className="p-8 pb-6 border-b border-border flex flex-col items-center justify-center text-center bg-muted/30">
            <div className="bg-blue-600 p-4 rounded-2xl shadow-[0_0_20px_rgba(37,99,235,0.4)] mb-4">
              <HeartPulse className="h-8 w-8 text-white" />
            </div>
            <h1 className="text-3xl font-extrabold tracking-tight bg-gradient-to-r from-blue-400 to-emerald-400 bg-clip-text text-transparent">
              <span className="text-red-500 font-extrabold tracking-tighter">TRIGGER</span>
              <span className="text-muted-foreground font-normal text-3xl ml-3 tracking-widest uppercase">Portal</span>
            </h1>
            <p className="text-muted-foreground font-medium mt-2">
              Hospital Dispatcher Portal
            </p>
          </div>

          <form onSubmit={handleLogin} className="p-8 flex flex-col gap-6">
            <div className="flex flex-col gap-4">
              <div className="flex flex-col gap-2">
                <label className="text-sm font-semibold text-foreground">Email Address</label>
                <Input
                  type="email"
                  placeholder="admin@hospital.com"
                  value={email}
                  onChange={(e: React.ChangeEvent<HTMLInputElement>) => setEmail(e.target.value)}
                  className="bg-background border-border"
                  required
                />
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-sm font-semibold text-foreground flex justify-between">
                  Password
                  <span className="text-blue-500 text-xs cursor-pointer hover:underline">Forgot?</span>
                </label>
                <div className="relative">
                  <Input
                    type="password"
                    placeholder="••••••••"
                    value={password}
                    onChange={(e: React.ChangeEvent<HTMLInputElement>) => setPassword(e.target.value)}
                    className="bg-background border-border pl-10"
                    required
                  />
                  <Lock className="w-4 h-4 text-muted-foreground absolute left-3 top-3" />
                </div>
              </div>
            </div>

            <Button
              type="submit"
              className="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold tracking-wide h-12 text-lg"
              disabled={loading}
            >
              {loading ? (
                <div className="h-5 w-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              ) : "Sign In to Dashboard"}
            </Button>

            <div className="relative flex items-center py-2">
              <div className="flex-grow border-t border-border"></div>
              <span className="flex-shrink-0 mx-4 text-muted-foreground text-xs uppercase font-bold tracking-widest">OR</span>
              <div className="flex-grow border-t border-border"></div>
            </div>

            <Button
              type="button"
              variant="outline"
              className="w-full h-12 font-bold border-emerald-500/50 text-emerald-500 hover:bg-emerald-500/10 hover:text-emerald-400 transition-colors"
              onClick={handleDemoLogin}
            >
              Login (Demo)
            </Button>
          </form>
        </div>

        <p className="text-center text-xs text-muted-foreground mt-6 font-medium">
          Secure connection established.HIPAA compliance mode active.
        </p>
      </motion.div>
    </div>
  );
}
