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
          <h1>Aprender jugando, tocando y descubriendo</h1>
          <p>{activeStudent.name} está en {gradeLabels[activeStudent.grade]}. Aquí todo es visual, simple y con retos cortos.</p>
        </div>
        <div className="hero-badge">🧸</div>
      </header>

      <section className="initial-mission">
        <article><strong>1</strong><span>Mirar</span></article>
        <article><strong>2</strong><span>Tocar</span></article>
        <article><strong>3</strong><span>Celebrar</span></article>
      </section>

      {loading && <p className="muted">Cargando cursos desde Supabase...</p>}
      {error && <p className="muted">{error}</p>}

      <div className="subjects-grid">
        {subjects.map((subject) => <SubjectCard subject={subject} key={subject.id} />)}
      </div>
    </section>
  );
}
