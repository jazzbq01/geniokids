import type { Activity, Badge, DifficultyLevel, Grade, Lesson, Question, Student, Subject, SubjectArea } from '../types/education';

export const difficultyLevels: DifficultyLevel[] = [
  {
    id: 'semilla',
    name: 'Semilla Genial',
    shortName: 'Básico',
    stageLabel: 'Nivel 1',
    description: 'Primer contacto: ejercicios simples, visuales y seguros para ganar confianza.',
    icon: '🌱',
    color: '#55efc4',
    order: 1
  },
  {
    id: 'explorador',
    name: 'Explorador Curioso',
    shortName: 'Fácil',
    stageLabel: 'Nivel 2',
    description: 'Retos cortos para reconocer patrones, vocabulario y operaciones esenciales.',
    icon: '🔎',
    color: '#74b9ff',
    order: 2
  },
  {
    id: 'aventurero',
    name: 'Aventurero Ágil',
    shortName: 'Medio',
    stageLabel: 'Nivel 3',
    description: 'Actividades con más análisis, comprensión y toma de decisiones.',
    icon: '🧭',
    color: '#a29bfe',
    order: 3
  },
  {
    id: 'estrella',
    name: 'Estrella Brillante',
    shortName: 'Avanzado',
    stageLabel: 'Nivel 4',
    description: 'Desafíos para consolidar el aprendizaje y subir el estándar.',
    icon: '⭐',
    color: '#fdcb6e',
    order: 4
  },
  {
    id: 'maestro',
    name: 'Maestro Genio',
    shortName: 'Experto',
    stageLabel: 'Nivel 5',
    description: 'Misiones de alto rendimiento para dominar el curso con seguridad.',
    icon: '🏆',
    color: '#ff7675',
    order: 5
  }
];

export const demoStudents: Student[] = [
  { id: 'demo-inicial', name: 'Sofía', age: 3, grade: '3-anios', level: 'inicial', avatar: '👧🏻', gender: 'female', childUsername: 'sofia' },
  { id: 'demo-primaria', name: 'Mateo', age: 8, grade: '3-primaria', level: 'primaria', avatar: '👦🏻', gender: 'male', childUsername: 'mateo' }
];

