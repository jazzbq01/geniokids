import { Link } from 'react-router-dom';
import type { Activity, DifficultyLevel } from '../types/education';

type ActivityCardProps = {
  activity: Activity;
  difficultyLevel?: DifficultyLevel;
  completed?: boolean;
  locked?: boolean;
  failed?: boolean;
  current?: boolean;
  lockedReason?: string;
};

export function ActivityCard({
  activity,
  difficultyLevel,
  completed = false,
  locked = false,
  failed = false,
  current = false,
  lockedReason
}: ActivityCardProps) {
  const statusText = completed
    ? 'Completada correctamente.'
    : failed
      ? 'Con error: reintenta esta misión para poder avanzar.'
      : locked
        ? lockedReason ?? 'Bloqueada: completa primero la misión anterior.'
        : current
          ? 'Disponible: esta es la siguiente misión pendiente.'
          : activity.description;

  const statusIcon = completed ? '✅' : failed ? '⚠️' : locked ? '🔒' : '▶️';

  const content = (
    <>
      <div>
        <span className="mission-number">Misión {String(activity.order).padStart(2, '0')}</span>
        <span className="pill" style={{ background: difficultyLevel?.color ?? '#dfe6e9' }}>
          {difficultyLevel ? `${difficultyLevel.icon} ${difficultyLevel.shortName}` : activity.difficulty}
        </span>
        <h3>{activity.title}</h3>
        <p>{statusText}</p>
      </div>
      <strong>{statusIcon}</strong>
    </>
  );

  const className = [
    'activity-card',
    completed ? 'activity-card--done' : '',
    locked ? 'activity-card--locked' : '',
    failed ? 'activity-card--failed' : '',
    current ? 'activity-card--current' : ''
  ].filter(Boolean).join(' ');

  if (locked || completed) {
    return <div className={className}>{content}</div>;
  }

  return <Link to={`/activity/${activity.id}`} className={className}>{content}</Link>;
}
