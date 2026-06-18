import { createContext, useContext, useEffect, useMemo, useState } from 'react';
import { isSupabaseConfigured } from '../lib/env';
import { localStore } from '../services/localStore';
import { useAuth } from './AuthContext';
import type { Student } from '../types/education';

export const EMPTY_STUDENT: Student = {
  id: '__no_student__',
  name: 'Selecciona un hijo',
  age: 0,
  grade: '3-anios',
  level: 'inicial',
  avatar: '👨‍👩‍👧‍👦',
  gender: 'other',
  childUsername: undefined
};

type StudentContextValue = {
  activeStudent: Student;
  hasActiveStudent: boolean;
  setActiveStudent: (student: Student) => void;
  clearActiveStudent: () => void;
  refreshSignal: number;
  refresh: () => void;
};

const StudentContext = createContext<StudentContextValue | undefined>(undefined);

const ACTIVE_STUDENT_KEY = 'gk_active_student_supabase';

function loadStoredActiveStudent(): Student | null {
  if (!isSupabaseConfigured) return null;
  try {
    const raw = localStorage.getItem(ACTIVE_STUDENT_KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as Student;
    if (!parsed?.id || parsed.id.startsWith('demo-') || parsed.id === EMPTY_STUDENT.id) {
      localStorage.removeItem(ACTIVE_STUDENT_KEY);
      return null;
    }
    return parsed;
  } catch {
    localStorage.removeItem(ACTIVE_STUDENT_KEY);
    return null;
  }
}

function persistActiveStudent(student: Student) {
  if (!isSupabaseConfigured) return;
  if (student.id === EMPTY_STUDENT.id || student.id.startsWith('demo-')) {
    localStorage.removeItem(ACTIVE_STUDENT_KEY);
    return;
  }
  localStorage.setItem(ACTIVE_STUDENT_KEY, JSON.stringify(student));
}

function clearStoredActiveStudent() {
  if (isSupabaseConfigured) localStorage.removeItem(ACTIVE_STUDENT_KEY);
}

function getInitialStudent(childSessionStudent?: Student): Student {
  if (childSessionStudent) return childSessionStudent;
  if (!isSupabaseConfigured) return localStore.getActiveStudent();
  return loadStoredActiveStudent() ?? EMPTY_STUDENT;
}

export function StudentProvider({ children }: { children: React.ReactNode }) {
  const { isChild, childSession } = useAuth();
  const [activeStudent, setActiveStudentState] = useState<Student>(() => getInitialStudent(childSession?.student));
  const [refreshSignal, setRefreshSignal] = useState(0);

  useEffect(() => {
    if (!isSupabaseConfigured) localStore.seed();
  }, []);

  useEffect(() => {
    if (isChild && childSession?.student) {
      setActiveStudentState(childSession.student);
      if (!isSupabaseConfigured) localStore.setActiveStudent(childSession.student);
      return;
    }

    if (!isChild && isSupabaseConfigured) {
      setActiveStudentState((current) => {
        if (current.id.startsWith('demo-')) {
          clearStoredActiveStudent();
          return EMPTY_STUDENT;
        }
        return current;
      });
    }
  }, [isChild, childSession]);

  const value = useMemo<StudentContextValue>(() => ({
    activeStudent,
    hasActiveStudent: activeStudent.id !== EMPTY_STUDENT.id,
    setActiveStudent(student) {
      if (isChild) return;
      if (!isSupabaseConfigured) localStore.setActiveStudent(student);
      persistActiveStudent(student);
      setActiveStudentState(student);
    },
    clearActiveStudent() {
      clearStoredActiveStudent();
      setActiveStudentState(EMPTY_STUDENT);
    },
    refreshSignal,
    refresh() {
      setRefreshSignal((value) => value + 1);
    }
  }), [activeStudent, refreshSignal, isChild]);

  return <StudentContext.Provider value={value}>{children}</StudentContext.Provider>;
}

export function useStudent() {
  const context = useContext(StudentContext);
  if (!context) throw new Error('useStudent debe usarse dentro de StudentProvider');
  return context;
}
