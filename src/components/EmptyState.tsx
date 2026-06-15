export function EmptyState({ title, detail }: { title: string; detail: string }) {
  return (
    <section className="empty-state">
      <div>🪄</div>
      <h3>{title}</h3>
      <p>{detail}</p>
    </section>
  );
}
