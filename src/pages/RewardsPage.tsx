import { useEffect, useMemo, useState } from 'react';
import type { CSSProperties } from 'react';
import { Link } from 'react-router-dom';
import { EmptyState } from '../components/EmptyState';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import type { Badge, Grade, ProgressAttempt } from '../types/education';
import { isAttemptPassed, scoreToPercent } from '../utils/progress';
import './RewardsPage.css';



const gradeBadgeMarkers: Record<Grade, string[]> = {
  '3-anios': ['3i', 'inicial-3', '3-anios', 'inicial 3'],
  '4-anios': ['4i', 'inicial-4', '4-anios', 'inicial 4'],
  '5-anios': ['5i', 'inicial-5', '5-anios', 'inicial 5'],
  '1-primaria': ['1p', 'math1', 'primaria-1', '1-primaria'],
  '2-primaria': ['2p', 'math2', 'primaria-2', '2-primaria'],
  '3-primaria': ['3p', 'math3', 'primaria-3', '3-primaria'],
  '4-primaria': ['4p', 'math4', 'primaria-4', '4-primaria'],
  '5-primaria': ['5p', 'math5', 'primaria-5', '5-primaria'],
  '6-primaria': ['6p', 'math6', 'primaria-6', '6-primaria']
};

const initialGradePrefix: Partial<Record<Grade, '3i' | '4i' | '5i'>> = {
  '3-anios': '3i',
  '4-anios': '4i',
  '5-anios': '5i'
};

const initialSubjectsByBadgeCode: Record<string, string> = {
  mat: 'mat-inicial',
  com: 'com-inicial',
  ps: 'personal-social-inicial',
  psi: 'psicomotriz-inicial',
  cyt: 'ciencia-tecnologia-inicial',
  art: 'arte-creatividad-inicial'
};

const initialLevelCodes = ['semilla', 'explorador', 'aventurero', 'estrella', 'maestro'] as const;

function detectBadgeGrade(badge: Badge): Grade | null {
  const id = badge.id.toLowerCase();
  for (const [grade, markers] of Object.entries(gradeBadgeMarkers) as [Grade, string[]][]) {
    if (markers.some((marker) => id.includes(marker))) return grade;
  }
  return null;
}

function badgeBelongsToStudentGrade(badge: Badge, grade: Grade) {
  const badgeGrade = detectBadgeGrade(badge);
  if (!badgeGrade) return true;
  return badgeGrade === grade;
}

function averagePercent(attempts: ProgressAttempt[]) {
  if (!attempts.length) return 0;
  return Math.round(attempts.reduce((sum, attempt) => sum + scoreToPercent(attempt.score), 0) / attempts.length);
}

function addInitialBadges(unlocked: Set<string>, attempts: ProgressAttempt[], grade: Grade) {
  const gradePrefix = initialGradePrefix[grade];
  if (!gradePrefix) return;

  Object.entries(initialSubjectsByBadgeCode).forEach(([badgeCode, subjectId]) => {
    const subjectAttempts = attempts.filter((attempt) => attempt.subjectId === subjectId);
    if (!subjectAttempts.length) return;

    unlocked.add(`badge-${gradePrefix}-${badgeCode}-avance`);
    if (subjectAttempts.length >= 250) unlocked.add(`badge-${gradePrefix}-${badgeCode}-completo`);

    initialLevelCodes.forEach((levelCode) => {
      const levelAttempts = subjectAttempts.filter((attempt) => attempt.difficulty === levelCode);
      const levelPassed = levelAttempts.length >= 38; // 75% de los niveles iniciales de 50 misiones
      if (levelPassed) unlocked.add(`badge-${gradePrefix}-${badgeCode}-${levelCode}`);
    });
  });
}

function computeUnlocked(attempts: ProgressAttempt[], grade: Grade) {
  const passedAttempts = attempts.filter(isAttemptPassed);
  const unlocked = new Set<string>();
  const totalStars = passedAttempts.reduce((sum, attempt) => sum + attempt.stars, 0);

  if (passedAttempts.length >= 1) unlocked.add('badge-first-mission');
  if (passedAttempts.length >= 10) unlocked.add('badge-10-missions');
  if (passedAttempts.length >= 20) unlocked.add('badge-20-level');
  if (passedAttempts.length >= 50) {
    unlocked.add('badge-50-missions');
    unlocked.add('badge-50-level');
  }
  if (passedAttempts.filter((attempt) => attempt.subjectId === 'mat-primaria').length >= 100) unlocked.add('badge-100-math1');
  if (passedAttempts.filter((attempt) => attempt.subjectId === 'mat-primaria').length >= 250) unlocked.add('badge-250-math1');
  if (passedAttempts.some((attempt) => scoreToPercent(attempt.score) >= 100)) unlocked.add('badge-perfect-score');
  if (totalStars >= 30) unlocked.add('badge-star-collector');
  if (passedAttempts.some((attempt) => attempt.subjectId.includes('mat') && scoreToPercent(attempt.score) >= 80)) unlocked.add('badge-math-genius');
  if (passedAttempts.some((attempt) => attempt.subjectId.includes('com'))) unlocked.add('badge-reader');
  if (passedAttempts.some((attempt) => attempt.subjectId.includes('eng'))) unlocked.add('badge-english');
  if (passedAttempts.some((attempt) => attempt.subjectId.includes('sci') || attempt.subjectId.includes('ciencia'))) unlocked.add('badge-science');
  if (passedAttempts.some((attempt) => attempt.difficulty === 'semilla')) unlocked.add('badge-semilla');
  if (passedAttempts.some((attempt) => attempt.difficulty === 'explorador')) unlocked.add('badge-explorador');
  if (passedAttempts.some((attempt) => attempt.difficulty === 'aventurero')) unlocked.add('badge-aventurero');
  if (passedAttempts.some((attempt) => attempt.difficulty === 'estrella')) unlocked.add('badge-estrella');
  if (passedAttempts.some((attempt) => attempt.difficulty === 'maestro')) unlocked.add('badge-master-genius');

  addInitialBadges(unlocked, passedAttempts, grade);
  return unlocked;
}

