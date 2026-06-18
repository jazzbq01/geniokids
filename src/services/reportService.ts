import { subjects } from '../data/demoContent';
import type { ProgressAttempt, Recommendation } from '../types/education';
import { isAttemptPassed } from '../utils/progress';

export function summarizeAttempts(attempts: ProgressAttempt[], subjectCatalog = subjects) {
  const passedAttempts = attempts.filter(isAttemptPassed);
  const bySubject = subjectCatalog.map((subject) => {
    const subjectAttempts = passedAttempts.filter((attempt) => attempt.subjectId === subject.id);
    const average = subjectAttempts.length
      ? Math.round(subjectAttempts.reduce((sum, item) => sum + item.score, 0) / subjectAttempts.length)
      : 0;

    return {
      subjectId: subject.id,
      subject: subject.name,
      icon: subject.icon,
      color: subject.color,
      attempts: subjectAttempts.length,
      average,
      stars: subjectAttempts.reduce((sum, item) => sum + item.stars, 0)
    };
  }).filter((item) => item.attempts > 0);

  const totalStars = bySubject.reduce((sum, item) => sum + item.stars, 0);
  const averageScore = passedAttempts.length
    ? Math.round(passedAttempts.reduce((sum, item) => sum + item.score, 0) / passedAttempts.length)
    : 0;

  return {
    bySubject,
    totalStars,
    averageScore,
    completed: passedAttempts.length
  };
}

export function buildRecommendations(attempts: ProgressAttempt[], subjectCatalog = subjects): Recommendation[] {
  if (!attempts.length) {
    return [
      {
        title: 'Iniciar rutina corta',
        detail: 'Empieza con 10 minutos diarios. La constancia vale más que sesiones largas.',
        priority: 'alta'
      }
    ];
  }

  const summary = summarizeAttempts(attempts, subjectCatalog);
  const weakSubjects = summary.bySubject.filter((item) => item.average < 70);

  if (!weakSubjects.length) {
    return [
      {
        title: 'Buen avance general',
        detail: 'Mantener la práctica diaria y subir poco a poco la dificultad.',
        priority: 'baja'
      }
    ];
  }

  return weakSubjects.map((item) => ({
    title: `Reforzar ${item.subject}`,
    detail: `Promedio actual: ${item.average}%. Conviene repetir actividades fáciles antes de pasar al siguiente nivel.`,
    priority: item.average < 50 ? 'alta' : 'media'
  }));
}
