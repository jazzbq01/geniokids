import { createContext, useContext, useEffect, useMemo, useState } from 'react';
import { isSupabaseConfigured } from '../lib/env';
import { supabase } from '../lib/supabase';
import { educationService } from '../services/educationService';
import type { ChildSession, UserRole } from '../types/education';

type AuthContextValue = {
  role: UserRole;
  childSession: ChildSession | null;
  loading: boolean;
  isParent: boolean;
  isChild: boolean;
  loginParent: (email: string, password: string) => Promise<void>;
  registerParent: (fullName: string, email: string, password: string) => Promise<void>;
  loginChild: (username: string, pin: string) => Promise<void>;
  logout: () => Promise<void>;
};

const CHILD_SESSION_KEY = 'gk_child_session';

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

function clearDemoStudentCache() {
  localStorage.removeItem('geniokids_students');
  localStorage.removeItem('geniokids_active_student');
  localStorage.removeItem('geniokids_attempts');
}

function clearSelectedStudentCache() {
  localStorage.removeItem('gk_active_student_supabase');
}

function loadStoredChildSession(): ChildSession | null {
  try {
    const raw = localStorage.getItem(CHILD_SESSION_KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as ChildSession;
    if (!parsed.expiresAt || new Date(parsed.expiresAt).getTime() <= Date.now()) {
      localStorage.removeItem(CHILD_SESSION_KEY);
      return null;
    }
    return parsed;
  } catch {
    localStorage.removeItem(CHILD_SESSION_KEY);
    return null;
  }
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [role, setRole] = useState<UserRole>('guest');
  const [childSession, setChildSession] = useState<ChildSession | null>(() => loadStoredChildSession());
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let mounted = true;

    async function init() {
      if (childSession) {
        setRole('child');
        setLoading(false);
        return;
      }

      if (!isSupabaseConfigured || !supabase) {
        setRole('parent');
        setLoading(false);
        return;
      }

      const { data } = await supabase.auth.getSession();
      if (!mounted) return;
      setRole(data.session ? 'parent' : 'guest');
      setLoading(false);
    }

    init();

    if (!isSupabaseConfigured || !supabase) return () => { mounted = false; };

    const { data } = supabase.auth.onAuthStateChange((_event, session) => {
      if (localStorage.getItem(CHILD_SESSION_KEY)) return;
      setRole(session ? 'parent' : 'guest');
    });

    return () => {
      mounted = false;
      data.subscription.unsubscribe();
    };
  }, [childSession]);

  const value = useMemo<AuthContextValue>(() => ({
    role,
    childSession,
    loading,
    isParent: role === 'parent',
    isChild: role === 'child',
    async loginParent(email, password) {
      localStorage.removeItem(CHILD_SESSION_KEY);
      clearDemoStudentCache();
      clearSelectedStudentCache();
      setChildSession(null);
      if (!isSupabaseConfigured || !supabase) {
        setRole('parent');
        return;
      }
      const { error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) throw error;
      setRole('parent');
    },
    async registerParent(fullName, email, password) {
      if (!isSupabaseConfigured || !supabase) {
        setRole('parent');
        return;
      }
      const { error } = await supabase.auth.signUp({
        email,
        password,
        options: { data: { full_name: fullName || 'Familia GenioKids' } }
      });
      if (error) throw error;
    },
    async loginChild(username, pin) {
      localStorage.removeItem(CHILD_SESSION_KEY);
      if (!isSupabaseConfigured || !supabase) {
        const demo = username.toLowerCase().includes('sofia')
          ? { id: 'demo-inicial', name: 'Sofía', age: 3, grade: '3-anios' as const, level: 'inicial' as const, avatar: '👧🏻', gender: 'female' as const, childUsername: 'sofia' }
          : { id: 'demo-primaria', name: 'Mateo', age: 8, grade: '3-primaria' as const, level: 'primaria' as const, avatar: '👦🏻', gender: 'male' as const, childUsername: 'mateo' };
        const session: ChildSession = {
          sessionToken: crypto.randomUUID(),
          expiresAt: new Date(Date.now() + 12 * 60 * 60 * 1000).toISOString(),
          student: demo
        };
        localStorage.setItem(CHILD_SESSION_KEY, JSON.stringify(session));
        setChildSession(session);
        setRole('child');
        return;
      }

      const session = await educationService.loginChild(username, pin);
      localStorage.setItem(CHILD_SESSION_KEY, JSON.stringify(session));
      await supabase.auth.signOut();
      setChildSession(session);
      setRole('child');
    },
    async logout() {
      localStorage.removeItem(CHILD_SESSION_KEY);
      clearSelectedStudentCache();
      setChildSession(null);
      if (isSupabaseConfigured && supabase) await supabase.auth.signOut();
      setRole('guest');
    }
  }), [role, childSession, loading]);

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth debe usarse dentro de AuthProvider');
  return context;
}
