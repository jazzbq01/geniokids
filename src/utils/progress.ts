import type { Activity, ProgressAttempt } from '../types/education';

export const MIN_PREVIOUS_LEVEL_PERCENT = 75;

export type ActivityProgressStatus = 'completed' | 'retry' | 'pending';

export function scoreToPercent(score: number) {
  if (score <= 20) return Math.max(0, Math.min(100, Math.round((score / 20) * 100)));
  return Math.max(0, Math.min(100, Math.round(score)));
}

export function isAttemptPassed(attempt: ProgressAttempt) {
  const totalQuestions = Number(attempt.totalQuestions ?? 0);
  const correctAnswers = Number(attempt.correctAnswers ?? 0);

  if (totalQuestions > 0) {
    return correctAnswers >= totalQuestions;
  }

  return scoreToPercent(attempt.score) >= 100;
}

export function getPassedActivityIds(attempts: ProgressAttempt[]) {
  return new Set(attempts.filter(isAttemptPassed).map((attempt) => attempt.activityId));
}

export function getRetryActivityIds(attempts: ProgressAttempt[]) {
  const passed = getPassedActivityIds(attempts);
  const retry = new Set<string>();

  attempts.forEach((attempt) => {
    if (!passed.has(attempt.activityId) && !isAttemptPassed(attempt)) {
      retry.add(attempt.activityId);
    }
  });

  return retry;
}

export function getActivityProgressStatus(activityId: string, attempts: ProgressAttempt[]): ActivityProgressStatus {
  if (attempts.some((attempt) => attempt.activityId === activityId && isAttemptPassed(attempt))) {
    return 'completed';
  }

  if (attempts.some((attempt) => attempt.activityId === activityId && !isAttemptPassed(attempt))) {
    return 'retry';
  }

  return 'pending';
}

export function countPassedActivities(activities: Activity[], attempts: ProgressAttempt[]) {
  const passedActivityIds = getPassedActivityIds(attempts);
  return activities.filter((activity) => passedActivityIds.has(activity.id)).length;
}

export function countRetryActivities(activities: Activity[], attempts: ProgressAttempt[]) {
  const retryActivityIds = getRetryActivityIds(attempts);
  return activities.filter((activity) => retryActivityIds.has(activity.id)).length;
}

export function requiredActivitiesFor75(totalActivities: number) {
  return totalActivities ? Math.ceil((totalActivities * MIN_PREVIOUS_LEVEL_PERCENT) / 100) : 0;
}
