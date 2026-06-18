import { activities, badges, difficultyLevels, lessons, subjects } from '../data/demoContent';
import { isSupabaseConfigured } from '../lib/env';
import { supabase } from '../lib/supabase';
import { localStore } from './localStore';
import type { Activity, Badge, ChildSession, DifficultyLevel, Gender, Grade, Lesson, ProgressAttempt, Student, Subject } from '../types/education';

const CHILD_SESSION_KEY = 'gk_child_session';

function getStoredChildSession(): ChildSession | null {
  try {
    const raw = localStorage.getItem(CHILD_SESSION_KEY);
    if (!raw) return null;
    const session = JSON.parse(raw) as ChildSession;
    if (new Date(session.expiresAt).getTime() <= Date.now()) {
      localStorage.removeItem(CHILD_SESSION_KEY);
      return null;
    }
    return session;
  } catch {
    return null;
  }
}

function mapStudent(row: any): Student {
  return {
    id: row.id ?? row.student_id,
    parentId: row.parent_id ?? row.parentId,
    name: row.name,
    age: row.age,
    grade: row.grade,
    level: row.level,
    avatar: row.avatar ?? avatarByGender(row.gender, row.level),
    gender: row.gender ?? 'other',
    childUsername: row.child_username ?? row.childUsername
  };
}

function avatarByGender(gender: Gender, level: string) {
  if (gender === 'female') return level === 'inicial' ? '👧🏻' : '👩🏻‍🎓';
  if (gender === 'male') return level === 'inicial' ? '👦🏻' : '👨🏻‍🎓';
  return '🧒🏻';
}

function mapSubject(row: any): Subject {
  return {
    id: row.id,
    name: row.name,
    area: row.area,
    level: row.level,
    grades: row.grades ?? [],
    icon: row.icon,
    color: row.color,
    description: row.description ?? ''
  };
}

function mapDifficultyLevel(row: any): DifficultyLevel {
  return {
    id: row.id,
    name: row.name,
    shortName: row.short_name,
    stageLabel: row.stage_label,
    description: row.description ?? '',
    icon: row.icon,
    color: row.color,
    order: row.order_number ?? 1
  };
}

function mapLesson(row: any): Lesson {
  return {
    id: row.id,
    subjectId: row.subject_id,
    grade: row.grade,
    difficulty: row.difficulty_level_id,
    title: row.title,
    description: row.description ?? '',
    order: row.order_number ?? 1
  };
}

function mapActivity(row: any): Activity {
  const mappedActivity = {
    id: row.id,
    lessonId: row.lesson_id,
    subjectId: row.subject_id,
    grade: row.grade,
    title: row.title,
    description: row.description ?? '',
    type: row.activity_type,
    difficulty: row.difficulty_level_id,
    order: row.order_number ?? 1,
    points: row.points ?? 1,

    // Campos nuevos para juegos interactivos
    gameType: row.game_type ?? row.gameType ?? null,
    gameConfig: row.game_config ?? row.gameConfig ?? {},
    assetTheme: row.asset_theme ?? row.assetTheme ?? null,
    estimatedSeconds: row.estimated_seconds ?? row.estimatedSeconds ?? null,

    // También dejamos las claves originales por si algún componente las lee así
    game_type: row.game_type ?? row.gameType ?? null,
    game_config: row.game_config ?? row.gameConfig ?? {},
    asset_theme: row.asset_theme ?? row.assetTheme ?? null,
    estimated_seconds: row.estimated_seconds ?? row.estimatedSeconds ?? null,

    questions: (row.questions ?? [])
      .slice()
      .sort((a: any, b: any) => (a.order_number ?? 1) - (b.order_number ?? 1))
      .map((question: any) => ({
        id: question.id,
        prompt: question.prompt,
        helper: question.helper ?? undefined,
        type: question.question_type,
        image: question.image_url ?? undefined,
        audio: question.audio_url ?? undefined,
        imageUrl: question.image_url ?? null,
        audioUrl: question.audio_url ?? null,
        image_url: question.image_url ?? null,
        audio_url: question.audio_url ?? null,
        options: question.options ?? [],
        correctAnswer: question.correct_answer ?? '',
        correct_answer: question.correct_answer ?? '',
        pairs: question.pairs ?? [],

        // Campos nuevos para juegos interactivos
        gameConfig: question.game_config ?? question.gameConfig ?? {},
        game_config: question.game_config ?? question.gameConfig ?? {},
        feedbackSuccess: question.feedback_success ?? null,
        feedback_success: question.feedback_success ?? null,
        feedbackError: question.feedback_error ?? null,
        feedback_error: question.feedback_error ?? null,
        hint: question.hint ?? null
      }))
  };

  return mappedActivity as Activity;
}

