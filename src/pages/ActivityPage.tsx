import { motion } from 'framer-motion';
import { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { EmptyState } from '../components/EmptyState';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import type { Activity, DifficultyLevel, ProgressAttempt } from '../types/education';
import './ActivityPage.css';

const MIN_PASSING_NOTE = 15;

function scoreToNote20(score: number) {
  if (score <= 20) return Math.max(0, Math.min(20, Math.round(score)));
  return Math.max(0, Math.min(20, Math.round((score / 100) * 20)));
}

function isLevelPassed(levelActivities: Activity[], attempts: ProgressAttempt[]) {
  const bestByActivity = new Map<string, number>();
  attempts.forEach((attempt) => {
    const current = bestByActivity.get(attempt.activityId) ?? -1;
    const incoming = scoreToNote20(attempt.score);
    if (incoming > current) bestByActivity.set(attempt.activityId, incoming);
  });
  const completed = levelActivities.filter((activity) => bestByActivity.has(activity.id)).length;
  const notes = levelActivities.map((activity) => bestByActivity.get(activity.id)).filter((score): score is number => typeof score === 'number');
  const averageNote = notes.length ? Math.round(notes.reduce((sum, score) => sum + score, 0) / notes.length) : 0;
  return completed >= levelActivities.length || averageNote >= MIN_PASSING_NOTE;
}

function canOpenActivity(activity: Activity, allActivities: Activity[], levels: DifficultyLevel[], attempts: ProgressAttempt[]) {
  const currentLevelIndex = levels.findIndex((level) => level.id === activity.difficulty);
  if (currentLevelIndex <= 0) return true;
  const previousLevel = levels[currentLevelIndex - 1];
  const previousActivities = allActivities.filter((item) => item.difficulty === previousLevel.id);
  return isLevelPassed(previousActivities, attempts);
}

function findNextActivity(current: Activity, allActivities: Activity[]) {
  const ordered = allActivities
    .slice()
    .sort((a, b) => a.difficulty.localeCompare(b.difficulty) || a.order - b.order);
  const currentIndex = ordered.findIndex((item) => item.id === current.id);
  return currentIndex >= 0 ? ordered[currentIndex + 1] : undefined;
}

export function ActivityPage() {
  const { activityId } = useParams();
  const navigate = useNavigate();
  const { activeStudent, refresh } = useStudent();
  const [activity, setActivity] = useState<Activity | undefined>();
  const [nextActivity, setNextActivity] = useState<Activity | undefined>();
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selected, setSelected] = useState<string | null>(null);
  const [correctAnswers, setCorrectAnswers] = useState(0);
  const [finished, setFinished] = useState(false);
  const [feedback, setFeedback] = useState<'correct' | 'wrong' | null>(null);

  useEffect(() => {
    setActivity(undefined);
    setNextActivity(undefined);
    setCurrentIndex(0);
    setSelected(null);
    setCorrectAnswers(0);
    setFinished(false);
    setFeedback(null);
    setSaveError(null);
  }, [activityId]);

  useEffect(() => {
    async function loadActivity() {
      if (!activityId) {
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setLoadError(null);
        const response = await educationService.getActivity(activityId);
        if (response) {
          const [allActivities, levels, attempts] = await Promise.all([
            educationService.getActivities(response.subjectId, activeStudent.grade),
            educationService.getDifficultyLevels(),
            educationService.getAttempts(activeStudent.id)
          ]);
          if (!canOpenActivity(response, allActivities, levels, attempts)) {
            throw new Error('Nivel bloqueado: primero completa el nivel anterior o logra nota mínima de 15/20.');
          }
          setNextActivity(findNextActivity(response, allActivities));
        }
        setActivity(response);
      } catch (error) {
        setLoadError(error instanceof Error ? error.message : 'No se pudo cargar la actividad.');
      } finally {
        setLoading(false);
      }
    }

    loadActivity();
  }, [activityId, activeStudent.grade, activeStudent.id]);

  const question = activity?.questions[currentIndex];

  const result = useMemo(() => {
    if (!activity) return { score: 0, note20: 0, stars: 0 };
    const score = Math.round((correctAnswers / activity.questions.length) * 100);
    const note20 = scoreToNote20(score);
    const stars = score >= 90 ? 3 : score >= 70 ? 2 : score > 0 ? 1 : 0;
    return { score, note20, stars };
  }, [activity, correctAnswers]);

  if (loading) {
    return <EmptyState title="Cargando actividad" detail="Consultando información desde Supabase..." />;
  }

  if (loadError) {
    return <EmptyState title="No se pudo cargar" detail={loadError} />;
  }

  if (!activity || !question) {
    return <EmptyState title="Actividad no encontrada" detail="Regresa al curso y selecciona otra actividad." />;
  }

  const homePath = activeStudent.level === 'inicial' ? '/inicial' : '/primaria';

  async function handleSelect(value: string) {
    if (!activity || !question || finished || feedback) return;
    const activeQuestion = question;
    setSelected(value);
    const isCorrect = value === activeQuestion.correctAnswer || activeQuestion.type === 'match';
    setFeedback(isCorrect ? 'correct' : 'wrong');
    if (isCorrect) setCorrectAnswers((prev) => prev + 1);

    setTimeout(async () => {
      if (currentIndex + 1 >= activity.questions.length) {
        const finalCorrect = isCorrect ? correctAnswers + 1 : correctAnswers;
        const finalScore = Math.round((finalCorrect / activity.questions.length) * 100);
        const finalStars = finalScore >= 90 ? 3 : finalScore >= 70 ? 2 : finalScore > 0 ? 1 : 0;

        try {
          setSaveError(null);
          await educationService.saveAttempt({
            id: crypto.randomUUID(),
            studentId: activeStudent.id,
            activityId: activity.id,
            subjectId: activity.subjectId,
            difficulty: activity.difficulty,
            score: finalScore,
            totalQuestions: activity.questions.length,
            correctAnswers: finalCorrect,
            stars: finalStars,
            completedAt: new Date().toISOString()
          });
          refresh();
        } catch (error) {
          setSaveError(error instanceof Error ? error.message : 'No se pudo guardar el avance.');
        } finally {
          setFinished(true);
        }
      } else {
        setCurrentIndex((prev) => prev + 1);
        setSelected(null);
        setFeedback(null);
      }
    }, 900);
  }

  function completeMatching() {
    handleSelect('completed');
  }

  if (finished) {
    return (
      <section className="activity-page page">
        <motion.div className="result-card" initial={{ scale: 0.9, opacity: 0 }} animate={{ scale: 1, opacity: 1 }}>
          <div className="result-card__icon">{result.stars === 3 ? '🏆' : result.stars === 2 ? '⭐' : '💪'}</div>
          <h1>¡Actividad completada!</h1>
          <p>{activeStudent.name} obtuvo {result.note20}/20 ({result.score}%) y ganó {'⭐'.repeat(result.stars) || 'una práctica valiosa'}.</p>
          {saveError && <p className="activity-save-error">{saveError}</p>}
          <div className="result-actions">
            {nextActivity ? (
              <button className="primary-button" type="button" onClick={() => navigate(`/activity/${nextActivity.id}`)}>
                Continuar con la siguiente misión →
              </button>
            ) : (
              <Link className="primary-button" to={`/subject/${activity.subjectId}`}>Ver curso completado</Link>
            )}
            <Link className="secondary-button" to={homePath}>Terminar por ahora</Link>
            <Link className="secondary-button" to={`/subject/${activity.subjectId}`}>Volver al acordeón</Link>
          </div>
        </motion.div>
      </section>
    );
  }

  return (
    <section className="activity-page page">
      <header className="activity-header">
        <div>
          <span className="eyebrow">Pregunta {currentIndex + 1} de {activity.questions.length}</span>
          <h1>{activity.title}</h1>
          <p>{activity.description}</p>
        </div>
        <div className="activity-header-actions">
          <div className="activity-points">{activity.points} pts</div>
          <Link className="activity-exit-button" to={homePath}>Terminar por ahora</Link>
        </div>
      </header>

      <motion.article key={question.id} className="question-card" initial={{ x: 30, opacity: 0 }} animate={{ x: 0, opacity: 1 }}>
        <h2>{question.prompt}</h2>
        {question.helper && <p className="question-helper">💡 {question.helper}</p>}

        {question.type === 'match' && question.pairs ? (
          <div className="matching-game">
            <div className="matching-columns">
              <div>
                {question.pairs.map((pair) => <button key={pair.left}>{pair.left}</button>)}
              </div>
              <div>
                {question.pairs.map((pair) => <button key={pair.right}>{pair.right}</button>)}
              </div>
            </div>
            <button className="primary-button" onClick={completeMatching}>Ya relacioné las parejas</button>
          </div>
        ) : (
          <div className="answer-grid">
            {question.options.map((option) => (
              <button
                key={option.id}
                className={`answer-button ${selected === option.value ? 'answer-button--selected' : ''}`}
                onClick={() => handleSelect(option.value)}
              >
                {option.image && <span>{option.image}</span>}
                {option.label}
              </button>
            ))}
          </div>
        )}

        {feedback && (
          <div className={`feedback feedback--${feedback}`}>
            {feedback === 'correct' ? '¡Excelente! 🎉' : 'Casi, vuelve a practicar 💪'}
          </div>
        )}
      </motion.article>
    </section>
  );
}
