import { Link } from 'react-router-dom';
import type { Subject } from '../types/education';

type SubjectCardProps = {
  subject: Subject;
};

export function SubjectCard({ subject }: SubjectCardProps) {
  return (
    <Link className="subject-card" to={`/subject/${subject.id}`} style={{ '--accent': subject.color } as React.CSSProperties}>
      <div className="subject-card__icon">{subject.icon}</div>
      <div>
        <h3>{subject.name}</h3>
        <p>{subject.description}</p>
      </div>
      <span>Entrar →</span>
    </Link>
  );
}
