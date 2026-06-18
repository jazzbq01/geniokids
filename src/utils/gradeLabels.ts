import type { Grade } from '../types/education';

export const gradeLabels: Record<Grade, string> = {
  '3-anios': 'Inicial 3 años',
  '4-anios': 'Inicial 4 años',
  '5-anios': 'Inicial 5 años',
  '1-primaria': '1.º primaria',
  '2-primaria': '2.º primaria',
  '3-primaria': '3.º primaria',
  '4-primaria': '4.º primaria',
  '5-primaria': '5.º primaria',
  '6-primaria': '6.º primaria'
};

export const initialGrades: Grade[] = ['3-anios', '4-anios', '5-anios'];
export const primaryGrades: Grade[] = ['1-primaria', '2-primaria', '3-primaria', '4-primaria', '5-primaria', '6-primaria'];

export function isInitialGrade(grade: Grade) {
  return initialGrades.includes(grade);
}
