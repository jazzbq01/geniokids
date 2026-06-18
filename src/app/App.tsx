import type { ReactNode } from 'react';
import { Navigate, Route, Routes } from 'react-router-dom';
import { AuthProvider, useAuth } from '../context/AuthContext';
import { AppLayout } from '../layout/AppLayout';
import { LoginPage } from '../pages/LoginPage';
import { StudentSelectorPage } from '../pages/StudentSelectorPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { InitialWorldPage } from '../pages/InitialWorldPage';
import { PrimaryWorldPage } from '../pages/PrimaryWorldPage';
import { SubjectPage } from '../pages/SubjectPage';
import { ActivityPage } from '../pages/ActivityPage';
import { ReportsPage } from '../pages/ReportsPage';
import { RewardsPage } from '../pages/RewardsPage';
import { NotFoundPage } from '../pages/NotFoundPage';

function ProtectedLayout() {
  const { role, loading } = useAuth();
  if (loading) return <div className="loading-screen">Cargando GenioKids...</div>;
  if (role === 'guest') return <Navigate to="/login" replace />;
  return <AppLayout />;
}

function RootRedirect() {
  const { role, childSession } = useAuth();
  if (role === 'child') return <Navigate to={childSession?.student.level === 'inicial' ? '/inicial' : '/primaria'} replace />;
  return <Navigate to="/students" replace />;
}

function ParentOnly({ children }: { children: ReactNode }) {
  const { role, childSession } = useAuth();
  if (role === 'child') {
    return <Navigate to={childSession?.student.level === 'inicial' ? '/inicial' : '/primaria'} replace />;
  }
  return <>{children}</>;
}

function ChildHomeGuard({ children }: { children: ReactNode }) {
  const { role, childSession } = useAuth();
  if (role === 'child' && childSession?.student.level === 'inicial') {
    return <Navigate to="/inicial" replace />;
  }
  return <>{children}</>;
}

function InitialHomeGuard({ children }: { children: ReactNode }) {
  const { role, childSession } = useAuth();
  if (role === 'child' && childSession?.student.level === 'primaria') {
    return <Navigate to="/primaria" replace />;
  }
  return <>{children}</>;
}

export default function App() {
  return (
    <AuthProvider>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route path="/" element={<ProtectedLayout />}>
          <Route index element={<RootRedirect />} />
          <Route path="students" element={<ParentOnly><StudentSelectorPage /></ParentOnly>} />
          <Route path="dashboard" element={<ParentOnly><ParentDashboardPage /></ParentOnly>} />
          <Route path="inicial" element={<InitialHomeGuard><InitialWorldPage /></InitialHomeGuard>} />
          <Route path="primaria" element={<ChildHomeGuard><PrimaryWorldPage /></ChildHomeGuard>} />
          <Route path="subject/:subjectId" element={<SubjectPage />} />
          <Route path="activity/:activityId" element={<ActivityPage />} />
          <Route path="reports" element={<ParentOnly><ReportsPage /></ParentOnly>} />
          <Route path="rewards" element={<RewardsPage />} />
        </Route>
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </AuthProvider>
  );
}
