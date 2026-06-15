import { useNavigate } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { isSupabaseConfigured } from '../lib/env';
import { useAuth } from '../context/AuthContext';
import './LoginPage.css';

export function LoginPage() {
  const navigate = useNavigate();
  const { loginParent, registerParent, loginChild, role, childSession } = useAuth();
  const [mode, setMode] = useState<'parent' | 'child'>('parent');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [fullName, setFullName] = useState('');
  const [childUsername, setChildUsername] = useState('');
  const [childPin, setChildPin] = useState('');
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState<string | null>(null);

  useEffect(() => {
    if (role === 'parent') navigate('/students');
    if (role === 'child' && childSession) navigate(childSession.student.level === 'inicial' ? '/inicial' : '/primaria');
  }, [role, childSession, navigate]);

  async function handleParentLogin(event: React.FormEvent) {
    event.preventDefault();
    try {
      setLoading(true);
      setMessage(null);
      await loginParent(email, password);
      navigate('/students');
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'No se pudo iniciar sesión.');
    } finally {
      setLoading(false);
    }
  }

  async function handleRegister() {
    try {
      setLoading(true);
      setMessage(null);
      await registerParent(fullName, email, password);
      setMessage('Cuenta familiar creada. Si Supabase pide confirmación, revisa tu correo. Luego inicia sesión.');
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'No se pudo crear la cuenta.');
    } finally {
      setLoading(false);
    }
  }

  async function handleChildLogin(event: React.FormEvent) {
    event.preventDefault();
    try {
      setLoading(true);
      setMessage(null);
      await loginChild(childUsername, childPin);
      const raw = localStorage.getItem('gk_child_session');
      const parsed = raw ? JSON.parse(raw) : null;
      navigate(parsed?.student?.level === 'inicial' ? '/inicial' : '/primaria');
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'No se pudo iniciar sesión como hijo.');
    } finally {
      setLoading(false);
    }
  }

  return (
    <section className="login-page">
      <div className="login-card">
        <div className="login-card__logo">🧠✨</div>
        <h1>GenioKids</h1>
        <p>Roles separados: el padre gestiona y reporta; el hijo aprende solo lo que le corresponde.</p>

        <div className="login-card__status">
          <strong>Modo actual:</strong> {isSupabaseConfigured ? 'Supabase conectado' : 'Demo localStorage'}
        </div>

        <div className="role-tabs">
          <button type="button" className={mode === 'parent' ? 'role-tab role-tab--active' : 'role-tab'} onClick={() => setMode('parent')}>👨‍👩‍👧 Padre / Madre</button>
          <button type="button" className={mode === 'child' ? 'role-tab role-tab--active' : 'role-tab'} onClick={() => setMode('child')}>🧒 Hijo</button>
        </div>

        {mode === 'parent' ? (
          <form className="login-form" onSubmit={handleParentLogin}>
            <label>
              Nombre familiar
              <input value={fullName} onChange={(event) => setFullName(event.target.value)} placeholder="Familia Ruiz" />
            </label>
            <label>
              Correo del padre/madre
              <input type="email" value={email} onChange={(event) => setEmail(event.target.value)} placeholder="familia@correo.com" required />
            </label>
            <label>
              Contraseña
              <input type="password" value={password} onChange={(event) => setPassword(event.target.value)} placeholder="••••••••" required minLength={6} />
            </label>

            {message && <p className="login-message">{message}</p>}

            <button className="primary-button" type="submit" disabled={loading}>{loading ? 'Procesando...' : 'Ingresar como padre'}</button>
            <button className="secondary-button" type="button" onClick={handleRegister} disabled={loading || !email || !password}>Crear cuenta familiar</button>
          </form>
        ) : (
          <form className="login-form" onSubmit={handleChildLogin}>
            <label>
              Usuario del hijo
              <input value={childUsername} onChange={(event) => setChildUsername(event.target.value)} placeholder="mateo3" required />
            </label>
            <label>
              Clave del hijo
              <input type="password" value={childPin} onChange={(event) => setChildPin(event.target.value)} placeholder="1234" required minLength={4} />
            </label>

            {message && <p className="login-message">{message}</p>}

            <button className="primary-button" type="submit" disabled={loading}>{loading ? 'Entrando...' : 'Entrar a aprender'}</button>
            <p className="login-hint">El padre crea este usuario desde el panel familiar.</p>
          </form>
        )}
      </div>
    </section>
  );
}
