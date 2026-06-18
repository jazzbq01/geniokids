import type { Activity, Difficulty, DifficultyLevel, ProgressAttempt, Student, Subject } from '../types/education';
import { gradeLabels } from './gradeLabels';

const MIN_PASSING_NOTE = 15;

type CourseReportInput = {
  student: Student;
  subjects: Subject[];
  activitiesBySubject: Record<string, Activity[]>;
  attempts: ProgressAttempt[];
  levels: DifficultyLevel[];
};

type ExcelCellValue = string | number;

type WorksheetSection = {
  title?: string;
  rows: ExcelCellValue[][];
};

function xmlEscape(value: ExcelCellValue) {
  return String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&apos;');
}

function sanitizeSheetName(name: string) {
  const cleaned = name.replace(/[\\/?*\[\]:]/g, ' ').trim();
  return (cleaned || 'Hoja').slice(0, 31);
}

function scoreToNote20(score: number) {
  if (score <= 20) return Math.max(0, Math.min(20, Math.round(score)));
  return Math.max(0, Math.min(20, Math.round((score / 100) * 20)));
}

function scoreToPercent(score: number) {
  if (score <= 20) return Math.max(0, Math.min(100, Math.round((score / 20) * 100)));
  return Math.max(0, Math.min(100, Math.round(score)));
}

function bestAttemptsByActivity(attempts: ProgressAttempt[]) {
  const best = new Map<string, ProgressAttempt>();

  attempts.forEach((attempt) => {
    const current = best.get(attempt.activityId);
    const currentScore = current ? scoreToPercent(current.score) : -1;
    const incomingScore = scoreToPercent(attempt.score);
    if (!current || incomingScore > currentScore) best.set(attempt.activityId, attempt);
  });

  return best;
}

function levelLabel(levelId: Difficulty, levels: DifficultyLevel[]) {
  const level = levels.find((item) => item.id === levelId);
  return level ? `${level.stageLabel} - ${level.name}` : levelId;
}

function activityStatus(attempt?: ProgressAttempt) {
  if (!attempt) return 'Pendiente';
  return scoreToNote20(attempt.score) >= MIN_PASSING_NOTE ? 'Aprobada' : 'Por reforzar';
}

function recommendationFor(attempt?: ProgressAttempt) {
  if (!attempt) return 'Aún no resuelta. Sugerir práctica corta de 10 minutos.';
  const note = scoreToNote20(attempt.score);
  if (note >= 18) return 'Muy buen dominio. Puede avanzar o repetir como repaso rápido.';
  if (note >= MIN_PASSING_NOTE) return 'Logró el mínimo. Conviene reforzar antes de subir dificultad.';
  return 'Requiere refuerzo. Repetir la actividad con acompañamiento.';
}

function worksheetXml(name: string, sections: WorksheetSection[]) {
  const rowsXml: string[] = [];

  sections.forEach((section, sectionIndex) => {
    if (sectionIndex > 0) rowsXml.push('<Row/>');
    if (section.title) {
      rowsXml.push(
        `<Row><Cell ss:StyleID="Title"><Data ss:Type="String">${xmlEscape(section.title)}</Data></Cell></Row>`
      );
    }

    section.rows.forEach((row, rowIndex) => {
      const style = rowIndex === 0 && section.rows.length > 1 ? 'Header' : 'Cell';
      const cells = row.map((cell) => {
        const isNumber = typeof cell === 'number' && Number.isFinite(cell);
        return `<Cell ss:StyleID="${style}"><Data ss:Type="${isNumber ? 'Number' : 'String'}">${xmlEscape(cell)}</Data></Cell>`;
      }).join('');
      rowsXml.push(`<Row>${cells}</Row>`);
    });
  });

  return `
    <Worksheet ss:Name="${xmlEscape(sanitizeSheetName(name))}">
      <Table>${rowsXml.join('\n')}</Table>
    </Worksheet>`;
}

