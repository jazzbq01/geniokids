type StatCardProps = {
  label: string;
  value: string | number;
  helper?: string;
  icon?: string;
};

export function StatCard({ label, value, helper, icon = '✨' }: StatCardProps) {
  return (
    <article className="stat-card">
      <div className="stat-card__icon">{icon}</div>
      <div>
        <p>{label}</p>
        <strong>{value}</strong>
        {helper && <span>{helper}</span>}
      </div>
    </article>
  );
}
