import { isSupabaseConfigured } from '../lib/env';
import { useAuth } from '../context/AuthContext';
import { EmptyState } from '../components/EmptyState';
import { localStore } from '../services/localStore';
import './SettingsPage.css';

export function SettingsPage() {
  const { isChild } = useAuth();

  if (isChild) return <EmptyState title="Configuración solo para padres" detail="El usuario hijo no puede modificar parámetros del sistema." />;

  function resetDemo() {
    localStore.resetDemo();
    window.location.reload();
  }

  return (
    <section className="settings-page page">
      <header className="page-hero settings-hero">
        <div>
          <span className="eyebrow">Configuración</span>
          <h1>Centro de control</h1>
          <p>Administra modo demo, conexión Supabase y parámetros base de la plataforma.</p>
        </div>
        <div className="hero-badge">⚙️</div>
      </header>

      <div className="settings-grid">
        <article className="settings-card">
          <h2>Estado de datos</h2>
          <p>Modo actual: <strong>{isSupabaseConfigured ? 'Supabase' : 'Demo localStorage'}</strong></p>
          <button className="secondary-button" onClick={resetDemo}>Reiniciar demo</button>
        </article>

        <article className="settings-card">
          <h2>Variables requeridas</h2>
          <code>VITE_SUPABASE_URL</code>
          <code>VITE_SUPABASE_ANON_KEY</code>
          <code>VITE_APP_MODE=supabase</code>
        </article>

        <article className="settings-card">
          <h2>Próximas mejoras</h2>
          <ul>
            <li>Audio real por pregunta.</li>
            <li>Banco de preguntas editable por padres.</li>
            <li>Modo docente/colegio.</li>
            <li>IA para recomendaciones personalizadas.</li>
          </ul>
        </article>
      </div>
    </section>
  );
}
