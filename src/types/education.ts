export type EducationLevel = 'inicial' | 'primaria';
export type Grade = '3-anios' | '4-anios' | '5-anios' | '1-primaria' | '2-primaria' | '3-primaria' | '4-primaria' | '5-primaria' | '6-primaria';
export type SubjectArea = 'matematica' | 'comunicacion' | 'ingles' | 'ciencia' | 'ciencia_tecnologia' | 'razonamiento' | 'juegos' | 'nuestro_pais' | 'educacion_financiera' | 'tutoria' | 'personal_social' | 'psicomotriz' | 'arte_creatividad';
export type ActivityType = 'quiz' | 'matching' | 'memory' | 'trace' | 'story' | 'drag-drop';
export type Difficulty = 'semilla' | 'explorador' | 'aventurero' | 'estrella' | 'maestro';
export type UserRole = 'parent' | 'child' | 'guest';
export type Gender = 'female' | 'male' | 'other';

export interface DifficultyLevel {
  id: Difficulty;
  name: string;
  shortName: string;
  stageLabel: string;
  description: string;
  icon: string;
  color: string;
  order: number;
}

export interface Student {
  id: string;
  parentId?: string;
  name: string;
  age: number;
  grade: Grade;
  level: EducationLevel;
  avatar: string;
  gender: Gender;
  childUsername?: string;
}

export interface ChildSession {
  sessionToken: string;
  expiresAt: string;
  student: Student;
}

export interface Subject {
  id: string;
  name: string;
  area: SubjectArea;
  level: EducationLevel;
  grades: Grade[];
  icon: string;
  color: string;
  description: string;
}

export interface Lesson {
  id: string;
  subjectId: string;
  grade: Grade;
  difficulty: Difficulty;
  title: string;
  description: string;
  order: number;
}

export interface QuestionOption {
  id: string;
  label: string;
  value: string;
  image?: string;
}

export interface Question {
  id: string;
  prompt: string;
  helper?: string;
  type: 'single-choice' | 'match' | 'visual-choice' | 'text';
  image?: string;
  audio?: string;
  options: QuestionOption[];
  correctAnswer: string;
  pairs?: { left: string; right: string }[];
}

export interface Activity {
  id: string;
  lessonId: string;
  subjectId: string;
  grade: Grade;
  title: string;
  description: string;
  type: ActivityType;
  difficulty: Difficulty;
  order: number;
  points: number;
  questions: Question[];
}

export interface ProgressAttempt {
  id: string;
  studentId: string;
  activityId: string;
  subjectId: string;
  difficulty: Difficulty;
  score: number;
  totalQuestions: number;
  correctAnswers: number;
  stars: number;
  completedAt: string;
}

export interface Badge {
  id: string;
  name: string;
  description: string;
  icon: string;
  requirement: string;
  color?: string;
  category?: 'avance' | 'curso' | 'nivel' | 'constancia' | 'excelencia';
}

export interface Recommendation {
  title: string;
  detail: string;
  priority: 'alta' | 'media' | 'baja';
}