function mapBadge(row: any): Badge {
  return {
    id: row.id,
    name: row.name,
    description: row.description ?? '',
    icon: row.icon,
    requirement: row.requirement ?? '',
    color: row.color ?? undefined,
    category: row.category ?? undefined
  };
}

function mapAttempt(row: any): ProgressAttempt {
  return {
    id: String(row.id),
    studentId: String(row.student_id),
    activityId: String(row.activity_id),
    subjectId: String(row.subject_id),
    difficulty: row.difficulty_level_id,
    score: Number(row.score ?? 0),
    totalQuestions: Number(row.total_questions ?? 0),
    correctAnswers: Number(row.correct_answers ?? 0),
    stars: Number(row.stars ?? 0),
    completedAt: row.completed_at ?? row.created_at ?? new Date().toISOString()
  };
}

async function requireUserId() {
  if (!supabase) throw new Error('Supabase no está configurado.');
  const { data, error } = await supabase.auth.getUser();
  if (error || !data.user) throw new Error('Debes iniciar sesión como padre/madre.');
  return data.user.id;
}

export const educationService = {
  async loginChild(username: string, pin: string): Promise<ChildSession> {
    if (!isSupabaseConfigured || !supabase) {
      throw new Error('Supabase no está configurado.');
    }

    const { data, error } = await supabase.rpc('login_child', {
      p_child_username: username.trim().toLowerCase(),
      p_pin: pin
    });

    if (error) throw new Error(error.message);
    const row = Array.isArray(data) ? data[0] : data;
    if (!row) throw new Error('Usuario o clave del hijo incorrectos.');

    return {
      sessionToken: row.session_token,
      expiresAt: row.expires_at,
      student: mapStudent({
        id: row.student_id,
        parent_id: row.parent_id,
        name: row.name,
        age: row.age,
        grade: row.grade,
        level: row.level,
        avatar: row.avatar,
        gender: row.gender,
        child_username: row.child_username
      })
    };
  },

  async getStudents(): Promise<Student[]> {
    const childSession = getStoredChildSession();
    if (childSession) return [childSession.student];

    if (!isSupabaseConfigured || !supabase) return localStore.getStudents();

    const { data, error } = await supabase
      .from('students')
      .select('id, parent_id, name, age, grade, level, avatar, gender, child_username')
      .order('created_at', { ascending: true });

    if (error) throw new Error(error.message);
    return (data ?? []).map(mapStudent);
  },

  async addStudent(student: Student, pin = '1234'): Promise<Student> {
    if (!isSupabaseConfigured || !supabase) {
      localStore.addStudent(student);
      return student;
    }

    await requireUserId();
    const { data, error } = await supabase.rpc('create_child_student', {
      p_name: student.name,
      p_age: student.age,
      p_grade: student.grade,
      p_level: student.level,
      p_gender: student.gender,
      p_child_username: student.childUsername,
      p_pin: pin
    });

    if (error) throw new Error(error.message);
    const row = Array.isArray(data) ? data[0] : data;
    return mapStudent(row);
  },

  async updateStudent(student: Student, newPin?: string): Promise<Student> {
    if (!isSupabaseConfigured || !supabase) {
      localStore.updateStudent(student);
      return student;
    }

    await requireUserId();
    const { data, error } = await supabase.rpc('update_child_student', {
      p_student_id: student.id,
      p_name: student.name,
      p_age: student.age,
      p_grade: student.grade,
      p_level: student.level,
      p_gender: student.gender,
      p_child_username: student.childUsername,
      p_new_pin: newPin && newPin.trim().length ? newPin : null
    });

    if (error) throw new Error(error.message);
    const row = Array.isArray(data) ? data[0] : data;
    return mapStudent(row);
  },

  async getDifficultyLevels(): Promise<DifficultyLevel[]> {
    if (!isSupabaseConfigured || !supabase) return difficultyLevels;

    const { data, error } = await supabase
      .from('difficulty_levels')
      .select('id, name, short_name, stage_label, description, icon, color, order_number')
      .eq('is_active', true)
      .order('order_number', { ascending: true });

    if (error) throw new Error(error.message);
    return (data ?? []).map(mapDifficultyLevel);
  },

  async getSubjectsByGrade(grade: Grade): Promise<Subject[]> {
    if (!isSupabaseConfigured || !supabase) {
      return subjects.filter((subject) => subject.grades.includes(grade));
    }

    const { data, error } = await supabase
      .from('subjects')
      .select('id, name, area, level, grades, icon, color, description')
      .contains('grades', [grade])
      .eq('is_active', true)
      .order('name', { ascending: true });

    if (error) throw new Error(error.message);
    return (data ?? []).map(mapSubject);
  },

  async getSubject(subjectId: string): Promise<Subject | undefined> {
    if (!isSupabaseConfigured || !supabase) return subjects.find((subject) => subject.id === subjectId);

    const { data, error } = await supabase
      .from('subjects')
      .select('id, name, area, level, grades, icon, color, description')
      .eq('id', subjectId)
      .eq('is_active', true)
      .maybeSingle();

    if (error) throw new Error(error.message);
    return data ? mapSubject(data) : undefined;
  },

  async getLessons(subjectId: string, grade: Grade): Promise<Lesson[]> {
    if (!isSupabaseConfigured || !supabase) {
      return lessons
        .filter((lesson) => lesson.subjectId === subjectId && lesson.grade === grade)
        .sort((a, b) => a.order - b.order);
    }

    const { data, error } = await supabase
      .from('lessons')
      .select('id, subject_id, grade, difficulty_level_id, title, description, order_number')
      .eq('subject_id', subjectId)
      .eq('grade', grade)
      .eq('is_active', true)
      .order('order_number', { ascending: true });

    if (error) throw new Error(error.message);
    return (data ?? []).map(mapLesson);
  },

  async getActivities(subjectId: string, grade: Grade): Promise<Activity[]> {
    if (!isSupabaseConfigured || !supabase) {
      return activities
        .filter((activity) => activity.subjectId === subjectId && activity.grade === grade)
        .sort((a, b) => a.difficulty.localeCompare(b.difficulty) || a.order - b.order);
    }

    const { data, error } = await supabase
      .from('activities')
      .select(`
        id,
        lesson_id,
        subject_id,
        grade,
        title,
        description,
        activity_type,
        game_type,
        game_config,
        asset_theme,
        estimated_seconds,
        difficulty_level_id,
        order_number,
        points,
        questions (
          id,
          prompt,
          helper,
          question_type,
          image_url,
          audio_url,
          correct_answer,
          options,
          pairs,
          game_config,
          feedback_success,
          feedback_error,
          hint,
          order_number
        )
      `)
      .eq('subject_id', subjectId)
      .eq('grade', grade)
      .eq('is_active', true)
      .order('difficulty_level_id', { ascending: true })
      .order('order_number', { ascending: true });

    if (error) throw new Error(error.message);
    return (data ?? []).map(mapActivity);
  },

  async getActivity(activityId: string): Promise<Activity | undefined> {
    if (!isSupabaseConfigured || !supabase) return activities.find((activity) => activity.id === activityId);

    const { data, error } = await supabase
      .from('activities')
      .select(`
        id,
        lesson_id,
        subject_id,
        grade,
        title,
        description,
        activity_type,
        game_type,
        game_config,
        asset_theme,
        estimated_seconds,
        difficulty_level_id,
        order_number,
        points,
        questions (
          id,
          prompt,
          helper,
          question_type,
          image_url,
          audio_url,
          correct_answer,
          options,
          pairs,
          game_config,
          feedback_success,
          feedback_error,
          hint,
          order_number
        )
      `)
      .eq('id', activityId)
      .eq('is_active', true)
      .maybeSingle();

    if (error) throw new Error(error.message);
    return data ? mapActivity(data) : undefined;
  },

  async saveAttempt(attempt: ProgressAttempt) {
    const childSession = getStoredChildSession();
    if (!isSupabaseConfigured || !supabase) {
      localStore.saveAttempt(attempt);
      return;
    }

    if (childSession) {
      const { error } = await supabase.rpc('submit_child_attempt', {
        p_session_token: childSession.sessionToken,
        p_activity_id: attempt.activityId,
        p_subject_id: attempt.subjectId,
        p_difficulty_level_id: attempt.difficulty,
        p_score: attempt.score,
        p_total_questions: attempt.totalQuestions,
        p_correct_answers: attempt.correctAnswers,
        p_stars: attempt.stars
      });
      if (error) throw new Error(error.message);
      return;
    }

    const { error } = await supabase.from('activity_attempts').insert({
      id: attempt.id,
      student_id: attempt.studentId,
      activity_id: attempt.activityId,
      subject_id: attempt.subjectId,
      difficulty_level_id: attempt.difficulty,
      score: attempt.score,
      total_questions: attempt.totalQuestions,
      correct_answers: attempt.correctAnswers,
      stars: attempt.stars,
      completed_at: attempt.completedAt
    });

    if (error) throw new Error(error.message);
  },

  async getAttempts(studentId?: string): Promise<ProgressAttempt[]> {
    const childSession = getStoredChildSession();
    if (!isSupabaseConfigured || !supabase) {
      const attempts = localStore.getAttempts();
      return studentId ? attempts.filter((attempt) => attempt.studentId === studentId) : attempts;
    }

    if (childSession) {
      const { data, error } = await supabase.rpc('get_child_attempts', {
        p_session_token: childSession.sessionToken
      });
      if (error) throw new Error(error.message);
      return (data ?? []).map(mapAttempt);
    }

    let query = supabase
      .from('activity_attempts')
      .select('id, student_id, activity_id, subject_id, difficulty_level_id, score, total_questions, correct_answers, stars, completed_at')
      .order('completed_at', { ascending: false });

    if (studentId) query = query.eq('student_id', studentId);

    const { data, error } = await query;
    if (error) throw new Error(error.message);
    return (data ?? []).map(mapAttempt);
  },

  getFailedActivityIds(studentId: string): string[] {
    return localStore.getFailedActivityIds(studentId);
  },

  markActivityFailed(studentId: string, activityId: string) {
    localStore.markActivityFailed(studentId, activityId);
  },

  clearActivityFailure(studentId: string, activityId: string) {
    localStore.clearActivityFailure(studentId, activityId);
  },

  async getBadges(): Promise<Badge[]> {
    if (!isSupabaseConfigured || !supabase) return badges;

    const { data, error } = await supabase
      .from('badges')
      .select('id, name, description, icon, requirement, color, category')
      .order('order_number', { ascending: true });

    if (error) throw new Error(error.message);
    return (data ?? []).map(mapBadge);
  }
};
