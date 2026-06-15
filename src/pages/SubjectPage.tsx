import { Link, useParams } from 'react-router-dom';
import { useEffect, useMemo, useState } from 'react';
import { ActivityCard } from '../components/ActivityCard';
import { EmptyState } from '../components/EmptyState';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import type { Activity, Difficulty, DifficultyLevel, Lesson, ProgressAttempt, Subject } from '../types/education';
import './SubjectPage.css';

const MIN_PASSING_NOTE = 15;
const MIN_PASSING_PERCENT = 75;

function scoreToNote20(score: number) {
  if (score <= 20) return Math.max(0, Math.min(20, Math.round(score)));
  return Math.max(0, Math.min(20, Math.round((score / 100) * 20)));
}

function scoreToPercent(score: number) {
  if (score <= 20) return Math.max(0, Math.min(100, Math.round((score / 20) * 100)));
  return Math.max(0, Math.min(100, Math.round(score)));
}

function levelStats(levelActivities: Activity[], attempts: ProgressAttempt[]) {
  const bestByActivity = new Map<string, ProgressAttempt>();

  attempts.forEach((attempt) => {
    const current = bestByActivity.get(attempt.activityId);
    const currentScore = current ? scoreToPercent(current.score) : -1;
    const incomingScore = scoreToPercent(attempt.score);
    if (!current || incomingScore > currentScore) bestByActivity.set(attempt.activityId, attempt);
  });

  const completed = levelActivities.filter((activity) => bestByActivity.has(activity.id)).length;
  const notes = levelActivities
    .map((activity) => bestByActivity.get(activity.id))
    .filter((attempt): attempt is ProgressAttempt => Boolean(attempt))
    .map((attempt) => scoreToNote20(attempt.score));

  const averageNote = notes.length ? Math.round(notes.reduce((sum, note) => sum + note, 0) / notes.length) : 0;
  const averagePercent = notes.length ? Math.round((averageNote / 20) * 100) : 0;
  const percent = levelActivities.length ? Math.round((completed / levelActivities.length) * 100) : 0;
  const passedByCompletion = completed >= levelActivities.length && levelActivities.length > 0;
  const passedByScore = averageNote >= MIN_PASSING_NOTE && notes.length > 0;

  return {
    completed,
    averageNote,
    averagePercent,
    percent,
    passed: passedByCompletion || passedByScore,
    passedByCompletion,
    passedByScore
  };
}

