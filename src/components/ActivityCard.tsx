import { Link } from 'react-router-dom';
import type { Activity, DifficultyLevel } from '../types/education';
import type { ActivityProgressStatus } from '../utils/progress';

type ActivityCardProps = {
  activity: Activity;
  difficultyLevel?: DifficultyLevel;
  status?: ActivityProgressStatus;
  locked?: boolean;
};

export function ActivityCard({ activity, difficultyLevel, status = 'pending', locked = false }: ActivityCardProps) {
  const completed = status === 'completed';
  const retry = status === 'retry';
  const statusLabel = locked
    ? 'Bloqueada: completa al menos el 75% del nivel anterior.'
    : retry
      ? 'Intento fallido: reintenta hasta responder correctamente.'
      : completed
        ? 'Completada correctamente.'
        : activity.description;
  const statusIcon = locked ? '🔒' : completed ? '✅' : retry ? '❌' : `${activity.points} pt`;

  const content = (
    <>
      <div>
        <span className="mission-number">Misión {String(activity.order).padStart(2, '0')}</span>
        <span className="pill" style={{ background: difficultyLevel?.color ?? '#dfe6e9' }}>
          {difficultyLevel ? `${difficultyLevel.icon} ${difficultyLevel.shortName}` : activity.difficulty}
        </span>
        <h3>{activity.title}</h3>
        <p>{statusLabel}</p>
      </div>
      <strong>{statusIcon}</strong>
    </>
  );

  if (locked) {
    return <div className="activity-card activity-card--locked">{content}</div>;
  }

  return (
    <Link
      to={`/activity/${activity.id}`}
      className={`activity-card ${completed ? 'activity-card--done' : ''} ${retry ? 'activity-card--retry' : ''}`}
    >
      {content}
    </Link>
  );
}
