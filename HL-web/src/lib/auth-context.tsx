"use client";

import React, { createContext, useContext, useEffect, useState } from "react";
import { onAuthStateChanged, User, signOut as firebaseSignOut } from "firebase/auth";
import { auth } from "@/lib/firebase";
import { useRouter, usePathname } from "next/navigation";

interface AuthContextType {
  user: User | null;
  loading: boolean;
  logout: () => Promise<void>;
  mockLogin: () => void;
}

const AuthContext = createContext<AuthContextType>({
  user: null,
  loading: true,
  logout: async () => {},
  mockLogin: () => {}
});

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    // We check local storage first to see if a demo login was used.
    const checkAuthStatus = () => {
      const isMock = localStorage.getItem("mock_hospital_login");
      
      const unsubscribe = onAuthStateChanged(auth, (firebaseUser) => {
        if (firebaseUser) {
          setUser(firebaseUser);
          setLoading(false);
        } else if (isMock === "true") {
          setUser({ email: "admin@hospital.local", uid: "demo-user" } as User);
          setLoading(false);
        } else {
          setUser(null);
          setLoading(false);
        }
      });
      return unsubscribe;
    };

    const unsub = checkAuthStatus();
    return () => unsub();
  }, []);

  useEffect(() => {
    if (!loading) {
      if (!user && pathname !== "/login") {
        router.push("/login");
      } else if (user && pathname === "/login") {
        router.push("/");
      }
    }
  }, [user, loading, pathname, router]);

  const logout = async () => {
    localStorage.removeItem("mock_hospital_login");
    await firebaseSignOut(auth).catch(() => {});
    setUser(null);
    router.push("/login");
  };

  const mockLogin = () => {
    localStorage.setItem("mock_hospital_login", "true");
    setUser({ email: "admin@hospital.local", uid: "demo-user" } as User);
    router.push("/");
  };

  return (
    <AuthContext.Provider value={{ user, loading, logout, mockLogin }}>
      {!loading ? children : (
        <div className="min-h-screen bg-background flex flex-col items-center justify-center">
          <div className="h-12 w-12 border-4 border-blue-600 border-t-transparent rounded-full animate-spin"></div>
        </div>
      )}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
