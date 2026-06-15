import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useStudent } from '../context/StudentContext';
import { educationService } from '../services/educationService';
import type { Gender, Grade, Student } from '../types/education';
import { gradeLabels, isInitialGrade } from '../utils/gradeLabels';
import './StudentSelectorPage.css';

const grades: { value: Grade; label: string }[] = Object.entries(gradeLabels).map(([value, label]) => ({
  value: value as Grade,
  label
}));

function avatarByGender(gender: Gender, grade: Grade) {
  const initial = isInitialGrade(grade);
  if (gender === 'female') return initial ? '👧🏻' : '👩🏻‍🎓';
  if (gender === 'male') return initial ? '👦🏻' : '👨🏻‍🎓';
  return '🧒🏻';
}

function normalizeUsername(value: string) {
  return value.trim().toLowerCase().replace(/\s+/g, '').replace(/[^a-z0-9._-]/g, '');
}

function defaultAgeForGrade(grade: Grade) {
  if (grade === '3-anios') return 3;
  if (grade === '4-anios') return 4;
  if (grade === '5-anios') return 5;
  if (grade === '1-primaria') return 6;
  if (grade === '2-primaria') return 7;
  if (grade === '3-primaria') return 8;
  if (grade === '4-primaria') return 9;
  if (grade === '5-primaria') return 10;
  return 11;
}