function buildSubjectSections(subject: Subject, activities: Activity[], attempts: ProgressAttempt[], levels: DifficultyLevel[], student: Student): WorksheetSection[] {
  const best = bestAttemptsByActivity(attempts.filter((attempt) => attempt.subjectId === subject.id));
  const completed = activities.filter((activity) => best.has(activity.id));
  const approved = completed.filter((activity) => scoreToNote20(best.get(activity.id)?.score ?? 0) >= MIN_PASSING_NOTE);
  const averageNote = completed.length
    ? Math.round(completed.reduce((sum, activity) => sum + scoreToNote20(best.get(activity.id)?.score ?? 0), 0) / completed.length)
    : 0;

  const generalRows: ExcelCellValue[][] = [
    ['Estudiante', student.name],
    ['Grado / edad', gradeLabels[student.grade] ?? student.grade],
    ['Curso', subject.name],
    ['Actividades del curso', activities.length],
    ['Actividades resueltas', completed.length],
    ['Actividades aprobadas', approved.length],
    ['Promedio del curso /20', averageNote],
<<<<<<< HEAD
    ['Regla de avance', 'Completar mínimo el 75% del nivel anterior para desbloquear el siguiente']
=======
    ['Regla de avance', 'Mínimo 15/20 o 75% para superar el nivel']
>>>>>>> 676f2e59bc23dde938b9ec0b6df86099c6e75694
  ];

  const levelRows: ExcelCellValue[][] = [[
    'Nivel',
    'Total actividades',
    'Resueltas',
    'Aprobadas',
    'Pendientes',
    'Promedio /20',
    'Avance %',
    'Estado del nivel'
  ]];

  levels.forEach((level) => {
    const levelActivities = activities.filter((activity) => activity.difficulty === level.id);
    if (!levelActivities.length) return;
    const levelCompleted = levelActivities.filter((activity) => best.has(activity.id));
    const levelApproved = levelCompleted.filter((activity) => scoreToNote20(best.get(activity.id)?.score ?? 0) >= MIN_PASSING_NOTE);
    const levelAverage = levelCompleted.length
      ? Math.round(levelCompleted.reduce((sum, activity) => sum + scoreToNote20(best.get(activity.id)?.score ?? 0), 0) / levelCompleted.length)
      : 0;
    const advance = levelActivities.length ? Math.round((levelCompleted.length / levelActivities.length) * 100) : 0;
<<<<<<< HEAD
    const passed = advance >= 75;
=======
    const passed = levelAverage >= MIN_PASSING_NOTE || levelCompleted.length === levelActivities.length;
>>>>>>> 676f2e59bc23dde938b9ec0b6df86099c6e75694

    levelRows.push([
      `${level.icon} ${level.stageLabel} - ${level.name}`,
      levelActivities.length,
      levelCompleted.length,
      levelApproved.length,
      levelActivities.length - levelCompleted.length,
      levelAverage,
      advance,
      passed ? 'Superado' : levelCompleted.length ? 'En progreso' : 'Pendiente'
    ]);
  });

  const detailRows: ExcelCellValue[][] = [[
    'Nivel',
    'N.º',
    'Actividad',
    'Estado',
    'Nota /20',
    'Porcentaje',
    'Correctas',
    'Total preguntas',
    'Estrellas',
    'Fecha',
    'Recomendación'
  ]];

  activities
    .slice()
    .sort((a, b) => a.difficulty.localeCompare(b.difficulty) || a.order - b.order)
    .forEach((activity) => {
      const attempt = best.get(activity.id);
      detailRows.push([
        levelLabel(activity.difficulty, levels),
        activity.order,
        activity.title,
        activityStatus(attempt),
        attempt ? scoreToNote20(attempt.score) : '',
        attempt ? `${scoreToPercent(attempt.score)}%` : '',
        attempt?.correctAnswers ?? '',
        attempt?.totalQuestions ?? '',
        attempt?.stars ?? '',
        attempt ? new Date(attempt.completedAt).toLocaleString('es-PE') : '',
        recommendationFor(attempt)
      ]);
    });

  return [
    { title: `Resumen de ${subject.name}`, rows: generalRows },
    { title: 'Resumen por nivel', rows: levelRows },
    { title: 'Detalle de actividades', rows: detailRows }
  ];
}