export const subjects: Subject[] = [
  { id: 'mat-inicial', name: 'Números divertidos', area: 'matematica', level: 'inicial', grades: ['3-anios', '4-anios', '5-anios'], icon: '🔢', color: '#ff7675', description: 'Conteo, tamaños, formas, patrones y primeras sumas con juegos visuales.' },
  { id: 'com-inicial', name: 'Vocales y cuentos', area: 'comunicacion', level: 'inicial', grades: ['3-anios', '4-anios', '5-anios'], icon: '📚', color: '#fdcb6e', description: 'Vocales, sonidos, cuentos cortos, trazos y palabras con apoyo visual.' },
  { id: 'eng-inicial', name: 'English Kids', area: 'ingles', level: 'inicial', grades: ['3-anios', '4-anios', '5-anios'], icon: '🌈', color: '#74b9ff', description: 'Colores, animales, números, saludos y palabras básicas en inglés.' },
  { id: 'sci-inicial', name: 'Mi mundo natural', area: 'ciencia', level: 'inicial', grades: ['3-anios', '4-anios', '5-anios'], icon: '🌿', color: '#00cec9', description: 'Animales, plantas, cuerpo humano, clima y cuidado del ambiente con imágenes.' },
  { id: 'logic-inicial', name: 'Juegos de lógica', area: 'razonamiento', level: 'inicial', grades: ['3-anios', '4-anios', '5-anios'], icon: '🧩', color: '#fab1a0', description: 'Memoria visual, clasificación, secuencias simples y atención.' },
  { id: 'games-inicial', name: 'Mini juegos', area: 'juegos', level: 'inicial', grades: ['3-anios', '4-anios', '5-anios'], icon: '🎮', color: '#e17055', description: 'Juegos cortos para reforzar números, colores, vocales y concentración.' },
  { id: 'mat-primaria', name: 'Matemática', area: 'matematica', level: 'primaria', grades: ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'], icon: '🧮', color: '#6c5ce7', description: 'Operaciones, problemas, fracciones, geometría, porcentajes, proporcionalidad y estadística.' },
  { id: 'com-primaria', name: 'Comunicación', area: 'comunicacion', level: 'primaria', grades: ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'], icon: '✍️', color: '#00b894', description: 'Lectoescritura, comprensión lectora, gramática, ortografía y producción de textos.' },
  { id: 'eng-primaria', name: 'Inglés', area: 'ingles', level: 'primaria', grades: ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'], icon: '🗣️', color: '#0984e3', description: 'Vocabulario, frases simples, verb to be, present simple y práctica guiada.' },
  { id: 'sci-primaria', name: 'Ciencia y ambiente', area: 'ciencia', level: 'primaria', grades: ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'], icon: '🔬', color: '#00cec9', description: 'Seres vivos, sentidos, salud, ecosistemas, materia, energía y cuidado del ambiente.' },
  { id: 'logic-primaria', name: 'Razonamiento', area: 'razonamiento', level: 'primaria', grades: ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'], icon: '🧠', color: '#a29bfe', description: 'Patrones, series, memoria, clasificación, inferencias y pensamiento lógico.' },
  { id: 'games-primaria', name: 'Juegos educativos', area: 'juegos', level: 'primaria', grades: ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'], icon: '🎮', color: '#e17055', description: 'Retos gamificados para reforzar cálculo, lectura, vocabulario y atención.' }
];

const initialGrades: Grade[] = ['3-anios', '4-anios', '5-anios'];
const primaryGrades: Grade[] = ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'];

function suffix(grade: Grade) {
  return grade.replace('-anios', 'a').replace('-primaria', 'p');
}

function questionFor(area: SubjectArea, index: number, grade: Grade, difficultyOrder: number): Question {
  const base = index + difficultyOrder;
  const options = (correct: string, wrongA: string, wrongB: string) => [
    { id: 'a', label: wrongA, value: wrongA.toLowerCase() },
    { id: 'b', label: correct, value: correct.toLowerCase() },
    { id: 'c', label: wrongB, value: wrongB.toLowerCase() }
  ];

  if (area === 'matematica') {
    const a = grade.includes('primaria') ? base + 5 : Math.min(base, 10);
    const b = difficultyOrder + 1;
    const answer = String(a + b);
    return {
      id: `q-${area}-${grade}-${difficultyOrder}-${index}`,
      prompt: `Resuelve: ${a} + ${b} = __`,
      helper: 'Cuenta con calma y elige la respuesta correcta.',
      type: 'single-choice',
      options: [
        { id: 'a', label: String(a + b - 1), value: String(a + b - 1) },
        { id: 'b', label: answer, value: answer },
        { id: 'c', label: String(a + b + 1), value: String(a + b + 1) }
      ],
      correctAnswer: answer
    };
  }

  if (area === 'comunicacion') {
    return {
      id: `q-${area}-${grade}-${difficultyOrder}-${index}`,
      prompt: 'Lee: “La niña canta en casa.” ¿Quién canta?',
      helper: 'Busca la persona que realiza la acción.',
      type: 'single-choice',
      options: options('niña', 'casa', 'canta'),
      correctAnswer: 'niña'
    };
  }

  if (area === 'ingles') {
    return {
      id: `q-${area}-${grade}-${difficultyOrder}-${index}`,
      prompt: 'What does “blue” mean?',
      helper: 'Recuerda los colores en inglés.',
      type: 'single-choice',
      options: options('azul', 'rojo', 'verde'),
      correctAnswer: 'azul'
    };
  }

  if (area === 'ciencia') {
    return {
      id: `q-${area}-${grade}-${difficultyOrder}-${index}`,
      prompt: '¿Qué necesita una planta para vivir?',
      helper: 'Piensa en lo que ayuda a crecer a las plantas.',
      type: 'single-choice',
      options: options('agua', 'plástico', 'piedra'),
      correctAnswer: 'agua'
    };
  }

  if (area === 'razonamiento') {
    const answer = String(base + 2);
    return {
      id: `q-${area}-${grade}-${difficultyOrder}-${index}`,
      prompt: `Completa la serie: ${base}, ${base + 1}, __`,
      helper: 'La serie aumenta de uno en uno.',
      type: 'single-choice',
      options: [
        { id: 'a', label: String(base), value: String(base) },
        { id: 'b', label: answer, value: answer },
        { id: 'c', label: String(base + 3), value: String(base + 3) }
      ],
      correctAnswer: answer
    };
  }

  return {
    id: `q-${area}-${grade}-${difficultyOrder}-${index}`,
    prompt: 'Reto rápido: elige la estrella correcta.',
    helper: 'Observa las opciones y toca la estrella.',
    type: 'visual-choice',
    options: [
      { id: 'a', label: 'Luna', value: 'luna', image: '🌙' },
      { id: 'b', label: 'Estrella', value: 'estrella', image: '⭐' },
      { id: 'c', label: 'Sol', value: 'sol', image: '☀️' }
    ],
    correctAnswer: 'estrella'
  };
}

export const lessons: Lesson[] = [];
export const activities: Activity[] = [];

subjects.forEach((subject) => {
  const grades = subject.level === 'inicial' ? initialGrades : primaryGrades;
  grades.forEach((grade) => {
    difficultyLevels.forEach((level) => {
      const lessonId = `les-${subject.id}-${suffix(grade)}-${level.id}`;
      lessons.push({
        id: lessonId,
        subjectId: subject.id,
        grade,
        difficulty: level.id,
        title: `${level.icon} ${level.name}`,
        description: `Ruta ${level.shortName.toLowerCase()} con 20 actividades progresivas para ${subject.name}.`,
        order: level.order
      });

      for (let i = 1; i <= 20; i += 1) {
        const activityId = `act-${subject.id}-${suffix(grade)}-${level.id}-${String(i).padStart(2, '0')}`;
        const question = questionFor(subject.area, i, grade, level.order);
        activities.push({
          id: activityId,
          lessonId,
          subjectId: subject.id,
          grade,
          title: `Misión ${String(i).padStart(2, '0')}: ${level.name}`,
          description: `Actividad ${i} de 20 del nivel ${level.shortName}. Cada misión vale 1 punto.`,
          type: subject.area === 'ingles' && i % 5 === 0 ? 'matching' : subject.area === 'juegos' ? 'memory' : 'quiz',
          difficulty: level.id,
          order: i,
          points: 1,
          questions: [{ ...question, id: `q-${activityId}-1` }]
        });
      }
    });
  });
});

export const badges: Badge[] = [
  { id: 'badge-first-mission', name: 'Primera Chispa', description: 'Completó su primera misión.', icon: '✨', requirement: 'Completar 1 actividad.', color: '#55efc4', category: 'avance' },
  { id: 'badge-10-missions', name: 'Racha de 10', description: 'Terminó 10 actividades. Esto ya huele a hábito.', icon: '🔥', requirement: 'Completar 10 actividades.', color: '#fab1a0', category: 'constancia' },
  { id: 'badge-20-level', name: 'Nivel Cerrado', description: 'Completó 20 actividades, equivalente a un nivel completo.', icon: '🎯', requirement: 'Completar 20 actividades.', color: '#74b9ff', category: 'nivel' },
  { id: 'badge-50-missions', name: 'Máquina de Aprender', description: 'Superó 50 misiones educativas.', icon: '🚀', requirement: 'Completar 50 actividades.', color: '#a29bfe', category: 'constancia' },
  { id: 'badge-perfect-score', name: 'Respuesta Perfecta', description: 'Obtuvo 100% en una actividad.', icon: '🏆', requirement: 'Obtener 100% en una actividad.', color: '#fdcb6e', category: 'excelencia' },
  { id: 'badge-math-genius', name: 'Genio Numérico', description: 'Destaca en retos de matemática.', icon: '🧮', requirement: 'Completar matemática con 80% o más.', color: '#6c5ce7', category: 'curso' },
  { id: 'badge-reader', name: 'Lector Curioso', description: 'Avanza en comunicación y comprensión.', icon: '📖', requirement: 'Completar una actividad de comunicación.', color: '#00b894', category: 'curso' },
  { id: 'badge-english', name: 'Hello Champion', description: 'Practica inglés con éxito.', icon: '🗣️', requirement: 'Completar una actividad de inglés.', color: '#0984e3', category: 'curso' },
  { id: 'badge-science', name: 'Mini Científico', description: 'Explora ciencia y ambiente.', icon: '🔬', requirement: 'Completar una actividad de ciencia.', color: '#00cec9', category: 'curso' },
  { id: 'badge-master-genius', name: 'Maestro Genio', description: 'Llegó a actividades del nivel experto.', icon: '👑', requirement: 'Completar una actividad Maestro Genio.', color: '#ff7675', category: 'nivel' }
];
