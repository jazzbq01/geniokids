import type { Activity, Difficulty, DifficultyLevel, ProgressAttempt, Student, Subject } from '../types/education';
import { gradeLabels } from './gradeLabels';

const MIN_PASSING_NOTE = 15;
const LEVEL_UNLOCK_PERCENT = 75;

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

type WorksheetData = {
  name: string;
  sections: WorksheetSection[];
};

type ZipFile = {
  name: string;
  content: string | Uint8Array;
};

function sanitizeXmlValue(value: ExcelCellValue) {
  return String(value).replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F]/g, '');
}

function xmlEscape(value: ExcelCellValue) {
  return sanitizeXmlValue(value)
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

function uniqueSheetNames(names: string[]) {
  const used = new Set<string>();

  return names.map((rawName, index) => {
    const base = sanitizeSheetName(rawName || `Hoja ${index + 1}`);
    let name = base;
    let counter = 2;

    while (used.has(name.toLowerCase())) {
      const suffix = ` ${counter}`;
      name = `${base.slice(0, Math.max(1, 31 - suffix.length))}${suffix}`;
      counter += 1;
    }

    used.add(name.toLowerCase());
    return name;
  });
}

function scoreToNote20(score: number) {
  if (score <= 20) return Math.max(0, Math.min(20, Math.round(score)));
  return Math.max(0, Math.min(20, Math.round((score / 100) * 20)));
}

function scoreToPercent(score: number) {
  if (score <= 20) return Math.max(0, Math.min(100, Math.round((score / 20) * 100)));
  return Math.max(0, Math.min(100, Math.round(score)));
}

function requiredToUnlock(totalActivities: number) {
  return Math.ceil(totalActivities * (LEVEL_UNLOCK_PERCENT / 100));
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

function columnName(index: number) {
  let current = index;
  let name = '';

  while (current > 0) {
    const remainder = (current - 1) % 26;
    name = String.fromCharCode(65 + remainder) + name;
    current = Math.floor((current - 1) / 26);
  }

  return name;
}

function flattenRows(sections: WorksheetSection[]) {
  const rows: { values: ExcelCellValue[]; style: 'title' | 'header' | 'cell' | 'blank' }[] = [];

  sections.forEach((section, sectionIndex) => {
    if (sectionIndex > 0) rows.push({ values: [], style: 'blank' });
    if (section.title) rows.push({ values: [section.title], style: 'title' });

    section.rows.forEach((row, rowIndex) => {
      rows.push({
        values: row,
        style: rowIndex === 0 && section.rows.length > 1 ? 'header' : 'cell'
      });
    });
  });

  return rows;
}

function worksheetXml(sections: WorksheetSection[]) {
  const rows = flattenRows(sections);
  const maxColumns = rows.reduce((max, row) => Math.max(max, row.values.length), 1);
  const widths = Array.from({ length: maxColumns }, (_, colIndex) => {
    const maxLength = rows.reduce((max, row) => {
      const value = row.values[colIndex];
      return Math.max(max, value === undefined ? 0 : sanitizeXmlValue(value).length);
    }, 8);
    return Math.min(Math.max(maxLength + 2, 10), colIndex === 0 ? 34 : 44);
  });

  const colsXml = widths
    .map((width, index) => `<col min="${index + 1}" max="${index + 1}" width="${width}" customWidth="1"/>`)
    .join('');

  const rowsXml = rows
    .map((row, rowIndex) => {
      const rowNumber = rowIndex + 1;
      if (row.style === 'blank') return `<row r="${rowNumber}"/>`;

      const styleId = row.style === 'title' ? 1 : row.style === 'header' ? 2 : 3;
      const cellsXml = row.values
        .map((cell, colIndex) => {
          const cellReference = `${columnName(colIndex + 1)}${rowNumber}`;
          const isNumber = typeof cell === 'number' && Number.isFinite(cell);
          if (isNumber) return `<c r="${cellReference}" s="${styleId}"><v>${cell}</v></c>`;
          return `<c r="${cellReference}" s="${styleId}" t="inlineStr"><is><t>${xmlEscape(cell)}</t></is></c>`;
        })
        .join('');

      return `<row r="${rowNumber}">${cellsXml}</row>`;
    })
    .join('');

  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <cols>${colsXml}</cols>
  <sheetData>${rowsXml}</sheetData>
</worksheet>`;
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
    ['Regla de avance', 'Completar mínimo el 75% del nivel anterior para desbloquear el siguiente']
  ];

  const levelRows: ExcelCellValue[][] = [[
    'Nivel',
    'Total actividades',
    'Meta 75%',
    'Completadas',
    'Aprobadas',
    'Faltan para desbloquear',
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
    const target = requiredToUnlock(levelActivities.length);
    const missingToUnlock = Math.max(0, target - levelCompleted.length);
    const passed = levelCompleted.length >= target;

    levelRows.push([
      `${level.stageLabel} - ${level.name}`,
      levelActivities.length,
      target,
      levelCompleted.length,
      levelApproved.length,
      missingToUnlock,
      levelActivities.length - levelCompleted.length,
      levelAverage,
      advance,
      passed ? 'Desbloquea el siguiente nivel' : levelCompleted.length ? 'En progreso' : 'Pendiente'
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
    ['Criterio de desbloqueo', 'Mínimo 75% de actividades completadas por nivel']
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
      const target = requiredToUnlock(levelActivities.length);
      return completed.length < target;
    });

    courseRows.push([
      subject.name,
      activities.length,
      subjectCompleted.length,
      subjectApproved.length,
      activities.length - subjectCompleted.length,
      average,
      advance,
      currentLevel ? `${currentLevel.stageLabel} - ${currentLevel.name}` : 'Ruta completada',
      average >= MIN_PASSING_NOTE ? 'Buen avance. Mantener práctica constante.' : 'Reforzar con actividades del primer nivel disponible.'
    ]);
  });

  return [
    { title: 'Datos generales', rows: generalRows },
    { title: 'Resumen por curso', rows: courseRows }
  ];
}

function stylesXml() {
  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <fonts count="3">
    <font><sz val="11"/><name val="Calibri"/></font>
    <font><b/><sz val="14"/><name val="Calibri"/></font>
    <font><b/><sz val="11"/><name val="Calibri"/></font>
  </fonts>
  <fills count="4">
    <fill><patternFill patternType="none"/></fill>
    <fill><patternFill patternType="gray125"/></fill>
    <fill><patternFill patternType="solid"><fgColor rgb="FFDDEBFF"/><bgColor indexed="64"/></patternFill></fill>
    <fill><patternFill patternType="solid"><fgColor rgb="FFEAF7EA"/><bgColor indexed="64"/></patternFill></fill>
  </fills>
  <borders count="2">
    <border><left/><right/><top/><bottom/><diagonal/></border>
    <border><left/><right/><top/><bottom style="thin"><color rgb="FFEEEEEE"/></bottom><diagonal/></border>
  </borders>
  <cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>
  <cellXfs count="4">
    <xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>
    <xf numFmtId="0" fontId="1" fillId="2" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1"><alignment vertical="top" wrapText="1"/></xf>
    <xf numFmtId="0" fontId="2" fillId="3" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1"><alignment vertical="top" wrapText="1"/></xf>
    <xf numFmtId="0" fontId="0" fillId="0" borderId="1" xfId="0" applyBorder="1"><alignment vertical="top" wrapText="1"/></xf>
  </cellXfs>
  <cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>
</styleSheet>`;
}

function workbookXml(sheetNames: string[]) {
  const sheetsXml = sheetNames
    .map((name, index) => `<sheet name="${xmlEscape(name)}" sheetId="${index + 1}" r:id="rId${index + 1}"/>`)
    .join('');

  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>${sheetsXml}</sheets>
</workbook>`;
}

function workbookRelsXml(sheetCount: number) {
  const sheetRels = Array.from({ length: sheetCount }, (_, index) => (
    `<Relationship Id="rId${index + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet${index + 1}.xml"/>`
  )).join('');

  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  ${sheetRels}
  <Relationship Id="rId${sheetCount + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
</Relationships>`;
}

function rootRelsXml() {
  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
</Relationships>`;
}

function contentTypesXml(sheetCount: number) {
  const sheetOverrides = Array.from({ length: sheetCount }, (_, index) => (
    `<Override PartName="/xl/worksheets/sheet${index + 1}.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>`
  )).join('');

  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
  ${sheetOverrides}
</Types>`;
}

function makeXlsxBlob(worksheets: WorksheetData[]) {
  const sheetNames = uniqueSheetNames(worksheets.map((worksheet) => worksheet.name));
  const files: ZipFile[] = [
    { name: '[Content_Types].xml', content: contentTypesXml(worksheets.length) },
    { name: '_rels/.rels', content: rootRelsXml() },
    { name: 'xl/workbook.xml', content: workbookXml(sheetNames) },
    { name: 'xl/_rels/workbook.xml.rels', content: workbookRelsXml(worksheets.length) },
    { name: 'xl/styles.xml', content: stylesXml() },
    ...worksheets.map((worksheet, index) => ({
      name: `xl/worksheets/sheet${index + 1}.xml`,
      content: worksheetXml(worksheet.sections)
    }))
  ];

  return new Blob([createZip(files)], {
    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  });
}

export function downloadExcelReport(input: CourseReportInput) {
  const worksheets: WorksheetData[] = [
    { name: 'Resumen', sections: buildSummarySheet(input) },
    ...input.subjects.map((subject) => ({
      name: subject.name,
      sections: buildSubjectSections(subject, input.activitiesBySubject[subject.id] ?? [], input.attempts, input.levels, input.student)
    }))
  ];

  const blob = makeXlsxBlob(worksheets);
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  const cleanName = studentFileName(input.student.name);
  link.href = url;
  link.download = `reporte-geniokids-${cleanName}.xlsx`;
  document.body.appendChild(link);
  link.click();
  link.remove();
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

function textToBytes(text: string) {
  return new TextEncoder().encode(text);
}

function uint16(value: number) {
  const bytes = new Uint8Array(2);
  const view = new DataView(bytes.buffer);
  view.setUint16(0, value, true);
  return bytes;
}

function uint32(value: number) {
  const bytes = new Uint8Array(4);
  const view = new DataView(bytes.buffer);
  view.setUint32(0, value >>> 0, true);
  return bytes;
}

function concatBytes(parts: Uint8Array[]) {
  const totalLength = parts.reduce((sum, part) => sum + part.length, 0);
  const output = new Uint8Array(totalLength);
  let offset = 0;

  parts.forEach((part) => {
    output.set(part, offset);
    offset += part.length;
  });

  return output;
}

const crcTable = (() => {
  const table = new Uint32Array(256);
  for (let n = 0; n < 256; n += 1) {
    let c = n;
    for (let k = 0; k < 8; k += 1) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    table[n] = c >>> 0;
  }
  return table;
})();

function crc32(bytes: Uint8Array) {
  let crc = 0xffffffff;
  for (let i = 0; i < bytes.length; i += 1) crc = crcTable[(crc ^ bytes[i]) & 0xff] ^ (crc >>> 8);
  return (crc ^ 0xffffffff) >>> 0;
}

function createZip(files: ZipFile[]) {
  const localParts: Uint8Array[] = [];
  const centralParts: Uint8Array[] = [];
  let offset = 0;

  files.forEach((file) => {
    const nameBytes = textToBytes(file.name);
    const contentBytes = typeof file.content === 'string' ? textToBytes(file.content) : file.content;
    const checksum = crc32(contentBytes);
    const flags = 0x0800;
    const compressionMethod = 0;
    const dosTime = 0;
    const dosDate = 0;

    const localHeader = concatBytes([
      uint32(0x04034b50),
      uint16(20),
      uint16(flags),
      uint16(compressionMethod),
      uint16(dosTime),
      uint16(dosDate),
      uint32(checksum),
      uint32(contentBytes.length),
      uint32(contentBytes.length),
      uint16(nameBytes.length),
      uint16(0),
      nameBytes
    ]);

    localParts.push(localHeader, contentBytes);

    const centralHeader = concatBytes([
      uint32(0x02014b50),
      uint16(20),
      uint16(20),
      uint16(flags),
      uint16(compressionMethod),
      uint16(dosTime),
      uint16(dosDate),
      uint32(checksum),
      uint32(contentBytes.length),
      uint32(contentBytes.length),
      uint16(nameBytes.length),
      uint16(0),
      uint16(0),
      uint16(0),
      uint16(0),
      uint32(0),
      uint32(offset),
      nameBytes
    ]);

    centralParts.push(centralHeader);
    offset += localHeader.length + contentBytes.length;
  });

  const centralDirectory = concatBytes(centralParts);
  const localFiles = concatBytes(localParts);
  const endRecord = concatBytes([
    uint32(0x06054b50),
    uint16(0),
    uint16(0),
    uint16(files.length),
    uint16(files.length),
    uint32(centralDirectory.length),
    uint32(localFiles.length),
    uint16(0)
  ]);

  return concatBytes([localFiles, centralDirectory, endRecord]);
}