export function StudentSelectorPage() {
  const navigate = useNavigate();
  const { isChild } = useAuth();
  const { activeStudent, setActiveStudent, hasActiveStudent, refresh } = useStudent();
  const [students, setStudents] = useState<Student[]>([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [editingStudent, setEditingStudent] = useState<Student | null>(null);
  const [name, setName] = useState('');
  const [age, setAge] = useState(3);
  const [grade, setGrade] = useState<Grade>('3-anios');
  const [gender, setGender] = useState<Gender>('female');
  const [childUsername, setChildUsername] = useState('');
  const [pin, setPin] = useState('1234');

  const suggestedUsername = useMemo(() => normalizeUsername(`${name}${grade.replace('-primaria', '').replace('-anios', '')}`), [name, grade]);
  const currentAvatar = avatarByGender(gender, grade);
  const modeLabel = editingStudent ? 'Editar usuario hijo' : 'Agregar usuario hijo';

  async function loadStudents() {
    try {
      setLoading(true);
      setError(null);
      const response = await educationService.getStudents();
      setStudents(response);

      const activeIsValid = response.some((student) => student.id === activeStudent.id);
      if (!isChild && response.length > 0 && (!activeIsValid || activeStudent.id.startsWith('demo-') || !hasActiveStudent)) {
        setActiveStudent(response[0]);
      }
    } catch (error) {
      setError(error instanceof Error ? error.message : 'No se pudieron cargar los estudiantes.');
    } finally {
      setLoading(false);
    }
  }

  function resetForm() {
    setEditingStudent(null);
    setName('');
    setAge(3);
    setGrade('3-anios');
    setGender('female');
    setChildUsername('');
    setPin('1234');
  }

  function startEdit(student: Student) {
    setEditingStudent(student);
    setName(student.name);
    setAge(student.age);
    setGrade(student.grade);
    setGender(student.gender);
    setChildUsername(student.childUsername ?? '');
    setPin('');
    setError(null);
    setSuccess(null);
  }

  useEffect(() => {
    loadStudents();
  }, []);

  useEffect(() => {
    if (!editingStudent && !childUsername && suggestedUsername) setChildUsername(suggestedUsername);
  }, [suggestedUsername, childUsername, editingStudent]);

  useEffect(() => {
    if (!editingStudent) setAge(defaultAgeForGrade(grade));
  }, [grade, editingStudent]);

  async function handleSubmitStudent(event: React.FormEvent) {
    event.preventDefault();
    if (!name.trim()) return;

    const normalizedUsername = normalizeUsername(childUsername || suggestedUsername);
    const student: Student = {
      id: editingStudent?.id ?? crypto.randomUUID(),
      parentId: editingStudent?.parentId,
      name: name.trim(),
      age,
      grade,
      level: isInitialGrade(grade) ? 'inicial' : 'primaria',
      avatar: currentAvatar,
      gender,
      childUsername: normalizedUsername
    };

    try {
      setSaving(true);
      setError(null);
      setSuccess(null);
      const savedStudent = editingStudent
        ? await educationService.updateStudent(student, pin)
        : await educationService.addStudent(student, pin || '1234');

      await loadStudents();
      setActiveStudent(savedStudent);
      refresh();
      setSuccess(editingStudent ? 'Usuario hijo actualizado correctamente.' : 'Usuario hijo creado correctamente.');
      resetForm();
    } catch (error) {
      setError(error instanceof Error ? error.message : 'No se pudo guardar el perfil.');
    } finally {
      setSaving(false);
    }
  }

  if (isChild) {
    return (
      <section className="students-page page">
        <header className="page-hero students-hero">
          <div>
            <span className="eyebrow">Perfil de estudiante</span>
            <h1>{activeStudent.name}</h1>
            <p>Tu usuario de hijo solo puede acceder a tu grado y a tus actividades. Sin panel de padre, sin datos de otros perfiles.</p>
          </div>
          <div className="hero-badge">{activeStudent.avatar}</div>
        </header>
      </section>
    );
  }

  return (
    <section className="students-page page">
      <header className="page-hero students-hero">
        <div>
          <span className="eyebrow">Panel familiar</span>
          <h1>Usuarios hijos y perfiles de aprendizaje</h1>
          <p>Crea y edita usuarios independientes. Puedes corregir sexo, grado, usuario, icono y clave sin tocar la base manualmente.</p>
        </div>
        <div className="hero-badge">{activeStudent.avatar}</div>
      </header>

      <div className="students-grid">
        <section className="students-list">
          {loading && <p className="muted">Cargando perfiles desde Supabase...</p>}
          {error && <p className="muted error-text">{error}</p>}
          {success && <p className="success-text">{success}</p>}
          {students.map((student) => (
            <article className={`student-card-shell ${activeStudent.id === student.id ? 'student-card-shell--active' : ''}`} key={student.id}>
              <button
                className="student-card"
                type="button"
                onClick={() => {
                  setActiveStudent(student);
                  navigate(student.level === 'inicial' ? '/inicial' : '/primaria');
                }}
              >
                <span>{student.avatar}</span>
                <div>
                  <strong>{student.name}</strong>
                  <small>{gradeLabels[student.grade]} · @{student.childUsername ?? 'sin-usuario'}</small>
                </div>
              </button>
              <button className="edit-child-button" type="button" onClick={() => startEdit(student)}>Editar</button>
            </article>
          ))}
        </section>

        <form className="student-form" onSubmit={handleSubmitStudent}>
          <h2>{modeLabel}</h2>
          {editingStudent && <p className="muted">Editando a <strong>{editingStudent.name}</strong>. Deja la clave vacía si no deseas cambiarla.</p>}
          <label>
            Nombre
            <input value={name} onChange={(event) => setName(event.target.value)} placeholder="Ej. Luciana" />
          </label>
          <label>
            Sexo
            <select value={gender} onChange={(event) => setGender(event.target.value as Gender)}>
              <option value="female">Niña</option>
              <option value="male">Niño</option>
              <option value="other">Otro / neutral</option>
            </select>
          </label>
          <label>
            Edad
            <input type="number" min={3} max={13} value={age} onChange={(event) => setAge(Number(event.target.value))} />
          </label>
          <label>
            Nivel / grado
            <select value={grade} onChange={(event) => setGrade(event.target.value as Grade)}>
              {grades.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}
            </select>
          </label>
          <label>
            Usuario del hijo
            <input value={childUsername} onChange={(event) => setChildUsername(normalizeUsername(event.target.value))} placeholder="luciana3" />
          </label>
          <label>
            {editingStudent ? 'Nueva clave del hijo opcional' : 'Clave del hijo'}
            <input type="password" minLength={editingStudent ? 0 : 4} value={pin} onChange={(event) => setPin(event.target.value)} placeholder={editingStudent ? 'Dejar vacío para mantener clave' : '1234'} />
          </label>
          <div className="student-avatar-preview">
            <span>{currentAvatar}</span>
            <small>Icono asignado según sexo y etapa</small>
          </div>
          <div className="student-form-actions">
            <button className="primary-button" type="submit" disabled={saving}>{saving ? 'Guardando...' : editingStudent ? 'Actualizar usuario hijo' : 'Crear usuario hijo'}</button>
            {editingStudent && <button className="secondary-button" type="button" onClick={resetForm}>Cancelar edición</button>}
          </div>
        </form>
      </div>
    </section>
  );
}
