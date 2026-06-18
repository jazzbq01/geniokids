import { motion } from 'framer-motion';
import { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { EmptyState } from '../components/EmptyState';
import GameRenderer from '../components/games/GameRenderer';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import type { Activity, DifficultyLevel, ProgressAttempt } from '../types/education';
import './ActivityPage.css';

const MIN_PREVIOUS_LEVEL_PERCENT = 75;

type GameResult = {
  score: number;
  totalQuestions: number;
  correctAnswers: number;
  stars: number;
};

type LevelProgressSummary = {
  levelCompleted: number;
  levelTotal: number;
  levelPercent: number;
  requiredCompleted: number;
  remainingForUnlock: number;
  levelPassed: boolean;
  subjectCompleted: number;
  subjectTotal: number;
  subjectPercent: number;
};

function getCompletedIds(attempts: ProgressAttempt[]) {
  return new Set(attempts.map((attempt) => attempt.activityId));
}

function countCompletedActivities(levelActivities: Activity[], attempts: ProgressAttempt[]) {
  const completedActivities = getCompletedIds(attempts);
  return levelActivities.filter((activity) => completedActivities.has(activity.id)).length;
}

function isLevelPassed(levelActivities: Activity[], attempts: ProgressAttempt[]) {
  const completed = countCompletedActivities(levelActivities, attempts);
  const requiredCompleted = levelActivities.length
    ? Math.ceil((levelActivities.length * MIN_PREVIOUS_LEVEL_PERCENT) / 100)
    : 0;

  return requiredCompleted > 0 && completed >= requiredCompleted;
}

function canOpenActivity(
  activity: Activity,
  allActivities: Activity[],
  levels: DifficultyLevel[],
  attempts: ProgressAttempt[]
) {
  const currentLevelIndex = levels.findIndex((level) => level.id === activity.difficulty);

  if (currentLevelIndex <= 0) {
    return true;
  }

  const previousLevel = levels[currentLevelIndex - 1];
  const previousActivities = allActivities.filter((item) => item.difficulty === previousLevel.id);

  return isLevelPassed(previousActivities, attempts);
}

function orderedActivities(allActivities: Activity[], levels: DifficultyLevel[]) {
  const levelOrder = new Map(levels.map((level) => [level.id, level.order]));

  return allActivities
    .slice()
    .sort(
      (a, b) =>
        (levelOrder.get(a.difficulty) ?? 99) - (levelOrder.get(b.difficulty) ?? 99) ||
        a.order - b.order
    );
}

function findNextAvailableActivity(
  current: Activity,
  allActivities: Activity[],
  levels: DifficultyLevel[],
  attempts: ProgressAttempt[]
) {
  const ordered = orderedActivities(allActivities, levels);
  const currentIndex = ordered.findIndex((item) => item.id === current.id);

  if (currentIndex < 0) return undefined;

  return ordered
    .slice(currentIndex + 1)
    .find((candidate) => canOpenActivity(candidate, allActivities, levels, attempts));
}

function buildLevelProgressSummary(
  currentActivity: Activity,
  allActivities: Activity[],
  attempts: ProgressAttempt[]
): LevelProgressSummary {
  const levelActivities = allActivities.filter((item) => item.difficulty === currentActivity.difficulty);
  const levelCompleted = countCompletedActivities(levelActivities, attempts);
  const levelTotal = levelActivities.length;
  const levelPercent = levelTotal ? Math.round((levelCompleted / levelTotal) * 100) : 0;
  const requiredCompleted = levelTotal ? Math.ceil((levelTotal * MIN_PREVIOUS_LEVEL_PERCENT) / 100) : 0;
  const remainingForUnlock = Math.max(requiredCompleted - levelCompleted, 0);
  const subjectCompleted = countCompletedActivities(allActivities, attempts);
  const subjectTotal = allActivities.length;
  const subjectPercent = subjectTotal ? Math.round((subjectCompleted / subjectTotal) * 100) : 0;

  return {
    levelCompleted,
    levelTotal,
    levelPercent,
    requiredCompleted,
    remainingForUnlock,
    levelPassed: requiredCompleted > 0 && levelCompleted >= requiredCompleted,
    subjectCompleted,
    subjectTotal,
    subjectPercent
  };
}

function getQuestionGameConfig(question: any) {
  return question?.gameConfig ?? question?.game_config ?? {};
}

function getActivityGameType(activity: any, question: any) {
  const questionConfig = getQuestionGameConfig(question);

  return activity?.gameType ?? activity?.game_type ?? questionConfig?.game ?? null;
}

export function ActivityPage() {
  const { activityId } = useParams();
  const navigate = useNavigate();
  const { activeStudent, refresh } = useStudent();

  const [activity, setActivity] = useState<Activity | undefined>();
  const [nextActivity, setNextActivity] = useState<Activity | undefined>();
  const [courseActivities, setCourseActivities] = useState<Activity[]>([]);
  const [difficultyLevels, setDifficultyLevels] = useState<DifficultyLevel[]>([]);
  const [attempts, setAttempts] = useState<ProgressAttempt[]>([]);
  const [completionSummary, setCompletionSummary] = useState<LevelProgressSummary | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selected, setSelected] = useState<string | null>(null);
  const [correctAnswers, setCorrectAnswers] = useState(0);
  const [finished, setFinished] = useState(false);
  const [feedback, setFeedback] = useState<'correct' | 'wrong' | null>(null);
  const [gameResult, setGameResult] = useState<GameResult | null>(null);

  useEffect(() => {
    setActivity(undefined);
    setNextActivity(undefined);
    setCourseActivities([]);
    setDifficultyLevels([]);
    setAttempts([]);
    setCompletionSummary(null);
    setCurrentIndex(0);
    setSelected(null);
    setCorrectAnswers(0);
    setFinished(false);
    setFeedback(null);
    setSaveError(null);
    setGameResult(null);
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
          const [allActivitiesResponse, levelsResponse, attemptsResponse] = await Promise.all([
            educationService.getActivities(response.subjectId, activeStudent.grade),
            educationService.getDifficultyLevels(),
            educationService.getAttempts(activeStudent.id)
          ]);

          if (!canOpenActivity(response, allActivitiesResponse, levelsResponse, attemptsResponse)) {
            throw new Error('Nivel bloqueado: debes completar al menos el 75% del nivel anterior.');
          }

          setCourseActivities(allActivitiesResponse);
          setDifficultyLevels(levelsResponse);
          setAttempts(attemptsResponse);
          setNextActivity(findNextAvailableActivity(response, allActivitiesResponse, levelsResponse, attemptsResponse));
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
    if (!activity) {
      return { score: 0, totalQuestions: 0, correctAnswers: 0, stars: 0 };
    }

    if (gameResult) {
      const score = Math.max(0, Math.min(100, Math.round(gameResult.score)));
      const stars = Math.max(0, Math.min(3, gameResult.stars));

      return {
        score,
        totalQuestions: gameResult.totalQuestions,
        correctAnswers: gameResult.correctAnswers,
        stars
      };
    }

    const totalQuestions = activity.questions.length || 1;
    const score = Math.round((correctAnswers / totalQuestions) * 100);
    const stars = score >= 90 ? 3 : score >= 70 ? 2 : score > 0 ? 1 : 0;

    return { score, totalQuestions, correctAnswers, stars };
  }, [activity, correctAnswers, gameResult]);

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

  async function finishActivity(finalScore: number, finalTotalQuestions: number, finalCorrectAnswers: number, finalStars: number) {
    if (!activity) return;

    const attempt: ProgressAttempt = {
      id: crypto.randomUUID(),
      studentId: activeStudent.id,
      activityId: activity.id,
      subjectId: activity.subjectId,
      difficulty: activity.difficulty,
      score: finalScore,
      totalQuestions: finalTotalQuestions,
      correctAnswers: finalCorrectAnswers,
      stars: finalStars,
      completedAt: new Date().toISOString()
    };

    try {
      setSaveError(null);

      await educationService.saveAttempt(attempt);

      const updatedAttempts = [...attempts, attempt];
      setAttempts(updatedAttempts);
      setCompletionSummary(buildLevelProgressSummary(activity, courseActivities, updatedAttempts));
      setNextActivity(findNextAvailableActivity(activity, courseActivities, difficultyLevels, updatedAttempts));
      refresh();
    } catch (error) {
      setSaveError(error instanceof Error ? error.message : 'No se pudo guardar el avance.');
      setCompletionSummary(buildLevelProgressSummary(activity, courseActivities, attempts));
    } finally {
      setFinished(true);
    }
  }

  async function handleSelect(value: string) {
    if (!activity || !question || finished || feedback) {
      return;
    }

    const activeQuestion = question;
    setSelected(value);

    const isCorrect = value === activeQuestion.correctAnswer || activeQuestion.type === 'match';

    setFeedback(isCorrect ? 'correct' : 'wrong');

    if (isCorrect) {
      setCorrectAnswers((prev) => prev + 1);
    }

    setTimeout(async () => {
      if (currentIndex + 1 >= activity.questions.length) {
        const finalCorrect = isCorrect ? correctAnswers + 1 : correctAnswers;
        const finalScore = Math.round((finalCorrect / activity.questions.length) * 100);
        const finalStars = finalScore >= 90 ? 3 : finalScore >= 70 ? 2 : finalScore > 0 ? 1 : 0;

        await finishActivity(finalScore, activity.questions.length, finalCorrect, finalStars);
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

  async function handleGameComplete(payload: GameResult) {
    if (!activity || finished) {
      return;
    }

    const finalScore = Math.max(0, Math.min(100, Math.round(payload.score)));
    const finalStars = Math.max(0, Math.min(3, payload.stars));
    const finalTotalQuestions = Math.max(1, payload.totalQuestions);
    const finalCorrectAnswers = Math.max(0, payload.correctAnswers);

    setGameResult({
      score: finalScore,
      totalQuestions: finalTotalQuestions,
      correctAnswers: finalCorrectAnswers,
      stars: finalStars
    });

    setCorrectAnswers(finalCorrectAnswers);

    await finishActivity(finalScore, finalTotalQuestions, finalCorrectAnswers, finalStars);
  }

  if (finished) {
    return (
      <section className="activity-page page">
        <motion.div
          className="result-card"
          initial={{ scale: 0.9, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
        >
          <div className="result-card__icon">
            {result.stars === 3 ? '🏆' : result.stars === 2 ? '⭐' : '💪'}
          </div>

          <h1>¡Actividad completada!</h1>

          {completionSummary && (
            <div className="completion-summary">
              <span className="eyebrow">Progreso real del nivel</span>
              <strong>{completionSummary.levelCompleted}/{completionSummary.levelTotal}</strong>
              <div className="completion-summary__bar" aria-hidden="true">
                <span style={{ width: `${completionSummary.levelPercent}%` }} />
              </div>
              <p>
                {completionSummary.levelPassed
                  ? `Meta cumplida: ya completó ${completionSummary.levelCompleted} de ${completionSummary.levelTotal} actividades. Puede avanzar al siguiente nivel.`
                  : `Para desbloquear el siguiente nivel necesita ${completionSummary.requiredCompleted}/${completionSummary.levelTotal}. Le faltan ${completionSummary.remainingForUnlock} actividades.`}
              </p>
            </div>
          )}

          <p className="result-performance">
            Resultado de esta actividad: {result.correctAnswers}/{result.totalQuestions} respuestas correctas ({result.score}%).
          </p>

          {completionSummary && (
            <p className="result-course-progress">
              Avance del curso: {completionSummary.subjectCompleted}/{completionSummary.subjectTotal} actividades ({completionSummary.subjectPercent}%).
            </p>
          )}

          {saveError && <p className="activity-save-error">{saveError}</p>}

          <div className="result-actions">
            {nextActivity ? (
              <button
                className="primary-button"
                type="button"
                onClick={() => navigate(`/activity/${nextActivity.id}`)}
              >
                Continuar con la siguiente misión →
              </button>
            ) : (
              <Link className="primary-button" to={`/subject/${activity.subjectId}`}>
                Ver progreso del curso
              </Link>
            )}

            <Link className="secondary-button" to={homePath}>
              Ir al inicio
            </Link>

            <Link className="secondary-button" to={`/subject/${activity.subjectId}`}>
              Volver al acordeón
            </Link>
          </div>
        </motion.div>
      </section>
    );
  }

  const gameType = getActivityGameType(activity, question);
  const isGameActivity = Boolean(gameType);

  if (isGameActivity) {
    return (
      <section className="activity-page page">
        <header className="activity-header">
          <div>
            <span className="eyebrow">Juego interactivo</span>
            <h1>{activity.title}</h1>
            <p>{activity.description}</p>
          </div>

          <div className="activity-header-actions">
            <div className="activity-points">{activity.points} pts</div>

            <Link className="activity-exit-button" to={homePath}>
              Ir al inicio
            </Link>
          </div>
        </header>

        <GameRenderer
          activity={activity}
          question={question}
          onComplete={handleGameComplete}
        />
      </section>
    );
  }

  return (
    <section className="activity-page page">
      <header className="activity-header">
        <div>
          <span className="eyebrow">
            Pregunta {currentIndex + 1} de {activity.questions.length}
          </span>

          <h1>{activity.title}</h1>
          <p>{activity.description}</p>
        </div>

        <div className="activity-header-actions">
          <div className="activity-points">{activity.points} pts</div>

          <Link className="activity-exit-button" to={homePath}>
            Ir al inicio
          </Link>
        </div>
      </header>

      <motion.article
        key={question.id}
        className="question-card"
        initial={{ x: 30, opacity: 0 }}
        animate={{ x: 0, opacity: 1 }}
      >
        <h2>{question.prompt}</h2>

        {question.helper && <p className="question-helper">💡 {question.helper}</p>}

        {question.type === 'match' && question.pairs ? (
          <div className="matching-game">
            <div className="matching-columns">
              <div>
                {question.pairs.map((pair: any) => (
                  <button key={pair.left} type="button">
                    {pair.left}
                  </button>
                ))}
              </div>

              <div>
                {question.pairs.map((pair: any) => (
                  <button key={pair.right} type="button">
                    {pair.right}
                  </button>
                ))}
              </div>
            </div>

            <button className="primary-button" type="button" onClick={completeMatching}>
              Ya relacioné las parejas
            </button>
          </div>
        ) : (
          <div className="answer-grid">
            {question.options.map((option: any) => (
              <button
                key={option.id}
                type="button"
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
