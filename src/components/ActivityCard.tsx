import { Link } from 'react-router-dom';
import type { Activity, DifficultyLevel } from '../types/education';

type ActivityCardProps = {
  activity: Activity;
  difficultyLevel?: DifficultyLevel;
  completed?: boolean;
  locked?: boolean;
};

export function ActivityCard({ activity, difficultyLevel, completed = false, locked = false }: ActivityCardProps) {
  const content = (
    <>
      <div>
        <span className="mission-number">Misión {String(activity.order).padStart(2, '0')}</span>
        <span className="pill" style={{ background: difficultyLevel?.color ?? '#dfe6e9' }}>
          {difficultyLevel ? `${difficultyLevel.icon} ${difficultyLevel.shortName}` : activity.difficulty}
        </span>
        <h3>{activity.title}</h3>
        <p>{locked ? 'Bloqueada: completa o aprueba el nivel anterior con nota mínima 15.' : activity.description}</p>
      </div>
      <strong>{locked ? '🔒' : completed ? '✅' : `${activity.points} pt`}</strong>
    </>
  );

  if (locked) {
    return <div className="activity-card activity-card--locked">{content}</div>;
  }

  return <Link to={`/activity/${activity.id}`} className={`activity-card ${completed ? 'activity-card--done' : ''}`}>{content}</Link>;
}
