import { NavLink, Outlet, useNavigate } from 'react-router-dom';
import { StudentProvider, useStudent } from '../context/StudentContext';
import { useAuth } from '../context/AuthContext';
import '../styles/layout.css';

function LayoutShell() {
  const navigate = useNavigate();
  const { activeStudent, hasActiveStudent } = useStudent();
  const { isParent, isChild, logout } = useAuth();

  async function handleLogout() {
    await logout();
    navigate('/login');
  }

  return (
    <div className="app-shell">
      <aside className="sidebar">
        <div className="brand">
          <span>🧠</span>
          <div>
            <strong>GenioKids</strong>
            <small>Aprender jugando</small>
          </div>
        </div>

        <div className="active-child">
          <span>{activeStudent.avatar}</span>
          <div>
            <strong>{activeStudent.name}</strong>
            <small>{isParent ? 'Modo padre' : 'Modo hijo'} · {hasActiveStudent ? (activeStudent.level === 'inicial' ? 'Inicial' : 'Primaria') : 'sin hijo seleccionado'}</small>
          </div>
        </div>

        <nav>
          {isParent && <NavLink to="/students">👨‍👩‍👧 Hijos</NavLink>}
          {isParent && <NavLink to="/dashboard">📊 Panel familiar</NavLink>}
          {hasActiveStudent && activeStudent.level === 'inicial' && <NavLink to="/inicial">🌈 Inicial</NavLink>}
          {hasActiveStudent && activeStudent.level === 'primaria' && <NavLink to="/primaria">🚀 Primaria</NavLink>}
          {isParent && <NavLink to="/reports">📈 Reportes</NavLink>}
          {hasActiveStudent && <NavLink to="/rewards">🏅 Medallas</NavLink>}
        </nav>

        <button className="logout-button" type="button" onClick={handleLogout}>Cerrar sesión</button>
        {isChild && <small className="sidebar-note">El usuario hijo solo ve su grado asignado.</small>}
      </aside>

      <main className="main-content">
        <Outlet />
      </main>
    </div>
  );
}

export function AppLayout() {
  return (
    <StudentProvider>
      <LayoutShell />
    </StudentProvider>
  );
}
