import { Link, useParams } from 'react-router-dom';
import { useEffect, useMemo, useState, type CSSProperties } from 'react';
import { ActivityCard } from '../components/ActivityCard';
import { EmptyState } from '../components/EmptyState';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import type { Activity, Difficulty, DifficultyLevel, Lesson, ProgressAttempt, Subject } from '../types/education';
import './SubjectPage.css';

const MIN_PREVIOUS_LEVEL_PERCENT = 75;

function getCompletedIds(attempts: ProgressAttempt[]) {
  return new Set(attempts.map((attempt) => attempt.activityId));
}

function sortActivitiesByOrder(items: Activity[]) {
  return items.slice().sort((a, b) => a.order - b.order || a.title.localeCompare(b.title));
}

function getNextPendingActivity(levelActivities: Activity[], completedIds: Set<string>) {
  return sortActivitiesByOrder(levelActivities).find((activity) => !completedIds.has(activity.id));
}

function levelStats(levelActivities: Activity[], attempts: ProgressAttempt[]) {
  const completedIds = getCompletedIds(attempts);
  const completed = levelActivities.filter((activity) => completedIds.has(activity.id)).length;
  const total = levelActivities.length;
  const percent = total ? Math.round((completed / total) * 100) : 0;
  const requiredCompleted = total ? Math.ceil((total * MIN_PREVIOUS_LEVEL_PERCENT) / 100) : 0;
  const passedByCompletion = completed >= total && total > 0;
  const passedByRequiredCompletion = requiredCompleted > 0 && completed >= requiredCompleted;

  return {
    completed,
    total,
    requiredCompleted,
    percent,
    passed: passedByRequiredCompletion,
    passedByCompletion,
    passedByRequiredCompletion
  };
}

function missionLabel(activity?: Activity) {
  if (!activity) return 'misión pendiente';
  return `Misión ${String(activity.order).padStart(2, '0')}`;
}

export function SubjectPage() {
  const { subjectId } = useParams();
  const { activeStudent, refreshSignal } = useStudent();
  const [subject, setSubject] = useState<Subject | undefined>();
  const [lessons, setLessons] = useState<Lesson[]>([]);
  const [activities, setActivities] = useState<Activity[]>([]);
  const [levels, setLevels] = useState<DifficultyLevel[]>([]);
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);
  const [failedIds, setFailedIds] = useState<Set<string>>(new Set());
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
        setFailedIds(new Set(educationService.getFailedActivityIds(activeStudent.id)));
      } catch (error) {
        setError(error instanceof Error ? error.message : 'No se pudo cargar el curso.');
      } finally {
        setLoading(false);
      }
    }

    loadSubjectData();
  }, [subjectId, activeStudent.grade, activeStudent.id, refreshSignal]);

  const completedIds = useMemo(() => getCompletedIds(attempts), [attempts]);

  const levelState = useMemo(() => {
    const state = new Map<Difficulty, {
      unlocked: boolean;
      stats: ReturnType<typeof levelStats>;
      previous?: ReturnType<typeof levelStats>;
      nextPending?: Activity;
    }>();
    let previousStats: ReturnType<typeof levelStats> | undefined;

    levels.forEach((level, index) => {
      const levelActivities = activities.filter((activity) => activity.difficulty === level.id);
      const stats = levelStats(levelActivities, attempts);
      const nextPending = getNextPendingActivity(levelActivities, completedIds);
      const unlocked = index === 0 || Boolean(previousStats?.passed);
      state.set(level.id, { unlocked, stats, previous: previousStats, nextPending });
      previousStats = stats;
    });

    return state;
  }, [levels, activities, attempts, completedIds]);

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
      <header className="page-hero subject-hero" style={{ '--subject-color': subject.color } as CSSProperties}>
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
          <p>La ruta ahora es lineal: solo se habilita la siguiente misión pendiente. Para abrir un nivel superior se necesita completar al menos el {MIN_PREVIOUS_LEVEL_PERCENT}% del nivel anterior.</p>
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
            <p>Solo la siguiente misión pendiente queda habilitada. Las futuras se abren una por una.</p>
          </div>
        </div>

        {levels.map((level) => {
          const levelActivities = sortActivitiesByOrder(activities.filter((activity) => activity.difficulty === level.id));
          const state = levelState.get(level.id);
          if (!levelActivities.length || !state) return null;

          const locked = !state.unlocked;
          const isOpen = !locked && openLevel === level.id;
          const previous = state.previous;
          const nextPending = state.nextPending;
          const unlockReason = state.stats.passedByCompletion
            ? 'Nivel completado al 100%.'
            : state.stats.passedByRequiredCompletion
              ? `75% cumplido: completó ${state.stats.completed}/${state.stats.total} misiones. El siguiente nivel ya puede abrirse, pero esta ruta sigue avanzando de una misión en una.`
              : locked && previous
                ? `Bloqueado: el nivel anterior tiene ${previous.completed}/${previous.total} misiones (${previous.percent}%). Necesita ${previous.requiredCompleted} misiones como mínimo.`
                : nextPending
                  ? `Siguiente disponible: ${missionLabel(nextPending)}. Las demás se desbloquean después.`
                  : 'En progreso. Completa al menos el 75% para habilitar el siguiente nivel.';

          return (
            <article className={`level-section ${locked ? 'level-section--locked' : ''}`} key={level.id} style={{ '--level-color': level.color } as CSSProperties}>
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
                  <p>{locked ? `Necesita completar al menos el ${MIN_PREVIOUS_LEVEL_PERCENT}% del nivel anterior.` : level.description}</p>
                </div>
                <div className="level-progress">
                  <strong>{state.stats.completed}/{levelActivities.length}</strong>
                  <span>Meta {state.stats.requiredCompleted}/{levelActivities.length} · {state.stats.percent}%</span>
                  <small>{state.stats.passed ? '75% cumplido ✅' : locked ? 'Por desbloquear' : `Sigue: ${missionLabel(nextPending)}`}</small>
                </div>
                <span className="accordion-caret">{locked ? '🔒' : isOpen ? '▲' : '▼'}</span>
              </button>
              <div className="level-bar"><span style={{ width: `${state.stats.percent}%` }} /></div>
              <p className="level-unlock-note">{unlockReason}</p>

              {isOpen && (
                <div className="activity-grid level-accordion-content">
                  {levelActivities.map((activity) => {
                    const completed = completedIds.has(activity.id);
                    const isCurrent = !completed && nextPending?.id === activity.id;
                    const failed = isCurrent && failedIds.has(activity.id);
                    const activityLocked = !completed && !isCurrent;
                    const lockedReason = locked
                      ? `Bloqueada: completa al menos el ${MIN_PREVIOUS_LEVEL_PERCENT}% del nivel anterior.`
                      : `Bloqueada: primero completa ${missionLabel(nextPending)}.`;

                    return (
                      <ActivityCard
                        key={activity.id}
                        activity={activity}
                        difficultyLevel={level}
                        completed={completed}
                        failed={failed}
                        current={isCurrent}
                        locked={activityLocked || locked}
                        lockedReason={lockedReason}
                      />
                    );
                  })}
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
