import { activities, demoStudents } from '../data/demoContent';
import type { ProgressAttempt, Student } from '../types/education';

const STUDENTS_KEY = 'geniokids_students';
const ACTIVE_STUDENT_KEY = 'geniokids_active_student';
const ATTEMPTS_KEY = 'geniokids_attempts';
const FAILED_ACTIVITIES_KEY = 'geniokids_failed_activities';

function read<T>(key: string, fallback: T): T {
  try {
    const value = localStorage.getItem(key);
    return value ? (JSON.parse(value) as T) : fallback;
  } catch {
    return fallback;
  }
}

function write<T>(key: string, value: T) {
  localStorage.setItem(key, JSON.stringify(value));
}

export const localStore = {
  seed() {
    const current = read<Student[]>(STUDENTS_KEY, []);
    if (!current.length) write(STUDENTS_KEY, demoStudents);
    if (!localStorage.getItem(ACTIVE_STUDENT_KEY)) write(ACTIVE_STUDENT_KEY, demoStudents[0]);
  },

  getStudents(): Student[] {
    this.seed();
    return read<Student[]>(STUDENTS_KEY, demoStudents);
  },

  addStudent(student: Student) {
    const students = this.getStudents();
    write(STUDENTS_KEY, [...students, student]);
  },

  updateStudent(student: Student) {
    const students = this.getStudents().map((item) => item.id === student.id ? student : item);
    write(STUDENTS_KEY, students);
    const active = this.getActiveStudent();
    if (active.id === student.id) write(ACTIVE_STUDENT_KEY, student);
  },

  getActiveStudent(): Student {
    this.seed();
    return read<Student>(ACTIVE_STUDENT_KEY, demoStudents[0]);
  },

  setActiveStudent(student: Student) {
    write(ACTIVE_STUDENT_KEY, student);
  },

  getAttempts(): ProgressAttempt[] {
    return read<ProgressAttempt[]>(ATTEMPTS_KEY, []);
  },

  saveAttempt(attempt: ProgressAttempt) {
    const attempts = this.getAttempts();
    write(ATTEMPTS_KEY, [attempt, ...attempts]);
    this.clearActivityFailure(attempt.studentId, attempt.activityId);
  },

  getFailedActivityIds(studentId: string): string[] {
    const failures = read<{ studentId: string; activityId: string; failedAt: string }[]>(FAILED_ACTIVITIES_KEY, []);
    return failures
      .filter((item) => item.studentId === studentId)
      .map((item) => item.activityId);
  },

  markActivityFailed(studentId: string, activityId: string) {
    const failures = read<{ studentId: string; activityId: string; failedAt: string }[]>(FAILED_ACTIVITIES_KEY, []);
    const filtered = failures.filter((item) => !(item.studentId === studentId && item.activityId === activityId));
    write(FAILED_ACTIVITIES_KEY, [{ studentId, activityId, failedAt: new Date().toISOString() }, ...filtered]);
  },

  clearActivityFailure(studentId: string, activityId: string) {
    const failures = read<{ studentId: string; activityId: string; failedAt: string }[]>(FAILED_ACTIVITIES_KEY, []);
    write(FAILED_ACTIVITIES_KEY, failures.filter((item) => !(item.studentId === studentId && item.activityId === activityId)));
  },

  resetDemo() {
    localStorage.removeItem(STUDENTS_KEY);
    localStorage.removeItem(ACTIVE_STUDENT_KEY);
    localStorage.removeItem(ATTEMPTS_KEY);
    localStorage.removeItem(FAILED_ACTIVITIES_KEY);
    this.seed();
  },

  getCompletedActivities(studentId: string) {
    const attempts = this.getAttempts().filter((item) => item.studentId === studentId);
    return activities.filter((activity) => attempts.some((attempt) => attempt.activityId === activity.id));
  }
};
