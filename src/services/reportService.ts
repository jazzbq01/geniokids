import { subjects } from '../data/demoContent';
import type { ProgressAttempt, Recommendation, Subject } from '../types/education';

function latestAttemptByActivity(attempts: ProgressAttempt[]) {
  const latestByActivity = new Map<string, ProgressAttempt>();

  attempts.forEach((attempt) => {
    const current = latestByActivity.get(attempt.activityId);
    if (!current || new Date(attempt.completedAt).getTime() >= new Date(current.completedAt).getTime()) {
      latestByActivity.set(attempt.activityId, attempt);
    }
  });

  return Array.from(latestByActivity.values());
}

function subjectAttempts(attempts: ProgressAttempt[], subjectId: string) {
  return attempts.filter((attempt) => attempt.subjectId === subjectId);
}

function averageScore(attempts: ProgressAttempt[]) {
  return attempts.length
    ? Math.round(attempts.reduce((sum, item) => sum + item.score, 0) / attempts.length)
    : 0;
}

function recommendationPriority(average: number, attempts: number): Recommendation['priority'] {
  if (!attempts || average < 50) return 'alta';
  if (average < 75) return 'media';
  return 'baja';
}

function recommendationDetail(subject: Subject, average: number, completed: number) {
  if (!completed) {
    return `Aún no registra actividades en ${subject.name}. Conviene iniciar con una rutina corta de 10 minutos y resolver primero ejercicios básicos.`;
  }

  if (average < 50) {
    return `Promedio actual: ${average}%. Priorizar refuerzo en ejercicios simples, repetir actividades base y acompañar la lectura de instrucciones.`;
  }

  if (average < 75) {
    return `Promedio actual: ${average}%. Va en proceso, pero necesita práctica constante para consolidar antes de subir de nivel.`;
  }

  return `Promedio actual: ${average}%. Mantener el ritmo con retos moderados y revisar que complete el 75% de actividades del nivel antes de avanzar.`;
}

export function summarizeAttempts(attempts: ProgressAttempt[], subjectCatalog = subjects) {
  const completedAttempts = latestAttemptByActivity(attempts);

  const bySubject = subjectCatalog.map((subject) => {
    const attemptsForSubject = subjectAttempts(completedAttempts, subject.id);
    const average = averageScore(attemptsForSubject);

    return {
      subjectId: subject.id,
      subject: subject.name,
      icon: subject.icon,
      color: subject.color,
      attempts: attemptsForSubject.length,
      average,
      stars: attemptsForSubject.reduce((sum, item) => sum + item.stars, 0)
    };
  });

  const totalStars = bySubject.reduce((sum, item) => sum + item.stars, 0);
  const averageScoreValue = completedAttempts.length ? averageScore(completedAttempts) : 0;

  return {
    bySubject,
    totalStars,
    averageScore: averageScoreValue,
    completed: completedAttempts.length
  };
}

export function buildRecommendations(attempts: ProgressAttempt[], subjectCatalog = subjects): Recommendation[] {
  if (!subjectCatalog.length) {
    return [
      {
        title: 'Cargar cursos disponibles',
        detail: 'No se encontraron cursos activos para este grado. Revisa la configuración de contenidos en Supabase.',
        priority: 'alta'
      }
    ];
  }

  const summary = summarizeAttempts(attempts, subjectCatalog);

  return summary.bySubject.map((item) => {
    const subject = subjectCatalog.find((course) => course.id === item.subjectId) ?? subjectCatalog[0];
    return {
      title: item.attempts ? `Recomendación para ${item.subject}` : `Iniciar ${item.subject}`,
      detail: recommendationDetail(subject, item.average, item.attempts),
      priority: recommendationPriority(item.average, item.attempts)
    };
  });
}

export function buildCongratulations(attempts: ProgressAttempt[], subjectCatalog = subjects): Recommendation[] {
  const summary = summarizeAttempts(attempts, subjectCatalog);
  const strongSubjects = summary.bySubject.filter((item) => item.attempts > 0 && item.average >= 75);

  if (!strongSubjects.length) return [];

  return strongSubjects.map((item) => ({
    title: `Buen avance en ${item.subject}`,
    detail: `Tiene ${item.average}% de rendimiento y ${item.attempts} actividad${item.attempts === 1 ? '' : 'es'} completada${item.attempts === 1 ? '' : 's'}. Conviene felicitar el esfuerzo y mantener la práctica sin bajar la guardia.`,
    priority: 'baja'
  }));
}

export function buildParentConsiderations(
  attempts: ProgressAttempt[],
  subjectCatalog = subjects,
  activitiesBySubject: Record<string, { id: string }[]> = {}
): Recommendation[] {
  const summary = summarizeAttempts(attempts, subjectCatalog);
  const considerations: Recommendation[] = [];

  const coursesWithoutPractice = summary.bySubject.filter((item) => item.attempts === 0);
  if (coursesWithoutPractice.length) {
    considerations.push({
      title: 'Cursos sin práctica registrada',
      detail: `Falta iniciar: ${coursesWithoutPractice.map((item) => item.subject).join(', ')}. Recomendación ejecutiva: programar una mini rutina por curso para equilibrar el avance.`,
      priority: 'alta'
    });
  }

  const coursesBelowGoal = summary.bySubject.filter((item) => item.attempts > 0 && item.average < 75);
  if (coursesBelowGoal.length) {
    considerations.push({
      title: 'Cursos por debajo de la meta del 75%',
      detail: `Revisar con prioridad: ${coursesBelowGoal.map((item) => `${item.subject} (${item.average}%)`).join(', ')}. Antes de subir de nivel debe consolidar práctica y comprensión.`,
      priority: 'media'
    });
  }

  const lowCoverageCourses = summary.bySubject.filter((item) => {
    const total = activitiesBySubject[item.subjectId]?.length ?? 0;
    if (!total) return false;
    const completedPercent = Math.round((item.attempts / total) * 100);
    return completedPercent > 0 && completedPercent < 75;
  });

  if (lowCoverageCourses.length) {
    considerations.push({
      title: 'Avance insuficiente para desbloqueo',
      detail: `La regla de pase usa actividades completadas, no solo nota. Aún requieren completar más actividades: ${lowCoverageCourses.map((item) => {
        const total = activitiesBySubject[item.subjectId]?.length ?? 0;
        const required = Math.ceil(total * 0.75);
        return `${item.subject} (${item.attempts}/${total}, meta ${required})`;
      }).join(', ')}.`,
      priority: 'media'
    });
  }

  if (!considerations.length) {
    considerations.push({
      title: 'Seguimiento saludable',
      detail: 'El avance está equilibrado. Mantener horarios cortos, celebrar logros y subir la dificultad de forma gradual.',
      priority: 'baja'
    });
  }

  return considerations;
}
