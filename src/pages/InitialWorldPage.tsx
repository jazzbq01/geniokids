import { useEffect, useState } from 'react';
import { EmptyState } from '../components/EmptyState';
import { SubjectCard } from '../components/SubjectCard';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import { gradeLabels } from '../utils/gradeLabels';
import type { Subject } from '../types/education';
import './InitialWorldPage.css';

export function InitialWorldPage() {
  const { activeStudent, hasActiveStudent } = useStudent();
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!hasActiveStudent) {
      setSubjects([]);
      setLoading(false);
      return;
    }

    async function loadSubjects() {
      try {
        setLoading(true);
        setError(null);
        const response = await educationService.getSubjectsByGrade(activeStudent.grade);
        setSubjects(response.filter((subject) => subject.level === 'inicial'));
      } catch (error) {
        setError(error instanceof Error ? error.message : 'No se pudo cargar la información.');
      } finally {
        setLoading(false);
      }
    }

    loadSubjects();
  }, [activeStudent.grade, hasActiveStudent]);

  if (!hasActiveStudent) return <EmptyState title="Selecciona un hijo" detail="El mundo Inicial se carga únicamente con perfiles reales de Supabase." />;

  return (
    <section className="initial-page page">
      <header className="page-hero initial-hero">
        <div>
          <span className="eyebrow">🌈 Mundo Inicial</span>
          <h1>Inicial 3, 4 y 5 años con rutas gamificadas</h1>
          <p>{activeStudent.name} está en {gradeLabels[activeStudent.grade]}. Aquí trabajamos con misiones visuales, niveles por acordeón, avance progresivo y medallas por edad.</p>
        </div>
        <div className="hero-badge">🧸</div>
      </header>

      <section className="initial-mission">
        <article><strong>Practicar</strong><span>Misiones por área</span></article>
        <article><strong>Evaluar</strong><span>Nota inmediata</span></article>
        <article><strong>Ganar</strong><span>Medallas por edad</span></article>
      </section>

      {loading && <p className="muted">Cargando cursos desde Supabase...</p>}
      {error && <p className="muted">{error}</p>}

      <div className="subjects-grid">
        {subjects.map((subject) => <SubjectCard subject={subject} key={subject.id} />)}
      </div>
    </section>
  );
}