export function SubjectPage() {
  const { subjectId } = useParams();
  const { activeStudent, refreshSignal } = useStudent();
  const [subject, setSubject] = useState<Subject | undefined>();
  const [lessons, setLessons] = useState<Lesson[]>([]);
  const [activities, setActivities] = useState<Activity[]>([]);
  const [levels, setLevels] = useState<DifficultyLevel[]>([]);
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);
  const [openLevel, setOpenLevel] = useState<Difficulty | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function loadSubjectData() {
      if (!subjectId) return;

      try {
        setLoading(true);
        setError(null);
        const [subjectResponse, lessonsResponse, activitiesResponse, levelResponse, attemptsResponse] = await Promise.all([
          educationService.getSubject(subjectId),
          educationService.getLessons(subjectId, activeStudent.grade),
          educationService.getActivities(subjectId, activeStudent.grade),
          educationService.getDifficultyLevels(),
          educationService.getAttempts(activeStudent.id)
        ]);

        setSubject(subjectResponse);
        setLessons(lessonsResponse);
        setActivities(activitiesResponse);
        setLevels(levelResponse);
        setAttempts(attemptsResponse);
      } catch (error) {
        setError(error instanceof Error ? error.message : 'No se pudo cargar el curso.');
      } finally {
        setLoading(false);
      }
    }

    loadSubjectData();
  }, [subjectId, activeStudent.grade, activeStudent.id, refreshSignal]);

  const completedIds = useMemo(() => new Set(attempts.map((attempt) => attempt.activityId)), [attempts]);

  const levelState = useMemo(() => {
    const state = new Map<Difficulty, { unlocked: boolean; stats: ReturnType<typeof levelStats>; previous?: ReturnType<typeof levelStats> }>();
    let previousStats: ReturnType<typeof levelStats> | undefined;

    levels.forEach((level, index) => {
      const levelActivities = activities.filter((activity) => activity.difficulty === level.id);
      const stats = levelStats(levelActivities, attempts);
      const unlocked = index === 0 || Boolean(previousStats?.passed);
      state.set(level.id, { unlocked, stats, previous: previousStats });
      previousStats = stats;
    });

    return state;
  }, [levels, activities, attempts]);

  if (loading) return <EmptyState title="Cargando curso" detail="Consultando niveles, misiones y progreso desde Supabase..." />;
  if (error) return <EmptyState title="No se pudo cargar" detail={error} />;
  if (!subject) return <EmptyState title="Curso no encontrado" detail="Regresa al mundo educativo y selecciona otro curso." />;

  const totalActivities = activities.length;
  const completedActivities = activities.filter((activity) => completedIds.has(activity.id)).length;
  const totalPoints = activities.reduce((sum, activity) => sum + activity.points, 0);
  const earnedPoints = activities.filter((activity) => completedIds.has(activity.id)).reduce((sum, activity) => sum + activity.points, 0);
  const progressPercent = totalActivities ? Math.round((completedActivities / totalActivities) * 100) : 0;

  return (
    <section className="subject-page page">
      <header className="page-hero subject-hero" style={{ '--subject-color': subject.color } as React.CSSProperties}>
        <div>
          <span className="eyebrow">{subject.icon} Curso gamificado</span>
          <h1>{subject.name}</h1>
          <p>{subject.description}</p>
        </div>
        <div className="hero-badge">{subject.icon}</div>
      </header>

      <section className="subject-progress-panel">
        <div>
          <span className="eyebrow">Ruta bloqueada por mérito</span>
          <h2>{completedActivities}/{totalActivities} misiones completadas</h2>
          <p>Para desbloquear el siguiente nivel: completa el anterior o logra promedio mínimo de {MIN_PASSING_NOTE}/20 ({MIN_PASSING_PERCENT}%).</p>
          <p>Meta del curso: {totalPoints} puntos. Avance actual: {earnedPoints} puntos.</p>
        </div>
        <div className="progress-ring">
          <strong>{progressPercent}%</strong>
          <span>avance</span>
        </div>
      </section>

      <section className="lesson-list">
        <h2>Mapa de niveles</h2>
        {lessons.length ? lessons.map((lesson) => {
          const level = levels.find((item) => item.id === lesson.difficulty);
          const state = level ? levelState.get(level.id) : undefined;
          return (
            <article key={lesson.id} className={`lesson-item ${state?.unlocked ? '' : 'lesson-item--locked'}`} style={{ borderColor: level?.color }}>
              <strong>{state?.unlocked ? '✅' : '🔒'} {level?.icon} {lesson.title}</strong>
              <p>{lesson.description}</p>
            </article>
          );
        }) : <p className="muted">Aún no hay lecciones para este grado.</p>}
      </section>

      <section className="activity-list">
        <div className="activity-list-title">
          <div>
            <h2>Actividades por nivel</h2>
            <p>Todos los niveles inician comprimidos. Abre solo el nivel disponible y avanza a tu ritmo.</p>
          </div>
        </div>

        {levels.map((level) => {
          const levelActivities = activities.filter((activity) => activity.difficulty === level.id);
          const state = levelState.get(level.id);
          if (!levelActivities.length || !state) return null;

          const locked = !state.unlocked;
          const isOpen = !locked && openLevel === level.id;
          const unlockReason = state.stats.passedByCompletion
            ? 'Nivel superado por completar todas las misiones.'
            : state.stats.passedByScore
              ? `Nivel superado por nota mínima: ${state.stats.averageNote}/20.`
              : locked
                ? 'Bloqueado hasta superar el nivel anterior.'
                : 'En progreso. Puedes practicar misión por misión.';

          return (
            <article className={`level-section ${locked ? 'level-section--locked' : ''}`} key={level.id} style={{ '--level-color': level.color } as React.CSSProperties}>
              <button
                className="level-section__header level-accordion-button"
                type="button"
                disabled={locked}
                aria-expanded={isOpen}
                onClick={() => setOpenLevel(isOpen ? null : level.id)}
              >
                <div className="level-icon">{locked ? '🔒' : level.icon}</div>
                <div>
                  <span className="eyebrow">{level.stageLabel} · {level.shortName}</span>
                  <h3>{level.name}</h3>
                  <p>{locked ? `Necesita aprobar el nivel anterior con ${MIN_PASSING_NOTE}/20 o completarlo al 100%.` : level.description}</p>
                </div>
                <div className="level-progress">
                  <strong>{state.stats.completed}/{levelActivities.length}</strong>
                  <span>{state.stats.percent}% · Nota {state.stats.averageNote}/20</span>
                  <small>{state.stats.passed ? 'Nivel superado ✅' : locked ? 'Por desbloquear' : 'En progreso'}</small>
                </div>
                <span className="accordion-caret">{locked ? '🔒' : isOpen ? '▲' : '▼'}</span>
              </button>
              <div className="level-bar"><span style={{ width: `${state.stats.percent}%` }} /></div>
              <p className="level-unlock-note">{unlockReason}</p>

              {isOpen && (
                <div className="activity-grid level-accordion-content">
                  {levelActivities.map((activity) => (
                    <ActivityCard
                      key={activity.id}
                      activity={activity}
                      difficultyLevel={level}
                      completed={completedIds.has(activity.id)}
                      locked={locked}
                    />
                  ))}
                </div>
              )}
            </article>
          );
        })}

        {!activities.length && <EmptyState title="Sin actividades todavía" detail="Este módulo está preparado para agregar contenido nuevo desde Supabase." />}
      </section>

      <Link className="secondary-button" to={subject.level === 'inicial' ? '/inicial' : '/primaria'}>← Volver</Link>
    </section>
  );
}
