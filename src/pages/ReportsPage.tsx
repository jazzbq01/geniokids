import { useEffect, useMemo, useState } from 'react';
import { ProgressChart } from '../components/ProgressChart';
import { StatCard } from '../components/StatCard';
import { useStudent } from '../context/StudentContext';
import { useAuth } from '../context/AuthContext';
import { EmptyState } from '../components/EmptyState';
import { educationService } from '../services/educationService';
import { buildRecommendations, summarizeAttempts } from '../services/reportService';
import type { Activity, DifficultyLevel, ProgressAttempt, Subject } from '../types/education';
import { downloadExcelReport } from '../utils/excelReport';
import './ReportsPage.css';

export function ReportsPage() {
  const { activeStudent, hasActiveStudent, refreshSignal } = useStudent();
  const { isChild } = useAuth();
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [levels, setLevels] = useState<DifficultyLevel[]>([]);
  const [activitiesBySubject, setActivitiesBySubject] = useState<Record<string, Activity[]>>({});
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    async function loadReportData() {
      if (!hasActiveStudent) {
        setAttempts([]);
        setSubjects([]);
        setLevels([]);
        setActivitiesBySubject({});
        return;
      }

      setLoading(true);
      try {
        const [attemptResponse, subjectResponse, levelResponse] = await Promise.all([
          educationService.getAttempts(activeStudent.id),
          educationService.getSubjectsByGrade(activeStudent.grade),
          educationService.getDifficultyLevels()
        ]);

        const activitiesEntries = await Promise.all(
          subjectResponse.map(async (subject) => {
            const activities = await educationService.getActivities(subject.id, activeStudent.grade);
            return [subject.id, activities] as const;
          })
        );

        setAttempts(attemptResponse);
        setSubjects(subjectResponse);
        setLevels(levelResponse);
        setActivitiesBySubject(Object.fromEntries(activitiesEntries));
      } finally {
        setLoading(false);
      }
    }

    loadReportData();
  }, [activeStudent.id, activeStudent.grade, hasActiveStudent, refreshSignal]);

  const summary = useMemo(() => summarizeAttempts(attempts, subjects), [attempts, subjects]);
  const recommendations = useMemo(() => buildRecommendations(attempts, subjects), [attempts, subjects]);

  if (isChild) return <EmptyState title="Reporte reservado para padres" detail="El usuario hijo solo puede practicar y ver sus medallas. Los reportes completos son para el padre o madre." />;
  if (!hasActiveStudent) return <EmptyState title="Selecciona un hijo" detail="Primero crea o selecciona un usuario hijo para ver sus reportes reales desde Supabase." />;

  function exportExcelReport() {
    downloadExcelReport({
      student: activeStudent,
      subjects,
      activitiesBySubject,
      attempts,
      levels
    });
  }

  const totalActivities = Object.values(activitiesBySubject).reduce((sum, activities) => sum + activities.length, 0);

  return (
    <section className="reports-page page">
      <header className="page-hero reports-hero">
        <div>
          <span className="eyebrow">Reportería</span>
          <h1>Reporte educativo de {activeStudent.name}</h1>
          <p>Reporte claro para padres: una hoja resumen y una hoja por curso con niveles, actividades, nota y recomendación.</p>
        </div>
        <button className="primary-button" onClick={exportExcelReport} disabled={loading || !subjects.length}>
          {loading ? 'Preparando...' : 'Descargar Excel'}
        </button>
      </header>

      <div className="report-export-note">
        <strong>Nuevo formato:</strong> el archivo Excel incluye una hoja de resumen y hojas separadas por curso. Cada hoja muestra el nivel actual, actividades resueltas, pendientes, nota sobre 20 y si requiere refuerzo.
      </div>

      <div className="stats-grid">
        <StatCard icon="📘" label="Actividades resueltas" value={summary.completed} />
        <StatCard icon="🧩" label="Actividades disponibles" value={totalActivities} />
        <StatCard icon="⭐" label="Estrellas" value={summary.totalStars} />
        <StatCard icon="📈" label="Promedio" value={`${summary.averageScore}%`} />
      </div>

      <ProgressChart data={summary.bySubject} />

      <section className="report-table-card">
        <h2>Historial visible en pantalla</h2>
        <p className="muted">El Excel descargado contiene el detalle completo por curso y por nivel.</p>
        <div className="responsive-table">
          <table>
            <thead>
              <tr>
                <th>Fecha</th>
                <th>Curso</th>
                <th>Nivel</th>
                <th>Actividad</th>
                <th>Nota</th>
                <th>Estrellas</th>
              </tr>
            </thead>
            <tbody>
              {attempts.map((attempt) => {
                const subject = subjects.find((item) => item.id === attempt.subjectId);
                const level = levels.find((item) => item.id === attempt.difficulty);
                return (
                  <tr key={attempt.id}>
                    <td>{new Date(attempt.completedAt).toLocaleDateString('es-PE')}</td>
                    <td>{subject?.name ?? attempt.subjectId}</td>
                    <td>{level ? `${level.icon} ${level.name}` : attempt.difficulty}</td>
                    <td>{attempt.activityId}</td>
                    <td>{attempt.score <= 20 ? `${attempt.score}/20` : `${attempt.score}%`}</td>
                    <td>{'⭐'.repeat(attempt.stars)}</td>
                  </tr>
                );
              })}
              {!attempts.length && (
                <tr>
                  <td colSpan={6}>Aún no hay actividades completadas. Igual puedes descargar el Excel para ver las actividades pendientes por curso.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>

      <section className="parent-insights">
        <h2>Insights para padres</h2>
        {recommendations.map((item) => (
          <article key={item.title} className={`recommendation recommendation--${item.priority}`}>
            <strong>{item.title}</strong>
            <p>{item.detail}</p>
          </article>
        ))}
      </section>
    </section>
  );
}