function buildSummarySheet(input: CourseReportInput): WorksheetSection[] {
  const { student, subjects, activitiesBySubject, attempts, levels } = input;
  const best = bestAttemptsByActivity(attempts);

  const generalRows: ExcelCellValue[][] = [
    ['Reporte educativo GenioKids'],
    ['Estudiante', student.name],
    ['Grado / edad', gradeLabels[student.grade] ?? student.grade],
    ['Nivel educativo', student.level === 'primaria' ? 'Primaria' : 'Inicial'],
    ['Fecha de exportación', new Date().toLocaleString('es-PE')],
<<<<<<< HEAD
    ['Criterio de desbloqueo', 'Mínimo 75% de actividades completadas por nivel']
=======
    ['Criterio de aprobación', '15/20 o 75%']
>>>>>>> 676f2e59bc23dde938b9ec0b6df86099c6e75694
  ];

  const courseRows: ExcelCellValue[][] = [[
    'Curso',
    'Actividades',
    'Resueltas',
    'Aprobadas',
    'Pendientes',
    'Promedio /20',
    'Avance %',
    'Nivel actual sugerido',
    'Recomendación'
  ]];

  subjects.forEach((subject) => {
    const activities = activitiesBySubject[subject.id] ?? [];
    const subjectCompleted = activities.filter((activity) => best.has(activity.id));
    const subjectApproved = subjectCompleted.filter((activity) => scoreToNote20(best.get(activity.id)?.score ?? 0) >= MIN_PASSING_NOTE);
    const average = subjectCompleted.length
      ? Math.round(subjectCompleted.reduce((sum, activity) => sum + scoreToNote20(best.get(activity.id)?.score ?? 0), 0) / subjectCompleted.length)
      : 0;
    const advance = activities.length ? Math.round((subjectCompleted.length / activities.length) * 100) : 0;
    const currentLevel = levels.find((level) => {
      const levelActivities = activities.filter((activity) => activity.difficulty === level.id);
      if (!levelActivities.length) return false;
      const completed = levelActivities.filter((activity) => best.has(activity.id));
      const avg = completed.length
        ? Math.round(completed.reduce((sum, activity) => sum + scoreToNote20(best.get(activity.id)?.score ?? 0), 0) / completed.length)
        : 0;
      return completed.length < levelActivities.length || avg < MIN_PASSING_NOTE;
    });

    courseRows.push([
      subject.name,
      activities.length,
      subjectCompleted.length,
      subjectApproved.length,
      activities.length - subjectCompleted.length,
      average,
      advance,
      currentLevel ? `${currentLevel.icon} ${currentLevel.name}` : 'Ruta completada',
      average >= MIN_PASSING_NOTE ? 'Buen avance. Mantener práctica constante.' : 'Reforzar con actividades del primer nivel disponible.'
    ]);
  });

  return [
    { title: 'Datos generales', rows: generalRows },
    { title: 'Resumen por curso', rows: courseRows }
  ];
}

export function downloadExcelReport(input: CourseReportInput) {
  const summary = worksheetXml('Resumen', buildSummarySheet(input));
  const subjectSheets = input.subjects.map((subject) => {
    const activities = input.activitiesBySubject[subject.id] ?? [];
    return worksheetXml(subject.name, buildSubjectSections(subject, activities, input.attempts, input.levels, input.student));
  }).join('\n');

  const workbook = `<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
  xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:x="urn:schemas-microsoft-com:office:excel"
  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">
  <Styles>
    <Style ss:ID="Title"><Font ss:Bold="1" ss:Size="14"/><Interior ss:Color="#DDEBFF" ss:Pattern="Solid"/></Style>
    <Style ss:ID="Header"><Font ss:Bold="1"/><Interior ss:Color="#EAF7EA" ss:Pattern="Solid"/><Borders><Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/></Borders></Style>
    <Style ss:ID="Cell"><Alignment ss:Vertical="Top"/><Borders><Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#EEEEEE"/></Borders></Style>
  </Styles>
  ${summary}
  ${subjectSheets}
</Workbook>`;

  const blob = new Blob([workbook], { type: 'application/vnd.ms-excel;charset=utf-8;' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  const cleanName = studentFileName(input.student.name);
  link.href = url;
  link.download = `reporte-geniokids-${cleanName}.xls`;
  link.click();
  URL.revokeObjectURL(url);
}

function studentFileName(name: string) {
  return name
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-zA-Z0-9]+/g, '-')
    .replace(/^-|-$/g, '')
    .toLowerCase() || 'estudiante';
}
