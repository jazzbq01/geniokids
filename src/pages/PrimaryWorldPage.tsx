import { useEffect, useState } from 'react';
import { EmptyState } from '../components/EmptyState';
import { SubjectCard } from '../components/SubjectCard';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import { gradeLabels } from '../utils/gradeLabels';
import type { Subject } from '../types/education';
import './PrimaryWorldPage.css';

export function PrimaryWorldPage() {
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
        setSubjects(response.filter((subject) => subject.level === 'primaria'));
      } catch (error) {
        setError(error instanceof Error ? error.message : 'No se pudo cargar la información.');
      } finally {
        setLoading(false);
      }
    }

    loadSubjects();
  }, [activeStudent.grade, hasActiveStudent]);

  if (!hasActiveStudent) return <EmptyState title="Selecciona un hijo" detail="El mundo Primaria se carga únicamente con perfiles reales de Supabase." />;

  return (
    <section className="primary-page page">
      <header className="page-hero primary-hero">
        <div>
          <span className="eyebrow">🚀 Mundo Primaria</span>
          <h1>Primaria completa: 1.º a 6.º grado</h1>
          <p>{activeStudent.name} está en {gradeLabels[activeStudent.grade]}. Aquí trabajamos cálculo, lectura, inglés, ciencia, razonamiento y juegos por grado.</p>
        </div>
        <div className="hero-badge">🚀</div>
      </header>

      <section className="primary-roadmap">
        <article><strong>Practicar</strong><span>Ejercicios por curso</span></article>
        <article><strong>Evaluar</strong><span>Puntaje inmediato</span></article>
        <article><strong>Mejorar</strong><span>Recomendaciones para padres</span></article>
      </section>

      {loading && <p className="muted">Cargando cursos desde Supabase...</p>}
      {error && <p className="muted">{error}</p>}

      <div className="subjects-grid">
        {subjects.map((subject) => <SubjectCard subject={subject} key={subject.id} />)}
      </div>
    </section>
  );
}
