import { useEffect, useMemo, useState } from 'react';
import { ProgressChart } from '../components/ProgressChart';
import { StatCard } from '../components/StatCard';
import { useStudent } from '../context/StudentContext';
import { useAuth } from '../context/AuthContext';
import { EmptyState } from '../components/EmptyState';
import { educationService } from '../services/educationService';
import {
  buildCongratulations,
  buildParentConsiderations,
  buildRecommendations,
  summarizeAttempts
} from '../services/reportService';
import type { Activity, ProgressAttempt, Subject } from '../types/education';
import './ParentDashboardPage.css';

export function ParentDashboardPage() {
  const { activeStudent, hasActiveStudent, refreshSignal } = useStudent();
  const { isChild } = useAuth();
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [activitiesBySubject, setActivitiesBySubject] = useState<Record<string, Activity[]>>({});
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    async function loadDashboardData() {
      if (!hasActiveStudent) {
        setAttempts([]);
        setSubjects([]);
        setActivitiesBySubject({});
        return;
      }

      setLoading(true);
      try {
        const [attemptResponse, subjectResponse] = await Promise.all([
          educationService.getAttempts(activeStudent.id),
          educationService.getSubjectsByGrade(activeStudent.grade)
        ]);

        const activitiesEntries = await Promise.all(
          subjectResponse.map(async (subject) => {
            const activities = await educationService.getActivities(subject.id, activeStudent.grade);
            return [subject.id, activities] as const;
          })
        );

        setAttempts(attemptResponse);
        setSubjects(subjectResponse);
        setActivitiesBySubject(Object.fromEntries(activitiesEntries));
      } finally {
        setLoading(false);
      }
    }

    loadDashboardData();
  }, [activeStudent.id, activeStudent.grade, hasActiveStudent, refreshSignal]);

  const summary = useMemo(() => summarizeAttempts(attempts, subjects), [attempts, subjects]);
  const recommendations = useMemo(() => buildRecommendations(attempts, subjects), [attempts, subjects]);
  const congratulations = useMemo(() => buildCongratulations(attempts, subjects), [attempts, subjects]);
  const considerations = useMemo(
    () => buildParentConsiderations(attempts, subjects, activitiesBySubject),
    [attempts, subjects, activitiesBySubject]
  );
  const totalActivities = useMemo(
    () => Object.values(activitiesBySubject).reduce((sum, activities) => sum + activities.length, 0),
    [activitiesBySubject]
  );

  if (isChild) return <EmptyState title="Acceso solo para padres" detail="Este panel muestra información familiar y reportes detallados. Ingresa con la cuenta del padre o madre." />;
  if (!hasActiveStudent) return <EmptyState title="Selecciona un hijo" detail="Primero crea o selecciona un usuario hijo desde el panel Hijos. Ya no se cargan perfiles demo cuando Supabase está activo." />;

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

      <div className="stats-grid dashboard-stats-grid">
        <StatCard icon="✅" label="Actividades resueltas" value={summary.completed} helper="completadas" />
        <StatCard icon="🧩" label="Actividades disponibles" value={loading ? '...' : totalActivities} helper="por grado" />
        <StatCard icon="⭐" label="Estrellas" value={summary.totalStars} helper="ganadas" />
        <StatCard icon="🎯" label="Promedio" value={`${summary.averageScore}%`} helper="rendimiento" />
      </div>

      <ProgressChart data={summary.bySubject} />

      <section className="parent-insights-layout">
        <section className="recommendations-card parent-insight-card">
          <div className="insight-card-header">
            <span>🧭</span>
            <div>
              <h2>Recomendaciones por curso</h2>
              <p>Acciones concretas para que el padre sepa dónde acompañar.</p>
            </div>
          </div>
          {recommendations.map((item) => (
            <article key={item.title} className={`recommendation recommendation--${item.priority}`}>
              <strong>{item.title}</strong>
              <p>{item.detail}</p>
            </article>
          ))}
        </section>

        <section className="recommendations-card parent-insight-card">
          <div className="insight-card-header">
            <span>🏆</span>
            <div>
              <h2>Felicitaciones</h2>
              <p>Cursos donde conviene reconocer el esfuerzo y mantener motivación.</p>
            </div>
          </div>
          {congratulations.length ? congratulations.map((item) => (
            <article key={item.title} className="recommendation recommendation--baja">
              <strong>{item.title}</strong>
              <p>{item.detail}</p>
            </article>
          )) : (
            <div className="soft-empty-card">
              Aún no hay cursos sobre 75%. Cuando aparezcan, este bloque mostrará los logros para felicitar al estudiante.
            </div>
          )}
        </section>

        <section className="recommendations-card parent-insight-card parent-insight-card--wide">
          <div className="insight-card-header">
            <span>📌</span>
            <div>
              <h2>Consideraciones para padres</h2>
              <p>Lectura ejecutiva del avance: cobertura, equilibrio y regla del 75%.</p>
            </div>
          </div>
          {considerations.map((item) => (
            <article key={item.title} className={`recommendation recommendation--${item.priority}`}>
              <strong>{item.title}</strong>
              <p>{item.detail}</p>
            </article>
          ))}
        </section>
      </section>
    </section>
  );
}
