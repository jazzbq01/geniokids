import { useEffect, useState } from 'react';
import { ProgressChart } from '../components/ProgressChart';
import { StatCard } from '../components/StatCard';
import { useStudent } from '../context/StudentContext';
import { useAuth } from '../context/AuthContext';
import { EmptyState } from '../components/EmptyState';
import { educationService } from '../services/educationService';
import { buildRecommendations, summarizeAttempts } from '../services/reportService';
import type { ProgressAttempt } from '../types/education';
import './ParentDashboardPage.css';

export function ParentDashboardPage() {
  const { activeStudent, hasActiveStudent, refreshSignal } = useStudent();
  const { isChild } = useAuth();
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);

  useEffect(() => {
    if (!hasActiveStudent) {
      setAttempts([]);
      return;
    }
    educationService.getAttempts(activeStudent.id).then(setAttempts);
  }, [activeStudent.id, hasActiveStudent, refreshSignal]);

  if (isChild) return <EmptyState title="Acceso solo para padres" detail="Este panel muestra información familiar y reportes detallados. Ingresa con la cuenta del padre o madre." />;
  if (!hasActiveStudent) return <EmptyState title="Selecciona un hijo" detail="Primero crea o selecciona un usuario hijo desde el panel Hijos. Ya no se cargan perfiles demo cuando Supabase está activo." />;

  const summary = summarizeAttempts(attempts);
  const recommendations = buildRecommendations(attempts);

  return (
    <section className="dashboard-page page">
      <header className="page-hero dashboard-hero">
        <div>
          <span className="eyebrow">Control de avance</span>
          <h1>Hola, familia de {activeStudent.name}</h1>
          <p>Monitorea progreso, estrellas, actividades completadas y recomendaciones educativas.</p>
        </div>
        <div className="hero-badge">📊</div>
      </header>

      <div className="stats-grid">
        <StatCard icon="✅" label="Actividades" value={summary.completed} helper="completadas" />
        <StatCard icon="⭐" label="Estrellas" value={summary.totalStars} helper="ganadas" />
        <StatCard icon="🎯" label="Promedio" value={`${summary.averageScore}%`} helper="rendimiento" />
      </div>

      <div className="dashboard-grid">
        <ProgressChart data={summary.bySubject} />
        <section className="recommendations-card">
          <h2>Recomendaciones</h2>
          {recommendations.map((item) => (
            <article key={item.title} className={`recommendation recommendation--${item.priority}`}>
              <strong>{item.title}</strong>
              <p>{item.detail}</p>
            </article>
          ))}
        </section>
      </div>
    </section>
  );
}