export function RewardsPage() {
  const { activeStudent, hasActiveStudent, refreshSignal } = useStudent();
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);
  const [badges, setBadges] = useState<Badge[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!hasActiveStudent) {
      setAttempts([]);
      setBadges([]);
      setLoading(false);
      return;
    }

    async function loadRewards() {
      try {
        setLoading(true);
        setError(null);
        const [attemptResponse, badgeResponse] = await Promise.all([
          educationService.getAttempts(activeStudent.id),
          educationService.getBadges()
        ]);
        setAttempts(attemptResponse);
        setBadges(badgeResponse);
      } catch (error) {
        setError(error instanceof Error ? error.message : 'No se pudieron cargar las medallas.');
      } finally {
        setLoading(false);
      }
    }

    loadRewards();
  }, [activeStudent.id, hasActiveStudent, refreshSignal]);

  const visibleBadges = useMemo(
    () => badges.filter((badge) => badgeBelongsToStudentGrade(badge, activeStudent.grade)),
    [badges, activeStudent.grade]
  );
  const passedAttempts = useMemo(() => attempts.filter(isAttemptPassed), [attempts]);
  const unlocked = useMemo(() => computeUnlocked(attempts, activeStudent.grade), [attempts, activeStudent.grade]);
  const unlockedCount = visibleBadges.filter((badge) => unlocked.has(badge.id)).length;
  const homePath = activeStudent.level === 'inicial' ? '/inicial' : '/primaria';

  if (!hasActiveStudent) return <EmptyState title="Selecciona un hijo" detail="Primero selecciona un usuario hijo para ver sus medallas reales desde Supabase." />;

  if (loading) return <EmptyState title="Cargando medallas" detail="Consultando logros y estrellas desde Supabase..." />;

  if (error) {
    return (
      <section className="rewards-page page">
        <EmptyState title="No se pudieron cargar las medallas" detail={error} />
        <Link className="secondary-button" to={homePath}>← Volver al inicio</Link>
      </section>
    );
  }

  return (
    <section className="rewards-page page">
      <header className="page-hero rewards-hero">
        <div>
          <span className="eyebrow">Gamificación con propósito</span>
          <h1>Medallas de {activeStudent.name}</h1>
          <p>Más niveles, más misiones y recompensas visibles. Así el aprendizaje se vuelve juego, no castigo corporativo con tarea encima.</p>
        </div>
        <div className="hero-badge">🏅</div>
      </header>

      <section className="rewards-summary">
        <article>
          <strong>{passedAttempts.length}</strong>
          <span>misiones completadas</span>
        </article>
        <article>
          <strong>{passedAttempts.reduce((sum, attempt) => sum + attempt.stars, 0)}</strong>
          <span>estrellas ganadas</span>
        </article>
        <article>
          <strong>{unlockedCount}/{visibleBadges.length}</strong>
          <span>medallas desbloqueadas</span>
        </article>
      </section>

      {!visibleBadges.length && <EmptyState title="Sin medallas para este grado" detail="Carga las medallas correspondientes al grado del estudiante activo." />}

      <div className="badges-grid">
        {visibleBadges.map((badge) => {
          const active = unlocked.has(badge.id);
          return (
            <article className={`badge-card ${active ? 'badge-card--active' : ''}`} key={badge.id} style={{ '--badge-color': badge.color ?? '#dfe6e9' } as CSSProperties}>
              <div className="badge-card__icon">{badge.icon}</div>
              <span className="badge-category">{badge.category ?? 'avance'}</span>
              <h3>{badge.name}</h3>
              <p>{badge.description}</p>
              <small>{active ? 'Desbloqueada ✅' : badge.requirement}</small>
            </article>
          );
        })}
      </div>

      <Link className="secondary-button" to={homePath}>← Volver al inicio</Link>
    </section>
  );
}
