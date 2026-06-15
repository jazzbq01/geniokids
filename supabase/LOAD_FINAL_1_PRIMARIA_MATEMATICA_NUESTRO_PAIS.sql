-- =============================================================
-- GenioKids - CARGA FINAL 1.º Primaria
-- Ejecuta este archivo si quieres cargar en una sola corrida:
-- 1) Cursos obligatorios de Primaria
-- 2) Matemática 1.º primaria: 250 actividades
-- 3) Nuestro País 1.º primaria: 250 actividades
-- No elimina estudiantes ni usuarios hijos.
-- =============================================================

-- =============================================================
-- GenioKids - Cursos obligatorios de Primaria 1.º a 6.º
-- Ejecutar en Supabase SQL Editor.
-- No elimina estudiantes ni avances.
-- =============================================================

alter table public.subjects drop constraint if exists subjects_area_check;
alter table public.subjects add constraint subjects_area_check
check (area in ('matematica','comunicacion','ingles','ciencia','razonamiento','juegos','nuestro_pais','educacion_financiera','tutoria'));

insert into public.subjects (id, name, area, level, grades, icon, color, description, is_active) values
('mat-primaria', 'Matemática', 'matematica', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🧮', '#6c5ce7', 'Operaciones, problemas, patrones, medidas, geometría, dinero y pensamiento matemático por grado.', true),
('com-primaria', 'Comunicación', 'comunicacion', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '✍️', '#00b894', 'Lectoescritura, comprensión, oralidad, gramática, ortografía y producción de textos.', true),
('nuestro-pais-primaria', 'Nuestro País', 'nuestro_pais', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🇵🇪', '#2ecc71', 'Familia, localidad, escuela, convivencia, ciudadanía, buen trato e identidad peruana.', true),
('educacion-financiera-primaria', 'Educación Financiera', 'educacion_financiera', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '💰', '#f39c12', 'Ahorro, necesidades, deseos, consumo responsable, dinero, presupuesto y decisiones financieras.', true),
('tutoria-primaria', 'Tutoría', 'tutoria', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '💛', '#e84393', 'Emociones, autocuidado, convivencia, proyecto de vida, vínculos y toma de decisiones.', true),
('logic-primaria', 'Razonamiento', 'razonamiento', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🧠', '#a29bfe', 'Patrones, secuencias, clasificación, comparación, inferencias y pensamiento lógico.', true),
('eng-primaria', 'Inglés', 'ingles', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🗣️', '#0984e3', 'Vocabulario, saludos, frases simples, escucha y práctica guiada por grado.', true),
('sci-primaria', 'Ciencia y ambiente', 'ciencia', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🔬', '#00cec9', 'Seres vivos, cuerpo humano, salud, ambiente, materia, energía y cuidado del entorno.', true)
on conflict (id) do update set
  name = excluded.name,
  area = excluded.area,
  level = excluded.level,
  grades = excluded.grades,
  icon = excluded.icon,
  color = excluded.color,
  description = excluded.description,
  is_active = true;

notify pgrst, 'reload schema';


-- =============================================================
-- GenioKids - Matemática 1.º primaria ampliado a 250 actividades
-- Referencia pedagógica: Cuaderno de trabajo Matemática 1, primer grado 2022 - MINEDU.
-- Contenido original para app: no copia páginas ni imágenes del PDF.
-- Estructura: 5 niveles x 50 actividades = 250 actividades.
-- Regla: desbloqueo por promedio mínimo 15/20 o por completar el nivel anterior.
-- =============================================================

-- Permite 50 actividades por nivel. Si tu BD tenía límite 20, este bloque lo amplía.
alter table public.activities drop constraint if exists activities_order_number_check;
alter table public.activities add constraint activities_order_number_check check (order_number between 1 and 50);

update public.subjects set name = 'Matemática', description = 'Ruta curricular de Matemática por grado. Para 1.º primaria incluye 250 actividades originales basadas en conteo, números, patrones, tablas, figuras, sumas, restas, decenas, dinero, doble y mitad.' where id = 'mat-primaria';
delete from public.lessons where subject_id = 'mat-primaria' and grade = '1-primaria';

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'semilla', '🌱 Semilla Genial - Conteo y números 1 al 10', 'Números 1 al 10, conteo visual, juntar y quitar cantidades pequeñas.', 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-01', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta dinosaurios', 'Reconoce la cantidad 1 contando dinosaurios. Cada actividad vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-01-01', 'act-mat1-semilla-01', 'Cuenta: 🦖. ¿Cuántos dinosaurios hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '1', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-02', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta trompos', 'Reconoce la cantidad 2 contando trompos. Cada actividad vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-02-01', 'act-mat1-semilla-02', 'Cuenta: 🪀🪀. ¿Cuántos trompos hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-03', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta pelotas', 'Reconoce la cantidad 3 contando pelotas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-03-01', 'act-mat1-semilla-03', 'Cuenta: ⚽⚽⚽. ¿Cuántos pelotas hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-04', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta cubos', 'Reconoce la cantidad 4 contando cubos. Cada actividad vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-04-01', 'act-mat1-semilla-04', 'Cuenta: 🧱🧱🧱🧱. ¿Cuántos cubos hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '4', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-05', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta manzanas', 'Reconoce la cantidad 5 contando manzanas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-05-01', 'act-mat1-semilla-05', 'Cuenta: 🍎🍎🍎🍎🍎. ¿Cuántos manzanas hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-06', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta pollitos', 'Reconoce la cantidad 6 contando pollitos. Cada actividad vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-06-01', 'act-mat1-semilla-06', 'Cuenta: 🐣🐣🐣🐣🐣🐣. ¿Cuántos pollitos hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-07', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta estrellas', 'Reconoce la cantidad 7 contando estrellas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-07-01', 'act-mat1-semilla-07', 'Cuenta: ⭐⭐⭐⭐⭐⭐⭐. ¿Cuántos estrellas hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '7', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-08', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta caramelos', 'Reconoce la cantidad 8 contando caramelos. Cada actividad vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-08-01', 'act-mat1-semilla-08', 'Cuenta: 🍬🍬🍬🍬🍬🍬🍬🍬. ¿Cuántos caramelos hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-09', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta flores', 'Reconoce la cantidad 9 contando flores. Cada actividad vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-09-01', 'act-mat1-semilla-09', 'Cuenta: 🌼🌼🌼🌼🌼🌼🌼🌼🌼. ¿Cuántos flores hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-10', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Cuenta dedos', 'Reconoce la cantidad 10 contando dedos. Cada actividad vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-10-01', 'act-mat1-semilla-10', 'Cuenta: ✋✋✋✋✋✋✋✋✋✋. ¿Cuántos dedos hay?', 'Cuenta uno por uno y elige el número correcto.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-11', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 1', 'Asocia el numeral 1 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-11-01', 'act-mat1-semilla-11', '¿Qué número representa esta cantidad? ●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '1', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-12', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 2', 'Asocia el numeral 2 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-12-01', 'act-mat1-semilla-12', '¿Qué número representa esta cantidad? ●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-13', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 3', 'Asocia el numeral 3 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-13-01', 'act-mat1-semilla-13', '¿Qué número representa esta cantidad? ●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-14', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 4', 'Asocia el numeral 4 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-14-01', 'act-mat1-semilla-14', '¿Qué número representa esta cantidad? ●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '4', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-15', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 5', 'Asocia el numeral 5 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-15-01', 'act-mat1-semilla-15', '¿Qué número representa esta cantidad? ●●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-16', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 6', 'Asocia el numeral 6 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-16-01', 'act-mat1-semilla-16', '¿Qué número representa esta cantidad? ●●●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-17', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 7', 'Asocia el numeral 7 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-17-01', 'act-mat1-semilla-17', '¿Qué número representa esta cantidad? ●●●●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '7', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-18', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 8', 'Asocia el numeral 8 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-18-01', 'act-mat1-semilla-18', '¿Qué número representa esta cantidad? ●●●●●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-19', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 9', 'Asocia el numeral 9 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-19-01', 'act-mat1-semilla-19', '¿Qué número representa esta cantidad? ●●●●●●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-20', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Reconoce el número 10', 'Asocia el numeral 10 con su cantidad. Cada actividad vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-20-01', 'act-mat1-semilla-20', '¿Qué número representa esta cantidad? ●●●●●●●●●●', 'Observa la cantidad de puntos y relaciónala con su número.', 'single-choice', '10', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-21', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 1 y 1', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-21-01', 'act-mat1-semilla-21', 'Junta 1 semillas y 1 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-22', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 1 y 2', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-22-01', 'act-mat1-semilla-22', 'Junta 1 semillas y 2 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-23', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 2 y 1', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-23-01', 'act-mat1-semilla-23', 'Junta 2 semillas y 1 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-24', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 2 y 2', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-24-01', 'act-mat1-semilla-24', 'Junta 2 semillas y 2 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '4', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-25', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 2 y 3', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-25-01', 'act-mat1-semilla-25', 'Junta 2 semillas y 3 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-26', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 3 y 2', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-26-01', 'act-mat1-semilla-26', 'Junta 3 semillas y 2 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-27', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 3 y 3', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-27-01', 'act-mat1-semilla-27', 'Junta 3 semillas y 3 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-28', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 4 y 1', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-28-01', 'act-mat1-semilla-28', 'Junta 4 semillas y 1 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-29', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 4 y 2', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-29-01', 'act-mat1-semilla-29', 'Junta 4 semillas y 2 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-30', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 5 y 1', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-30-01', 'act-mat1-semilla-30', 'Junta 5 semillas y 1 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-31', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 5 y 2', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-31-01', 'act-mat1-semilla-31', 'Junta 5 semillas y 2 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '7', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-32', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 6 y 1', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-32-01', 'act-mat1-semilla-32', 'Junta 6 semillas y 1 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '7', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-33', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 6 y 2', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-33-01', 'act-mat1-semilla-33', 'Junta 6 semillas y 2 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-34', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 7 y 1', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-34-01', 'act-mat1-semilla-34', 'Junta 7 semillas y 1 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-35', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Junta 6 y 3', 'Junta cantidades pequeñas hasta 10. Cada actividad vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-35-01', 'act-mat1-semilla-35', 'Junta 6 semillas y 3 semillas. ¿Cuántas hay en total?', 'Cuando juntas, cuentas todos los objetos.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-36', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 1 de 5', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-36-01', 'act-mat1-semilla-36', 'Había 5 globos y se fueron 1. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '4', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-37', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 2 de 5', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-37-01', 'act-mat1-semilla-37', 'Había 5 globos y se fueron 2. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-38', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 1 de 6', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-38-01', 'act-mat1-semilla-38', 'Había 6 globos y se fueron 1. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-39', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 3 de 6', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-39-01', 'act-mat1-semilla-39', 'Había 6 globos y se fueron 3. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-40', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 2 de 7', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-40-01', 'act-mat1-semilla-40', 'Había 7 globos y se fueron 2. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-41', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 3 de 8', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-41-01', 'act-mat1-semilla-41', 'Había 8 globos y se fueron 3. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-42', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 4 de 9', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-42-01', 'act-mat1-semilla-42', 'Había 9 globos y se fueron 4. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-43', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 5 de 10', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-43-01', 'act-mat1-semilla-43', 'Había 10 globos y se fueron 5. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-44', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 1 de 4', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-44-01', 'act-mat1-semilla-44', 'Había 4 globos y se fueron 1. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-45', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Quita 1 de 3', 'Practica quitar cantidades pequeñas. Cada actividad vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-45-01', 'act-mat1-semilla-45', 'Había 3 globos y se fueron 1. ¿Cuántos quedan?', 'Quitar significa que queda una cantidad menor.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-46', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Completa hasta 10 desde 1', 'Busca cuánto falta para llegar a diez. Cada actividad vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-46-01', 'act-mat1-semilla-46', 'Tengo 1 fichas. ¿Cuántas faltan para tener 10?', 'Cuenta desde el número dado hasta llegar a 10.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-47', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Completa hasta 10 desde 2', 'Busca cuánto falta para llegar a diez. Cada actividad vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-47-01', 'act-mat1-semilla-47', 'Tengo 2 fichas. ¿Cuántas faltan para tener 10?', 'Cuenta desde el número dado hasta llegar a 10.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-48', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Completa hasta 10 desde 3', 'Busca cuánto falta para llegar a diez. Cada actividad vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-48-01', 'act-mat1-semilla-48', 'Tengo 3 fichas. ¿Cuántas faltan para tener 10?', 'Cuenta desde el número dado hasta llegar a 10.', 'single-choice', '7', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-49', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Completa hasta 10 desde 4', 'Busca cuánto falta para llegar a diez. Cada actividad vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-49-01', 'act-mat1-semilla-49', 'Tengo 4 fichas. ¿Cuántas faltan para tener 10?', 'Cuenta desde el número dado hasta llegar a 10.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-semilla-50', 'les-mat-primaria-1p-semilla', 'mat-primaria', '1-primaria', 'Completa hasta 10 desde 5', 'Busca cuánto falta para llegar a diez. Cada actividad vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-semilla-50-01', 'act-mat1-semilla-50', 'Tengo 5 fichas. ¿Cuántas faltan para tener 10?', 'Cuenta desde el número dado hasta llegar a 10.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'explorador', '🔎 Explorador Curioso - Orden, comparación y patrones', 'Comparación, orden, posiciones, patrones, tablas y figuras simples.', 2, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-01', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 3 y 5', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-01-01', 'act-mat1-explorador-01', '¿Cuál número es mayor: 3 o 5?', 'Mayor significa que representa más cantidad.', 'single-choice', '5', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-02', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 7 y 4', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-02-01', 'act-mat1-explorador-02', '¿Cuál número es mayor: 7 o 4?', 'Mayor significa que representa más cantidad.', 'single-choice', '7', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-03', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 9 y 6', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-03-01', 'act-mat1-explorador-03', '¿Cuál número es mayor: 9 o 6?', 'Mayor significa que representa más cantidad.', 'single-choice', '9', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-04', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Compara 8 y 8', 'Identifica igualdad o mayor cantidad. Cada actividad vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-04-01', 'act-mat1-explorador-04', 'Compara 8 y 8. ¿Qué relación es correcta?', 'Si ambos números son iguales, tienen la misma cantidad.', 'single-choice', 'son iguales', '[{"id": "a", "label": "8 es mayor", "value": "8 es mayor"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "8 es mayor", "value": "8 es mayor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-05', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 12 y 15', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-05-01', 'act-mat1-explorador-05', '¿Cuál número es mayor: 12 o 15?', 'Mayor significa que representa más cantidad.', 'single-choice', '15', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-06', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 18 y 14', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-06-01', 'act-mat1-explorador-06', '¿Cuál número es mayor: 18 o 14?', 'Mayor significa que representa más cantidad.', 'single-choice', '18', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "18", "value": "18"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-07', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 20 y 19', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-07-01', 'act-mat1-explorador-07', '¿Cuál número es mayor: 20 o 19?', 'Mayor significa que representa más cantidad.', 'single-choice', '20', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "19", "value": "19"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-08', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 11 y 13', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-08-01', 'act-mat1-explorador-08', '¿Cuál número es mayor: 11 o 13?', 'Mayor significa que representa más cantidad.', 'single-choice', '13', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "13", "value": "13"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-09', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 16 y 10', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-09-01', 'act-mat1-explorador-09', '¿Cuál número es mayor: 16 o 10?', 'Mayor significa que representa más cantidad.', 'single-choice', '16', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "16", "value": "16"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-10', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número mayor entre 6 y 2', 'Compara dos números. Cada actividad vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-10-01', 'act-mat1-explorador-10', '¿Cuál número es mayor: 6 o 2?', 'Mayor significa que representa más cantidad.', 'single-choice', '6', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-11', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 3 y 5', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-11-01', 'act-mat1-explorador-11', '¿Cuál número es menor: 3 o 5?', 'Menor significa que representa menos cantidad.', 'single-choice', '3', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-12', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 7 y 4', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-12-01', 'act-mat1-explorador-12', '¿Cuál número es menor: 7 o 4?', 'Menor significa que representa menos cantidad.', 'single-choice', '4', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-13', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 9 y 6', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-13-01', 'act-mat1-explorador-13', '¿Cuál número es menor: 9 o 6?', 'Menor significa que representa menos cantidad.', 'single-choice', '6', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-14', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 12 y 15', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-14-01', 'act-mat1-explorador-14', '¿Cuál número es menor: 12 o 15?', 'Menor significa que representa menos cantidad.', 'single-choice', '12', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "15", "value": "15"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-15', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 18 y 14', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-15-01', 'act-mat1-explorador-15', '¿Cuál número es menor: 18 o 14?', 'Menor significa que representa menos cantidad.', 'single-choice', '14', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "14", "value": "14"}, {"id": "c", "label": "18", "value": "18"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-16', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 20 y 19', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-16-01', 'act-mat1-explorador-16', '¿Cuál número es menor: 20 o 19?', 'Menor significa que representa menos cantidad.', 'single-choice', '19', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "19", "value": "19"}, {"id": "c", "label": "20", "value": "20"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-17', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 11 y 13', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-17-01', 'act-mat1-explorador-17', '¿Cuál número es menor: 11 o 13?', 'Menor significa que representa menos cantidad.', 'single-choice', '11', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "13", "value": "13"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-18', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 16 y 10', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-18-01', 'act-mat1-explorador-18', '¿Cuál número es menor: 16 o 10?', 'Menor significa que representa menos cantidad.', 'single-choice', '10', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "16", "value": "16"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-19', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 6 y 2', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-19-01', 'act-mat1-explorador-19', '¿Cuál número es menor: 6 o 2?', 'Menor significa que representa menos cantidad.', 'single-choice', '2', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-20', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Número menor entre 2 y 8', 'Reconoce el número menor. Cada actividad vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-20-01', 'act-mat1-explorador-20', '¿Cuál número es menor: 2 o 8?', 'Menor significa que representa menos cantidad.', 'single-choice', '2', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-21', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 4', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-21-01', 'act-mat1-explorador-21', 'Completa la serie: 1, 2, 3, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '4', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-22', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 7', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-22-01', 'act-mat1-explorador-22', 'Completa la serie: 4, 5, 6, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '7', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-23', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 10', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-23-01', 'act-mat1-explorador-23', 'Completa la serie: 7, 8, 9, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-24', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 13', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-24-01', 'act-mat1-explorador-24', 'Completa la serie: 10, 11, 12, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '13', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "13", "value": "13"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-25', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 8', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-25-01', 'act-mat1-explorador-25', 'Completa la serie: 2, 4, 6, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '8', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-26', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 20', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-26-01', 'act-mat1-explorador-26', 'Completa la serie: 5, 10, 15, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '20', '[{"id": "a", "label": "19", "value": "19"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "21", "value": "21"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-27', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 14', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-27-01', 'act-mat1-explorador-27', 'Completa la serie: 20, 18, 16, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '14', '[{"id": "a", "label": "13", "value": "13"}, {"id": "b", "label": "14", "value": "14"}, {"id": "c", "label": "15", "value": "15"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-28', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 12', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-28-01', 'act-mat1-explorador-28', 'Completa la serie: 3, 6, 9, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '12', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "13", "value": "13"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-29', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 7', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-29-01', 'act-mat1-explorador-29', 'Completa la serie: 1, 3, 5, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '7', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-30', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Serie hasta 15', 'Continúa patrones numéricos. Cada actividad vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-30-01', 'act-mat1-explorador-30', 'Completa la serie: 9, 11, 13, __', 'Mira cuánto aumenta o disminuye cada paso.', 'single-choice', '15', '[{"id": "a", "label": "14", "value": "14"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "16", "value": "16"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-31', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 1', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-31-01', 'act-mat1-explorador-31', 'Sigue el patrón: 🔴 🔵 🔴 🔵 __', 'Identifica la parte que se repite.', 'single-choice', '🔴', '[{"id": "a", "label": "🔵", "value": "🔵"}, {"id": "b", "label": "🟡", "value": "🟡"}, {"id": "c", "label": "🔴", "value": "🔴"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-32', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 2', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-32-01', 'act-mat1-explorador-32', 'Sigue el patrón: ⭐ ⭐ 🌙 ⭐ ⭐ 🌙 __', 'Identifica la parte que se repite.', 'single-choice', '⭐', '[{"id": "a", "label": "🌙", "value": "🌙"}, {"id": "b", "label": "☀️", "value": "☀️"}, {"id": "c", "label": "⭐", "value": "⭐"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-33', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 3', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-33-01', 'act-mat1-explorador-33', 'Sigue el patrón: 🟢 🟢 🟠 🟢 🟢 🟠 __', 'Identifica la parte que se repite.', 'single-choice', '🟢', '[{"id": "a", "label": "🟠", "value": "🟠"}, {"id": "b", "label": "🔵", "value": "🔵"}, {"id": "c", "label": "🟢", "value": "🟢"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-34', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 4', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-34-01', 'act-mat1-explorador-34', 'Sigue el patrón: ▲ ■ ▲ ■ __', 'Identifica la parte que se repite.', 'single-choice', '▲', '[{"id": "a", "label": "■", "value": "■"}, {"id": "b", "label": "●", "value": "●"}, {"id": "c", "label": "▲", "value": "▲"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-35', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 5', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-35-01', 'act-mat1-explorador-35', 'Sigue el patrón: 🍎 🍐 🍎 🍐 __', 'Identifica la parte que se repite.', 'single-choice', '🍎', '[{"id": "a", "label": "🍐", "value": "🍐"}, {"id": "b", "label": "🍌", "value": "🍌"}, {"id": "c", "label": "🍎", "value": "🍎"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-36', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 6', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-36-01', 'act-mat1-explorador-36', 'Sigue el patrón: 1 2 1 2 __', 'Identifica la parte que se repite.', 'single-choice', '1', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-37', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 7', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-37-01', 'act-mat1-explorador-37', 'Sigue el patrón: 🐶 🐱 🐶 🐱 __', 'Identifica la parte que se repite.', 'single-choice', '🐶', '[{"id": "a", "label": "🐱", "value": "🐱"}, {"id": "b", "label": "🐭", "value": "🐭"}, {"id": "c", "label": "🐶", "value": "🐶"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-38', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 8', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-38-01', 'act-mat1-explorador-38', 'Sigue el patrón: ☀️ 🌧️ ☀️ 🌧️ __', 'Identifica la parte que se repite.', 'single-choice', '☀️', '[{"id": "a", "label": "❄️", "value": "❄️"}, {"id": "b", "label": "☀️", "value": "☀️"}, {"id": "c", "label": "🌧️", "value": "🌧️"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-39', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 9', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-39-01', 'act-mat1-explorador-39', 'Sigue el patrón: A B A B __', 'Identifica la parte que se repite.', 'single-choice', 'a', '[{"id": "a", "label": "B", "value": "b"}, {"id": "b", "label": "C", "value": "c"}, {"id": "c", "label": "A", "value": "a"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-40', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Patrón visual 10', 'Reconoce y continúa patrones. Cada actividad vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-40-01', 'act-mat1-explorador-40', 'Sigue el patrón: 2 2 4 2 2 4 __', 'Identifica la parte que se repite.', 'single-choice', '2', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-41', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Reconoce triángulo', 'Identifica figuras y líneas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-41-01', 'act-mat1-explorador-41', '¿Qué figura o línea cumple esto: 3 lados?', 'Observa las características de la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-42', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Reconoce cuadrado', 'Identifica figuras y líneas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-42-01', 'act-mat1-explorador-42', '¿Qué figura o línea cumple esto: 4 lados iguales?', 'Observa las características de la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-43', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Reconoce círculo', 'Identifica figuras y líneas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-43-01', 'act-mat1-explorador-43', '¿Qué figura o línea cumple esto: no tiene lados rectos?', 'Observa las características de la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-44', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Reconoce rectángulo', 'Identifica figuras y líneas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-44-01', 'act-mat1-explorador-44', '¿Qué figura o línea cumple esto: 4 lados y lados opuestos iguales?', 'Observa las características de la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-45', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Reconoce línea recta', 'Identifica figuras y líneas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-45-01', 'act-mat1-explorador-45', '¿Qué figura o línea cumple esto: camino sin curva?', 'Observa las características de la figura.', 'single-choice', 'línea recta', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "línea recta", "value": "línea recta"}, {"id": "c", "label": "línea curva", "value": "línea curva"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-46', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Lee tabla plátano', 'Interpreta datos en tablas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-46-01', 'act-mat1-explorador-46', 'La tabla muestra 3 para el primer grupo y 5 para el segundo. ¿Cuál tiene más?', 'Compara las cantidades y elige la mayor.', 'single-choice', 'plátano', '[{"id": "a", "label": "el otro grupo", "value": "el otro grupo"}, {"id": "b", "label": "hay empate", "value": "hay empate"}, {"id": "c", "label": "plátano", "value": "plátano"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-47', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Lee tabla rojo', 'Interpreta datos en tablas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-47-01', 'act-mat1-explorador-47', 'La tabla muestra 6 para el primer grupo y 4 para el segundo. ¿Cuál tiene más?', 'Compara las cantidades y elige la mayor.', 'single-choice', 'rojo', '[{"id": "a", "label": "el otro grupo", "value": "el otro grupo"}, {"id": "b", "label": "hay empate", "value": "hay empate"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-48', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Lee tabla gatos', 'Interpreta datos en tablas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-48-01', 'act-mat1-explorador-48', 'La tabla muestra 2 para el primer grupo y 7 para el segundo. ¿Cuál tiene más?', 'Compara las cantidades y elige la mayor.', 'single-choice', 'gatos', '[{"id": "a", "label": "hay empate", "value": "hay empate"}, {"id": "b", "label": "gatos", "value": "gatos"}, {"id": "c", "label": "el otro grupo", "value": "el otro grupo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-49', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Lee datos iguales', 'Interpreta tablas simples. Cada actividad vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-49-01', 'act-mat1-explorador-49', 'Una tabla muestra 8 votos para A y 8 para B. ¿Qué sucede?', 'Si tienen el mismo número, hay empate.', 'single-choice', 'hay empate', '[{"id": "a", "label": "gana A", "value": "gana a"}, {"id": "b", "label": "gana B", "value": "gana b"}, {"id": "c", "label": "hay empate", "value": "hay empate"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-explorador-50', 'les-mat-primaria-1p-explorador', 'mat-primaria', '1-primaria', 'Lee tabla perros', 'Interpreta datos en tablas. Cada actividad vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-explorador-50-01', 'act-mat1-explorador-50', 'La tabla muestra 9 para el primer grupo y 5 para el segundo. ¿Cuál tiene más?', 'Compara las cantidades y elige la mayor.', 'single-choice', 'perros', '[{"id": "a", "label": "perros", "value": "perros"}, {"id": "b", "label": "el otro grupo", "value": "el otro grupo"}, {"id": "c", "label": "hay empate", "value": "hay empate"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'aventurero', '🧭 Aventurero Ágil - Decenas y problemas hasta 20', 'Decenas, números hasta 20, representación, problemas de juntar, agregar y quitar.', 3, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-01', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 0 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-01-01', 'act-mat1-aventurero-01', '1 decena y 0 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '10', '[{"id": "a", "label": "20", "value": "20"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "0", "value": "0"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-02', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 1 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-02-01', 'act-mat1-aventurero-02', '1 decena y 1 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '11', '[{"id": "a", "label": "21", "value": "21"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-03', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 2 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-03-01', 'act-mat1-aventurero-03', '1 decena y 2 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '12', '[{"id": "a", "label": "22", "value": "22"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-04', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 3 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-04-01', 'act-mat1-aventurero-04', '1 decena y 3 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '13', '[{"id": "a", "label": "23", "value": "23"}, {"id": "b", "label": "13", "value": "13"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-05', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 4 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-05-01', 'act-mat1-aventurero-05', '1 decena y 4 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '14', '[{"id": "a", "label": "24", "value": "24"}, {"id": "b", "label": "14", "value": "14"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-06', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 5 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-06-01', 'act-mat1-aventurero-06', '1 decena y 5 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '15', '[{"id": "a", "label": "25", "value": "25"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-07', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 6 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-07-01', 'act-mat1-aventurero-07', '1 decena y 6 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '16', '[{"id": "a", "label": "26", "value": "26"}, {"id": "b", "label": "16", "value": "16"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-08', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 7 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-08-01', 'act-mat1-aventurero-08', '1 decena y 7 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '17', '[{"id": "a", "label": "27", "value": "27"}, {"id": "b", "label": "17", "value": "17"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-09', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 8 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-09-01', 'act-mat1-aventurero-09', '1 decena y 8 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '18', '[{"id": "a", "label": "28", "value": "28"}, {"id": "b", "label": "18", "value": "18"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-10', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', '1 decena y 9 unidades', 'Representa números con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-10-01', 'act-mat1-aventurero-10', '1 decena y 9 unidades forman el número:', 'Una decena vale 10 unidades.', 'single-choice', '19', '[{"id": "a", "label": "29", "value": "29"}, {"id": "b", "label": "19", "value": "19"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-11', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 11', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-11-01', 'act-mat1-aventurero-11', 'El número 11 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '1', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "0", "value": "0"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-12', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 12', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-12-01', 'act-mat1-aventurero-12', 'El número 12 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-13', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 13', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-13-01', 'act-mat1-aventurero-13', 'El número 13 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '3', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-14', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 14', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-14-01', 'act-mat1-aventurero-14', 'El número 14 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '4', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-15', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 15', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-15-01', 'act-mat1-aventurero-15', 'El número 15 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-16', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 16', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-16-01', 'act-mat1-aventurero-16', 'El número 16 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '6', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-17', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 17', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-17-01', 'act-mat1-aventurero-17', 'El número 17 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '7', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-18', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 18', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-18-01', 'act-mat1-aventurero-18', 'El número 18 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '8', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-19', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 19', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-19-01', 'act-mat1-aventurero-19', 'El número 19 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '9', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-20', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Representa 20', 'Relaciona número con decenas y unidades. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-20-01', 'act-mat1-aventurero-20', 'El número 20 tiene 1 decena y ¿cuántas unidades?', 'Resta 10 para conocer las unidades.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-21', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 9+4', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-21-01', 'act-mat1-aventurero-21', '9 + 4 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '13', '[{"id": "a", "label": "14", "value": "14"}, {"id": "b", "label": "13", "value": "13"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-22', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 8+7', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-22-01', 'act-mat1-aventurero-22', '8 + 7 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '15', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-23', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 10+5', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-23-01', 'act-mat1-aventurero-23', '10 + 5 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '15', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-24', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 12+3', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-24-01', 'act-mat1-aventurero-24', '12 + 3 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '15', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-25', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 11+6', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-25-01', 'act-mat1-aventurero-25', '11 + 6 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '17', '[{"id": "a", "label": "18", "value": "18"}, {"id": "b", "label": "17", "value": "17"}, {"id": "c", "label": "16", "value": "16"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-26', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 13+4', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-26-01', 'act-mat1-aventurero-26', '13 + 4 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '17', '[{"id": "a", "label": "18", "value": "18"}, {"id": "b", "label": "17", "value": "17"}, {"id": "c", "label": "16", "value": "16"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-27', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 14+2', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-27-01', 'act-mat1-aventurero-27', '14 + 2 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '16', '[{"id": "a", "label": "17", "value": "17"}, {"id": "b", "label": "16", "value": "16"}, {"id": "c", "label": "15", "value": "15"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-28', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 15+5', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-28-01', 'act-mat1-aventurero-28', '15 + 5 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '20', '[{"id": "a", "label": "21", "value": "21"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "19", "value": "19"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-29', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 16+3', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-29-01', 'act-mat1-aventurero-29', '16 + 3 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '19', '[{"id": "a", "label": "20", "value": "20"}, {"id": "b", "label": "19", "value": "19"}, {"id": "c", "label": "18", "value": "18"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-30', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Suma 7+8', 'Resuelve sumas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-30-01', 'act-mat1-aventurero-30', '7 + 8 =', 'Puedes completar una decena y luego sumar lo que falta.', 'single-choice', '15', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-31', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 15-4', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-31-01', 'act-mat1-aventurero-31', '15 - 4 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '11', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-32', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 18-6', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-32-01', 'act-mat1-aventurero-32', '18 - 6 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '12', '[{"id": "a", "label": "13", "value": "13"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-33', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 20-5', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-33-01', 'act-mat1-aventurero-33', '20 - 5 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '15', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-34', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 17-8', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-34-01', 'act-mat1-aventurero-34', '17 - 8 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-35', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 16-7', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-35-01', 'act-mat1-aventurero-35', '16 - 7 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-36', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 14-3', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-36-01', 'act-mat1-aventurero-36', '14 - 3 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '11', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-37', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 19-9', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-37-01', 'act-mat1-aventurero-37', '19 - 9 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-38', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 13-5', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-38-01', 'act-mat1-aventurero-38', '13 - 5 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-39', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 12-4', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-39-01', 'act-mat1-aventurero-39', '12 - 4 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-40', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Resta 11-2', 'Resuelve restas hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-40-01', 'act-mat1-aventurero-40', '11 - 2 =', 'Quita la segunda cantidad a la primera.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-41', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 12 y 15', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-41-01', 'act-mat1-aventurero-41', '¿Cuál es mayor: 12 o 15?', 'Compara decenas y unidades.', 'single-choice', '15', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-42', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 18 y 11', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-42-01', 'act-mat1-aventurero-42', '¿Cuál es mayor: 18 o 11?', 'Compara decenas y unidades.', 'single-choice', '18', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "18", "value": "18"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-43', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 20 y 16', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-43-01', 'act-mat1-aventurero-43', '¿Cuál es mayor: 20 o 16?', 'Compara decenas y unidades.', 'single-choice', '20', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "16", "value": "16"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-44', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 14 y 19', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-44-01', 'act-mat1-aventurero-44', '¿Cuál es mayor: 14 o 19?', 'Compara decenas y unidades.', 'single-choice', '19', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "19", "value": "19"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-45', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Compara 17 y 17', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-45-01', 'act-mat1-aventurero-45', 'Compara 17 y 17.', 'Si tienen el mismo valor, son iguales.', 'single-choice', 'son iguales', '[{"id": "a", "label": "17 es mayor", "value": "17 es mayor"}, {"id": "b", "label": "son iguales", "value": "son iguales"}, {"id": "c", "label": "17 es mayor", "value": "17 es mayor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-46', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 13 y 10', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-46-01', 'act-mat1-aventurero-46', '¿Cuál es mayor: 13 o 10?', 'Compara decenas y unidades.', 'single-choice', '13', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "13", "value": "13"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-47', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 9 y 18', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-47-01', 'act-mat1-aventurero-47', '¿Cuál es mayor: 9 o 18?', 'Compara decenas y unidades.', 'single-choice', '18', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "18", "value": "18"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-48', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 16 y 12', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-48-01', 'act-mat1-aventurero-48', '¿Cuál es mayor: 16 o 12?', 'Compara decenas y unidades.', 'single-choice', '16', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "16", "value": "16"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-49', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 11 y 20', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-49-01', 'act-mat1-aventurero-49', '¿Cuál es mayor: 11 o 20?', 'Compara decenas y unidades.', 'single-choice', '20', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-aventurero-50', 'les-mat-primaria-1p-aventurero', 'mat-primaria', '1-primaria', 'Mayor hasta 20: 15 y 7', 'Compara números hasta 20. Cada actividad vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-aventurero-50-01', 'act-mat1-aventurero-50', '¿Cuál es mayor: 15 o 7?', 'Compara decenas y unidades.', 'single-choice', '15', '[{"id": "a", "label": "son iguales", "value": "son iguales"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'estrella', '⭐ Estrella Brillante - Operaciones, datos y geometría', 'Sumas, restas, gráficos, medición, recta numérica, figuras y cuerpos geométricos.', 4, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-01', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 20+5', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-01-01', 'act-mat1-estrella-01', '20 + 5 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '25', '[{"id": "a", "label": "26", "value": "26"}, {"id": "b", "label": "25", "value": "25"}, {"id": "c", "label": "24", "value": "24"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-02', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 21+8', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-02-01', 'act-mat1-estrella-02', '21 + 8 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '29', '[{"id": "a", "label": "30", "value": "30"}, {"id": "b", "label": "29", "value": "29"}, {"id": "c", "label": "28", "value": "28"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-03', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 24+6', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-03-01', 'act-mat1-estrella-03', '24 + 6 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '30', '[{"id": "a", "label": "31", "value": "31"}, {"id": "b", "label": "30", "value": "30"}, {"id": "c", "label": "29", "value": "29"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-04', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 17+14', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-04-01', 'act-mat1-estrella-04', '17 + 14 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '31', '[{"id": "a", "label": "32", "value": "32"}, {"id": "b", "label": "31", "value": "31"}, {"id": "c", "label": "30", "value": "30"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-05', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 18+12', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-05-01', 'act-mat1-estrella-05', '18 + 12 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '30', '[{"id": "a", "label": "31", "value": "31"}, {"id": "b", "label": "30", "value": "30"}, {"id": "c", "label": "29", "value": "29"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-06', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 19+15', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-06-01', 'act-mat1-estrella-06', '19 + 15 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '34', '[{"id": "a", "label": "35", "value": "35"}, {"id": "b", "label": "34", "value": "34"}, {"id": "c", "label": "33", "value": "33"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-07', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 23+9', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-07-01', 'act-mat1-estrella-07', '23 + 9 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '32', '[{"id": "a", "label": "33", "value": "33"}, {"id": "b", "label": "32", "value": "32"}, {"id": "c", "label": "31", "value": "31"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-08', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 25+10', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-08-01', 'act-mat1-estrella-08', '25 + 10 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '35', '[{"id": "a", "label": "36", "value": "36"}, {"id": "b", "label": "35", "value": "35"}, {"id": "c", "label": "34", "value": "34"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-09', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 26+7', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-09-01', 'act-mat1-estrella-09', '26 + 7 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '33', '[{"id": "a", "label": "34", "value": "34"}, {"id": "b", "label": "33", "value": "33"}, {"id": "c", "label": "32", "value": "32"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-10', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 28+11', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-10-01', 'act-mat1-estrella-10', '28 + 11 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '39', '[{"id": "a", "label": "40", "value": "40"}, {"id": "b", "label": "39", "value": "39"}, {"id": "c", "label": "38", "value": "38"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-11', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 30+5', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-11-01', 'act-mat1-estrella-11', '30 + 5 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '35', '[{"id": "a", "label": "36", "value": "36"}, {"id": "b", "label": "35", "value": "35"}, {"id": "c", "label": "34", "value": "34"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-12', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 31+6', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-12-01', 'act-mat1-estrella-12', '31 + 6 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '37', '[{"id": "a", "label": "38", "value": "38"}, {"id": "b", "label": "37", "value": "37"}, {"id": "c", "label": "36", "value": "36"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-13', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 22+13', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-13-01', 'act-mat1-estrella-13', '22 + 13 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '35', '[{"id": "a", "label": "36", "value": "36"}, {"id": "b", "label": "35", "value": "35"}, {"id": "c", "label": "34", "value": "34"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-14', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 16+16', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-14-01', 'act-mat1-estrella-14', '16 + 16 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '32', '[{"id": "a", "label": "33", "value": "33"}, {"id": "b", "label": "32", "value": "32"}, {"id": "c", "label": "31", "value": "31"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-15', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Suma con estrategia 27+8', 'Practica sumas con y sin canje. Cada actividad vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-15-01', 'act-mat1-estrella-15', '27 + 8 =', 'Agrupa decenas y unidades para sumar.', 'single-choice', '35', '[{"id": "a", "label": "36", "value": "36"}, {"id": "b", "label": "35", "value": "35"}, {"id": "c", "label": "34", "value": "34"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-16', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 30-5', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-16-01', 'act-mat1-estrella-16', '30 - 5 =', 'Separa decenas y unidades para restar.', 'single-choice', '25', '[{"id": "a", "label": "26", "value": "26"}, {"id": "b", "label": "25", "value": "25"}, {"id": "c", "label": "24", "value": "24"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-17', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 35-10', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-17-01', 'act-mat1-estrella-17', '35 - 10 =', 'Separa decenas y unidades para restar.', 'single-choice', '25', '[{"id": "a", "label": "26", "value": "26"}, {"id": "b", "label": "25", "value": "25"}, {"id": "c", "label": "24", "value": "24"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-18', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 28-7', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-18-01', 'act-mat1-estrella-18', '28 - 7 =', 'Separa decenas y unidades para restar.', 'single-choice', '21', '[{"id": "a", "label": "22", "value": "22"}, {"id": "b", "label": "21", "value": "21"}, {"id": "c", "label": "20", "value": "20"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-19', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 40-12', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-19-01', 'act-mat1-estrella-19', '40 - 12 =', 'Separa decenas y unidades para restar.', 'single-choice', '28', '[{"id": "a", "label": "29", "value": "29"}, {"id": "b", "label": "28", "value": "28"}, {"id": "c", "label": "27", "value": "27"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-20', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 33-8', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-20-01', 'act-mat1-estrella-20', '33 - 8 =', 'Separa decenas y unidades para restar.', 'single-choice', '25', '[{"id": "a", "label": "26", "value": "26"}, {"id": "b", "label": "25", "value": "25"}, {"id": "c", "label": "24", "value": "24"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-21', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 36-6', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-21-01', 'act-mat1-estrella-21', '36 - 6 =', 'Separa decenas y unidades para restar.', 'single-choice', '30', '[{"id": "a", "label": "31", "value": "31"}, {"id": "b", "label": "30", "value": "30"}, {"id": "c", "label": "29", "value": "29"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-22', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 29-14', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-22-01', 'act-mat1-estrella-22', '29 - 14 =', 'Separa decenas y unidades para restar.', 'single-choice', '15', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "15", "value": "15"}, {"id": "c", "label": "14", "value": "14"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-23', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 31-9', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-23-01', 'act-mat1-estrella-23', '31 - 9 =', 'Separa decenas y unidades para restar.', 'single-choice', '22', '[{"id": "a", "label": "23", "value": "23"}, {"id": "b", "label": "22", "value": "22"}, {"id": "c", "label": "21", "value": "21"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-24', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 25-11', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-24-01', 'act-mat1-estrella-24', '25 - 11 =', 'Separa decenas y unidades para restar.', 'single-choice', '14', '[{"id": "a", "label": "15", "value": "15"}, {"id": "b", "label": "14", "value": "14"}, {"id": "c", "label": "13", "value": "13"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-25', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 38-18', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-25-01', 'act-mat1-estrella-25', '38 - 18 =', 'Separa decenas y unidades para restar.', 'single-choice', '20', '[{"id": "a", "label": "21", "value": "21"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "19", "value": "19"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-26', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 27-5', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-26-01', 'act-mat1-estrella-26', '27 - 5 =', 'Separa decenas y unidades para restar.', 'single-choice', '22', '[{"id": "a", "label": "23", "value": "23"}, {"id": "b", "label": "22", "value": "22"}, {"id": "c", "label": "21", "value": "21"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-27', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 34-13', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-27-01', 'act-mat1-estrella-27', '34 - 13 =', 'Separa decenas y unidades para restar.', 'single-choice', '21', '[{"id": "a", "label": "22", "value": "22"}, {"id": "b", "label": "21", "value": "21"}, {"id": "c", "label": "20", "value": "20"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-28', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 32-2', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-28-01', 'act-mat1-estrella-28', '32 - 2 =', 'Separa decenas y unidades para restar.', 'single-choice', '30', '[{"id": "a", "label": "31", "value": "31"}, {"id": "b", "label": "30", "value": "30"}, {"id": "c", "label": "29", "value": "29"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-29', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 26-16', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-29-01', 'act-mat1-estrella-29', '26 - 16 =', 'Separa decenas y unidades para restar.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-30', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Resta con estrategia 39-20', 'Practica restas con apoyo mental. Cada actividad vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-30-01', 'act-mat1-estrella-30', '39 - 20 =', 'Separa decenas y unidades para restar.', 'single-choice', '19', '[{"id": "a", "label": "20", "value": "20"}, {"id": "b", "label": "19", "value": "19"}, {"id": "c", "label": "18", "value": "18"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-31', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: manzana', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-31-01', 'act-mat1-estrella-31', 'Un gráfico muestra 8 manzana y 5 pera. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'manzana', '[{"id": "a", "label": "pera", "value": "pera"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "manzana", "value": "manzana"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-32', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: rojo', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-32-01', 'act-mat1-estrella-32', 'Un gráfico muestra 12 rojo y 9 azul. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'rojo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-33', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: gatos', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-33-01', 'act-mat1-estrella-33', 'Un gráfico muestra 6 perros y 10 gatos. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'gatos', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "gatos", "value": "gatos"}, {"id": "c", "label": "perros", "value": "perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-34', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: empate', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-34-01', 'act-mat1-estrella-34', 'Un gráfico muestra 7 panes y 7 frutas. ¿Qué conclusión es correcta?', 'Cuando las cantidades son iguales, hay empate.', 'single-choice', 'hay empate', '[{"id": "a", "label": "hay más panes", "value": "hay más panes"}, {"id": "b", "label": "hay más frutas", "value": "hay más frutas"}, {"id": "c", "label": "hay empate", "value": "hay empate"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-35', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: pelotas', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-35-01', 'act-mat1-estrella-35', 'Un gráfico muestra 14 pelotas y 11 carros. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'pelotas', '[{"id": "a", "label": "carros", "value": "carros"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "pelotas", "value": "pelotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-36', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: B', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-36-01', 'act-mat1-estrella-36', 'Un gráfico muestra 4 A y 9 B. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'b', '[{"id": "a", "label": "A", "value": "a"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "B", "value": "b"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-37', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: libros', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-37-01', 'act-mat1-estrella-37', 'Un gráfico muestra 15 libros y 13 cuadernos. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'libros', '[{"id": "a", "label": "libros", "value": "libros"}, {"id": "b", "label": "cuadernos", "value": "cuadernos"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-38', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: pollitos', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-38-01', 'act-mat1-estrella-38', 'Un gráfico muestra 10 pollitos y 8 patos. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'pollitos', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "pollitos", "value": "pollitos"}, {"id": "c", "label": "patos", "value": "patos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-39', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: hojas', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-39-01', 'act-mat1-estrella-39', 'Un gráfico muestra 9 flores y 12 hojas. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'hojas', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "hojas", "value": "hojas"}, {"id": "c", "label": "flores", "value": "flores"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-40', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Interpreta gráfico: lápices', 'Lee datos de tablas y gráficos. Cada actividad vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-40-01', 'act-mat1-estrella-40', 'Un gráfico muestra 16 lápices y 6 borradores. ¿Qué hay más?', 'La barra más alta o el número mayor gana.', 'single-choice', 'lápices', '[{"id": "a", "label": "borradores", "value": "borradores"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "lápices", "value": "lápices"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-41', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-41-01', 'act-mat1-estrella-41', 'Compara medidas: 5 unidades y 3 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'la mesa de 5 clips', '[{"id": "a", "label": "la mesa de 5 clips", "value": "la mesa de 5 clips"}, {"id": "b", "label": "el otro", "value": "el otro"}, {"id": "c", "label": "miden igual", "value": "miden igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-42', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-42-01', 'act-mat1-estrella-42', 'Compara medidas: 8 unidades y 6 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'la cinta de 8 pasos', '[{"id": "a", "label": "el otro", "value": "el otro"}, {"id": "b", "label": "miden igual", "value": "miden igual"}, {"id": "c", "label": "la cinta de 8 pasos", "value": "la cinta de 8 pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-43', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-43-01', 'act-mat1-estrella-43', 'Compara medidas: 4 unidades y 9 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'la cuerda de 9 palitos', '[{"id": "a", "label": "el otro", "value": "el otro"}, {"id": "b", "label": "miden igual", "value": "miden igual"}, {"id": "c", "label": "la cuerda de 9 palitos", "value": "la cuerda de 9 palitos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-44', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: igual longitud', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-44-01', 'act-mat1-estrella-44', 'Un objeto mide 7 clips y otro mide 7 clips. ¿Qué sucede?', 'Si usan la misma unidad y tienen el mismo número, miden igual.', 'single-choice', 'miden igual', '[{"id": "a", "label": "el segundo es más largo", "value": "el segundo es más largo"}, {"id": "b", "label": "miden igual", "value": "miden igual"}, {"id": "c", "label": "el primero es más largo", "value": "el primero es más largo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-45', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-45-01', 'act-mat1-estrella-45', 'Compara medidas: 10 unidades y 6 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'el camino de 10 huellas', '[{"id": "a", "label": "miden igual", "value": "miden igual"}, {"id": "b", "label": "el camino de 10 huellas", "value": "el camino de 10 huellas"}, {"id": "c", "label": "el otro", "value": "el otro"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-46', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-46-01', 'act-mat1-estrella-46', 'Compara medidas: 2 unidades y 5 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'la fila de 5 cubos', '[{"id": "a", "label": "la fila de 5 cubos", "value": "la fila de 5 cubos"}, {"id": "b", "label": "el otro", "value": "el otro"}, {"id": "c", "label": "miden igual", "value": "miden igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-47', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-47-01', 'act-mat1-estrella-47', 'Compara medidas: 12 unidades y 8 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'la regla de 12 bloques', '[{"id": "a", "label": "el otro", "value": "el otro"}, {"id": "b", "label": "miden igual", "value": "miden igual"}, {"id": "c", "label": "la regla de 12 bloques", "value": "la regla de 12 bloques"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-48', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-48-01', 'act-mat1-estrella-48', 'Compara medidas: 6 unidades y 11 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'el lápiz de 11 clips', '[{"id": "a", "label": "miden igual", "value": "miden igual"}, {"id": "b", "label": "el lápiz de 11 clips", "value": "el lápiz de 11 clips"}, {"id": "c", "label": "el otro", "value": "el otro"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-49', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: compara largo', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-49-01', 'act-mat1-estrella-49', 'Compara medidas: 9 unidades y 4 unidades. ¿Cuál es más largo?', 'Más unidades indican mayor longitud.', 'single-choice', 'la tira de 9 botones', '[{"id": "a", "label": "miden igual", "value": "miden igual"}, {"id": "b", "label": "la tira de 9 botones", "value": "la tira de 9 botones"}, {"id": "c", "label": "el otro", "value": "el otro"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-estrella-50', 'les-mat-primaria-1p-estrella', 'mat-primaria', '1-primaria', 'Medición: igual longitud', 'Compara longitudes con unidades no convencionales. Cada actividad vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-estrella-50-01', 'act-mat1-estrella-50', 'Un objeto mide 3 clips y otro mide 3 clips. ¿Qué sucede?', 'Si usan la misma unidad y tienen el mismo número, miden igual.', 'single-choice', 'miden igual', '[{"id": "a", "label": "el segundo es más largo", "value": "el segundo es más largo"}, {"id": "b", "label": "miden igual", "value": "miden igual"}, {"id": "c", "label": "el primero es más largo", "value": "el primero es más largo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'maestro', '🏆 Maestro Genio - Retos hasta 50, dinero y lógica', 'Números hasta 50, dinero, doble, mitad, igualdad, balanzas y razonamiento lógico.', 5, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-01', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 41', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-01-01', 'act-mat1-maestro-01', '¿Qué número sigue después de 40?', 'Cuenta de uno en uno.', 'single-choice', '41', '[{"id": "a", "label": "42", "value": "42"}, {"id": "b", "label": "41", "value": "41"}, {"id": "c", "label": "40", "value": "40"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-02', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 42', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-02-01', 'act-mat1-maestro-02', '¿Qué número sigue después de 41?', 'Cuenta de uno en uno.', 'single-choice', '42', '[{"id": "a", "label": "43", "value": "43"}, {"id": "b", "label": "42", "value": "42"}, {"id": "c", "label": "41", "value": "41"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-03', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 43', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-03-01', 'act-mat1-maestro-03', '¿Qué número sigue después de 42?', 'Cuenta de uno en uno.', 'single-choice', '43', '[{"id": "a", "label": "44", "value": "44"}, {"id": "b", "label": "43", "value": "43"}, {"id": "c", "label": "42", "value": "42"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-04', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 44', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-04-01', 'act-mat1-maestro-04', '¿Qué número sigue después de 43?', 'Cuenta de uno en uno.', 'single-choice', '44', '[{"id": "a", "label": "45", "value": "45"}, {"id": "b", "label": "44", "value": "44"}, {"id": "c", "label": "43", "value": "43"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-05', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 45', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-05-01', 'act-mat1-maestro-05', '¿Qué número sigue después de 44?', 'Cuenta de uno en uno.', 'single-choice', '45', '[{"id": "a", "label": "46", "value": "46"}, {"id": "b", "label": "45", "value": "45"}, {"id": "c", "label": "44", "value": "44"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-06', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 46', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-06-01', 'act-mat1-maestro-06', '¿Qué número sigue después de 45?', 'Cuenta de uno en uno.', 'single-choice', '46', '[{"id": "a", "label": "47", "value": "47"}, {"id": "b", "label": "46", "value": "46"}, {"id": "c", "label": "45", "value": "45"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-07', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 47', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-07-01', 'act-mat1-maestro-07', '¿Qué número sigue después de 46?', 'Cuenta de uno en uno.', 'single-choice', '47', '[{"id": "a", "label": "48", "value": "48"}, {"id": "b", "label": "47", "value": "47"}, {"id": "c", "label": "46", "value": "46"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-08', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 48', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-08-01', 'act-mat1-maestro-08', '¿Qué número sigue después de 47?', 'Cuenta de uno en uno.', 'single-choice', '48', '[{"id": "a", "label": "49", "value": "49"}, {"id": "b", "label": "48", "value": "48"}, {"id": "c", "label": "47", "value": "47"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-09', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 49', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-09-01', 'act-mat1-maestro-09', '¿Qué número sigue después de 48?', 'Cuenta de uno en uno.', 'single-choice', '49', '[{"id": "a", "label": "50", "value": "50"}, {"id": "b", "label": "49", "value": "49"}, {"id": "c", "label": "48", "value": "48"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-10', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Cuenta hasta 50', 'Reconoce números hasta 50. Cada actividad vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-10-01', 'act-mat1-maestro-10', '¿Qué número sigue después de 49?', 'Cuenta de uno en uno.', 'single-choice', '50', '[{"id": "a", "label": "49", "value": "49"}, {"id": "b", "label": "50", "value": "50"}, {"id": "c", "label": "49", "value": "49"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-11', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 2+S/ 3', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-11-01', 'act-mat1-maestro-11', 'Tengo S/ 2 y S/ 3. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 5', '[{"id": "a", "label": "S/ 4", "value": "s/ 4"}, {"id": "b", "label": "S/ 6", "value": "s/ 6"}, {"id": "c", "label": "S/ 5", "value": "s/ 5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-12', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 5+S/ 4', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-12-01', 'act-mat1-maestro-12', 'Tengo S/ 5 y S/ 4. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 9', '[{"id": "a", "label": "S/ 8", "value": "s/ 8"}, {"id": "b", "label": "S/ 10", "value": "s/ 10"}, {"id": "c", "label": "S/ 9", "value": "s/ 9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-13', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 10+S/ 7', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-13-01', 'act-mat1-maestro-13', 'Tengo S/ 10 y S/ 7. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 17', '[{"id": "a", "label": "S/ 18", "value": "s/ 18"}, {"id": "b", "label": "S/ 17", "value": "s/ 17"}, {"id": "c", "label": "S/ 16", "value": "s/ 16"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-14', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 20+S/ 5', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-14-01', 'act-mat1-maestro-14', 'Tengo S/ 20 y S/ 5. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 25', '[{"id": "a", "label": "S/ 26", "value": "s/ 26"}, {"id": "b", "label": "S/ 25", "value": "s/ 25"}, {"id": "c", "label": "S/ 24", "value": "s/ 24"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-15', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 8+S/ 6', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-15-01', 'act-mat1-maestro-15', 'Tengo S/ 8 y S/ 6. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 14', '[{"id": "a", "label": "S/ 15", "value": "s/ 15"}, {"id": "b", "label": "S/ 14", "value": "s/ 14"}, {"id": "c", "label": "S/ 13", "value": "s/ 13"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-16', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 15+S/ 10', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-16-01', 'act-mat1-maestro-16', 'Tengo S/ 15 y S/ 10. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 25', '[{"id": "a", "label": "S/ 26", "value": "s/ 26"}, {"id": "b", "label": "S/ 25", "value": "s/ 25"}, {"id": "c", "label": "S/ 24", "value": "s/ 24"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-17', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 12+S/ 8', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-17-01', 'act-mat1-maestro-17', 'Tengo S/ 12 y S/ 8. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 20', '[{"id": "a", "label": "S/ 21", "value": "s/ 21"}, {"id": "b", "label": "S/ 20", "value": "s/ 20"}, {"id": "c", "label": "S/ 19", "value": "s/ 19"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-18', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 4+S/ 9', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-18-01', 'act-mat1-maestro-18', 'Tengo S/ 4 y S/ 9. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 13', '[{"id": "a", "label": "S/ 14", "value": "s/ 14"}, {"id": "b", "label": "S/ 13", "value": "s/ 13"}, {"id": "c", "label": "S/ 12", "value": "s/ 12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-19', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 18+S/ 2', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-19-01', 'act-mat1-maestro-19', 'Tengo S/ 18 y S/ 2. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 20', '[{"id": "a", "label": "S/ 21", "value": "s/ 21"}, {"id": "b", "label": "S/ 20", "value": "s/ 20"}, {"id": "c", "label": "S/ 19", "value": "s/ 19"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-20', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Dinero S/ 30+S/ 5', 'Suma cantidades monetarias simples. Cada actividad vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-20-01', 'act-mat1-maestro-20', 'Tengo S/ 30 y S/ 5. ¿Cuánto tengo?', 'Suma los soles como números.', 'single-choice', 's/ 35', '[{"id": "a", "label": "S/ 36", "value": "s/ 36"}, {"id": "b", "label": "S/ 35", "value": "s/ 35"}, {"id": "c", "label": "S/ 34", "value": "s/ 34"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-21', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 5', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-21-01', 'act-mat1-maestro-21', 'Pago con S/ 5 un producto que cuesta S/ 4. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 1', '[{"id": "a", "label": "S/ 0", "value": "s/ 0"}, {"id": "b", "label": "S/ 2", "value": "s/ 2"}, {"id": "c", "label": "S/ 1", "value": "s/ 1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-22', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 10', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-22-01', 'act-mat1-maestro-22', 'Pago con S/ 10 un producto que cuesta S/ 7. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 3', '[{"id": "a", "label": "S/ 2", "value": "s/ 2"}, {"id": "b", "label": "S/ 4", "value": "s/ 4"}, {"id": "c", "label": "S/ 3", "value": "s/ 3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-23', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 20', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-23-01', 'act-mat1-maestro-23', 'Pago con S/ 20 un producto que cuesta S/ 15. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 5', '[{"id": "a", "label": "S/ 4", "value": "s/ 4"}, {"id": "b", "label": "S/ 6", "value": "s/ 6"}, {"id": "c", "label": "S/ 5", "value": "s/ 5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-24', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 12', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-24-01', 'act-mat1-maestro-24', 'Pago con S/ 12 un producto que cuesta S/ 8. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 4', '[{"id": "a", "label": "S/ 3", "value": "s/ 3"}, {"id": "b", "label": "S/ 5", "value": "s/ 5"}, {"id": "c", "label": "S/ 4", "value": "s/ 4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-25', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 30', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-25-01', 'act-mat1-maestro-25', 'Pago con S/ 30 un producto que cuesta S/ 25. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 5', '[{"id": "a", "label": "S/ 4", "value": "s/ 4"}, {"id": "b", "label": "S/ 6", "value": "s/ 6"}, {"id": "c", "label": "S/ 5", "value": "s/ 5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-26', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 15', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-26-01', 'act-mat1-maestro-26', 'Pago con S/ 15 un producto que cuesta S/ 9. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 6', '[{"id": "a", "label": "S/ 5", "value": "s/ 5"}, {"id": "b", "label": "S/ 7", "value": "s/ 7"}, {"id": "c", "label": "S/ 6", "value": "s/ 6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-27', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 18', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-27-01', 'act-mat1-maestro-27', 'Pago con S/ 18 un producto que cuesta S/ 11. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 7', '[{"id": "a", "label": "S/ 6", "value": "s/ 6"}, {"id": "b", "label": "S/ 8", "value": "s/ 8"}, {"id": "c", "label": "S/ 7", "value": "s/ 7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-28', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 25', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-28-01', 'act-mat1-maestro-28', 'Pago con S/ 25 un producto que cuesta S/ 20. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 5', '[{"id": "a", "label": "S/ 4", "value": "s/ 4"}, {"id": "b", "label": "S/ 6", "value": "s/ 6"}, {"id": "c", "label": "S/ 5", "value": "s/ 5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-29', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 40', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-29-01', 'act-mat1-maestro-29', 'Pago con S/ 40 un producto que cuesta S/ 35. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 5', '[{"id": "a", "label": "S/ 4", "value": "s/ 4"}, {"id": "b", "label": "S/ 6", "value": "s/ 6"}, {"id": "c", "label": "S/ 5", "value": "s/ 5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-30', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Vuelto de S/ 50', 'Resuelve compras con monedas y billetes. Cada actividad vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-30-01', 'act-mat1-maestro-30', 'Pago con S/ 50 un producto que cuesta S/ 45. ¿Cuánto vuelto recibo?', 'Resta el precio al dinero entregado.', 'single-choice', 's/ 5', '[{"id": "a", "label": "S/ 4", "value": "s/ 4"}, {"id": "b", "label": "S/ 6", "value": "s/ 6"}, {"id": "c", "label": "S/ 5", "value": "s/ 5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-31', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 1', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-31-01', 'act-mat1-maestro-31', 'El doble de 1 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-32', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 2', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-32-01', 'act-mat1-maestro-32', 'El doble de 2 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '4', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-33', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 3', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-33-01', 'act-mat1-maestro-33', 'El doble de 3 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-34', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 4', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-34-01', 'act-mat1-maestro-34', 'El doble de 4 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-35', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 5', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-35-01', 'act-mat1-maestro-35', 'El doble de 5 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-36', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 6', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-36-01', 'act-mat1-maestro-36', 'El doble de 6 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '12', '[{"id": "a", "label": "14", "value": "14"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "11", "value": "11"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-37', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 7', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-37-01', 'act-mat1-maestro-37', 'El doble de 7 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '14', '[{"id": "a", "label": "16", "value": "16"}, {"id": "b", "label": "14", "value": "14"}, {"id": "c", "label": "13", "value": "13"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-38', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 8', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-38-01', 'act-mat1-maestro-38', 'El doble de 8 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '16', '[{"id": "a", "label": "18", "value": "18"}, {"id": "b", "label": "16", "value": "16"}, {"id": "c", "label": "15", "value": "15"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-39', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 9', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-39-01', 'act-mat1-maestro-39', 'El doble de 9 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '18', '[{"id": "a", "label": "20", "value": "20"}, {"id": "b", "label": "18", "value": "18"}, {"id": "c", "label": "17", "value": "17"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-40', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Doble de 10', 'Calcula el doble de un número. Cada actividad vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-40-01', 'act-mat1-maestro-40', 'El doble de 10 es:', 'Doblar es sumar el mismo número dos veces.', 'single-choice', '20', '[{"id": "a", "label": "22", "value": "22"}, {"id": "b", "label": "20", "value": "20"}, {"id": "c", "label": "19", "value": "19"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-41', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 2', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-41-01', 'act-mat1-maestro-41', 'La mitad de 2 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '1', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-42', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 4', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-42-01', 'act-mat1-maestro-42', 'La mitad de 4 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-43', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 6', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-43-01', 'act-mat1-maestro-43', 'La mitad de 6 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '3', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-44', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 8', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-44-01', 'act-mat1-maestro-44', 'La mitad de 8 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '4', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-45', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 10', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-45-01', 'act-mat1-maestro-45', 'La mitad de 10 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-46', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 12', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-46-01', 'act-mat1-maestro-46', 'La mitad de 12 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '6', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "6", "value": "6"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-47', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 14', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-47-01', 'act-mat1-maestro-47', 'La mitad de 14 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '7', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-48', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 16', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-48-01', 'act-mat1-maestro-48', 'La mitad de 16 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '8', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "8", "value": "8"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-49', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 18', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-49-01', 'act-mat1-maestro-49', 'La mitad de 18 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '9', '[{"id": "a", "label": "8", "value": "8"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat1-maestro-50', 'les-mat-primaria-1p-maestro', 'mat-primaria', '1-primaria', 'Mitad de 20', 'Reconoce mitades exactas. Cada actividad vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat1-maestro-50-01', 'act-mat1-maestro-50', 'La mitad de 20 es:', 'Mitad es repartir en dos grupos iguales.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

-- Medallas ampliadas para rutas largas
insert into public.badges (id, name, description, icon, requirement, color, category, order_number) values
('badge-50-level','Nivel Dominado','Completó 50 actividades de un nivel completo.','🎯','Completar 50 actividades.','#74b9ff','nivel',16),
('badge-100-math1','Ruta Matemática 100','Completó 100 misiones de Matemática 1.º.','🧮','Completar 100 actividades de Matemática 1.º.','#6c5ce7','curso',17),
('badge-250-math1','Maestro Matemático 1.º','Completó las 250 actividades de Matemática 1.º primaria.','👑','Completar 250 actividades de Matemática 1.º.','#ff7675','excelencia',18)
on conflict (id) do update set name = excluded.name, description = excluded.description, icon = excluded.icon, requirement = excluded.requirement, color = excluded.color, category = excluded.category, order_number = excluded.order_number;

notify pgrst, 'reload schema';

-- =============================================================
-- GenioKids - Nuestro País 1.º primaria ampliado a 250 actividades
-- Referencia pedagógica: Cuadernillo Nuestro País, primer grado, MINEDU.
-- Contenido original para app: no copia páginas ni imágenes del PDF.
-- Estructura: 5 niveles x 50 actividades = 250 actividades.
-- Regla: desbloqueo por promedio mínimo 15/20 o completar el nivel anterior.
-- =============================================================

alter table public.subjects drop constraint if exists subjects_area_check;
alter table public.subjects add constraint subjects_area_check
check (area in ('matematica','comunicacion','ingles','ciencia','razonamiento','juegos','nuestro_pais','educacion_financiera','tutoria'));

alter table public.activities drop constraint if exists activities_order_number_check;
alter table public.activities add constraint activities_order_number_check check (order_number between 1 and 50);

insert into public.subjects (id, name, area, level, grades, icon, color, description, is_active) values
('mat-primaria', 'Matemática', 'matematica', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🧮', '#6c5ce7', 'Operaciones, problemas, patrones, medidas, geometría, dinero y pensamiento matemático por grado.', true),
('com-primaria', 'Comunicación', 'comunicacion', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '✍️', '#00b894', 'Lectoescritura, comprensión, oralidad, gramática, ortografía y producción de textos.', true),
('nuestro-pais-primaria', 'Nuestro País', 'nuestro_pais', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🇵🇪', '#2ecc71', 'Familia, localidad, escuela, convivencia, ciudadanía, buen trato e identidad peruana.', true),
('educacion-financiera-primaria', 'Educación Financiera', 'educacion_financiera', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '💰', '#f39c12', 'Ahorro, necesidades, deseos, consumo responsable, dinero, presupuesto y decisiones financieras.', true),
('tutoria-primaria', 'Tutoría', 'tutoria', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '💛', '#e84393', 'Emociones, autocuidado, convivencia, proyecto de vida, vínculos y toma de decisiones.', true),
('logic-primaria', 'Razonamiento', 'razonamiento', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🧠', '#a29bfe', 'Patrones, secuencias, clasificación, comparación, inferencias y pensamiento lógico.', true),
('eng-primaria', 'Inglés', 'ingles', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🗣️', '#0984e3', 'Vocabulario, saludos, frases simples, escucha y práctica guiada por grado.', true),
('sci-primaria', 'Ciencia y ambiente', 'ciencia', 'primaria', array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'], '🔬', '#00cec9', 'Seres vivos, cuerpo humano, salud, ambiente, materia, energía y cuidado del entorno.', true)
on conflict (id) do update set
  name = excluded.name,
  area = excluded.area,
  level = excluded.level,
  grades = excluded.grades,
  icon = excluded.icon,
  color = excluded.color,
  description = excluded.description,
  is_active = true;


-- Reemplaza únicamente Nuestro País 1.º primaria.
delete from public.lessons where subject_id = 'nuestro-pais-primaria' and grade = '1-primaria';

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'semilla', '🌱 Semilla Genial - Mi familia y yo', 'Familia, identidad, cuidado, responsabilidades, rutinas y emociones.', 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-01', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Mi familia valiosa 01', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-01-01', 'act-np1-semilla-01', '¿Qué une a una familia?', 'Piensa en cómo se cuidan las personas en casa.', 'single-choice', 'amor y cuidado', '[{"id": "a", "label": "Amor y cuidado", "value": "amor y cuidado"}, {"id": "b", "label": "Solo juguetes", "value": "solo juguetes"}, {"id": "c", "label": "Solo televisión", "value": "solo televisión"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-02', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Tareas en casa 02', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-02-01', 'act-np1-semilla-02', 'Si ayudas a ordenar tus juguetes, ¿qué responsabilidad estás cumpliendo?', 'Las tareas compartidas ayudan a la familia.', 'single-choice', 'colaborar en casa', '[{"id": "a", "label": "Colaborar en casa", "value": "colaborar en casa"}, {"id": "b", "label": "Hacer bulla", "value": "hacer bulla"}, {"id": "c", "label": "Romper cosas", "value": "romper cosas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-03', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Personas diferentes 03', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-03-01', 'act-np1-semilla-03', 'Todas las personas son diferentes. ¿Qué debemos hacer?', 'Ser diferentes no nos quita valor.', 'single-choice', 'respetarlas', '[{"id": "a", "label": "Respetarlas", "value": "respetarlas"}, {"id": "b", "label": "Burlarnos", "value": "burlarnos"}, {"id": "c", "label": "Ignorarlas", "value": "ignorarlas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-04', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Actividades familiares 04', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-04-01', 'act-np1-semilla-04', '¿Qué actividad puede hacer una familia junta?', 'Busca una actividad de unión familiar.', 'single-choice', 'comer y conversar', '[{"id": "a", "label": "Comer y conversar", "value": "comer y conversar"}, {"id": "b", "label": "Pelear siempre", "value": "pelear siempre"}, {"id": "c", "label": "Ensuciar la calle", "value": "ensuciar la calle"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-05', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Escucho emociones 05', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-05-01', 'act-np1-semilla-05', 'Si un familiar está triste, ¿qué puedes hacer?', 'El buen trato empieza escuchando.', 'single-choice', 'escucharlo con cariño', '[{"id": "a", "label": "Escucharlo con cariño", "value": "escucharlo con cariño"}, {"id": "b", "label": "Reírte", "value": "reírte"}, {"id": "c", "label": "Alejarte sin hablar", "value": "alejarte sin hablar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-06', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Adultos que cuidan 06', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-06-01', 'act-np1-semilla-06', '¿Qué persona puede cuidarte en casa?', 'Los adultos responsables protegen a niñas y niños.', 'single-choice', 'una persona adulta responsable', '[{"id": "a", "label": "Una persona adulta responsable", "value": "una persona adulta responsable"}, {"id": "b", "label": "Un desconocido", "value": "un desconocido"}, {"id": "c", "label": "Nadie", "value": "nadie"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-07', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Historia familiar 07', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-07-01', 'act-np1-semilla-07', '¿Qué dato pertenece a tu historia familiar?', 'La historia familiar habla de quiénes somos.', 'single-choice', 'lugar de origen de mi familia', '[{"id": "a", "label": "Lugar de origen de mi familia", "value": "lugar de origen de mi familia"}, {"id": "b", "label": "El color de un semáforo", "value": "el color de un semáforo"}, {"id": "c", "label": "El precio de una tienda", "value": "el precio de una tienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-08', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Aprendo en familia 08', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-08-01', 'act-np1-semilla-08', '¿Qué se aprende en familia?', 'La familia enseña muchas cosas de la vida diaria.', 'single-choice', 'hábitos y valores', '[{"id": "a", "label": "Hábitos y valores", "value": "hábitos y valores"}, {"id": "b", "label": "Solo videojuegos", "value": "solo videojuegos"}, {"id": "c", "label": "Nada importante", "value": "nada importante"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-09', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Compartimos tareas 09', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-09-01', 'act-np1-semilla-09', 'Si en casa todos comparten tareas, la familia...', 'Compartir responsabilidades mejora la convivencia.', 'single-choice', 'se organiza mejor', '[{"id": "a", "label": "se organiza mejor", "value": "se organiza mejor"}, {"id": "b", "label": "se desordena más", "value": "se desordena más"}, {"id": "c", "label": "deja de ayudarse", "value": "deja de ayudarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-10', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Expreso emociones 10', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-10-01', 'act-np1-semilla-10', 'Cuando algo me molesta, lo mejor es...', 'Nombrar emociones ayuda a resolver problemas.', 'single-choice', 'decir cómo me siento con calma', '[{"id": "a", "label": "decir cómo me siento con calma", "value": "decir cómo me siento con calma"}, {"id": "b", "label": "gritar sin escuchar", "value": "gritar sin escuchar"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-11', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Mi familia valiosa 11', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-11-01', 'act-np1-semilla-11', 'Piensa en tu vida diaria: ¿Qué une a una familia?', 'Piensa en cómo se cuidan las personas en casa.', 'single-choice', 'amor y cuidado', '[{"id": "a", "label": "Amor y cuidado", "value": "amor y cuidado"}, {"id": "b", "label": "Solo juguetes", "value": "solo juguetes"}, {"id": "c", "label": "Solo televisión", "value": "solo televisión"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-12', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Tareas en casa 12', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-12-01', 'act-np1-semilla-12', 'Piensa en tu vida diaria: Si ayudas a ordenar tus juguetes, ¿qué responsabilidad estás cumpliendo?', 'Las tareas compartidas ayudan a la familia.', 'single-choice', 'colaborar en casa', '[{"id": "a", "label": "Colaborar en casa", "value": "colaborar en casa"}, {"id": "b", "label": "Hacer bulla", "value": "hacer bulla"}, {"id": "c", "label": "Romper cosas", "value": "romper cosas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-13', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Personas diferentes 13', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-13-01', 'act-np1-semilla-13', 'Piensa en tu vida diaria: Todas las personas son diferentes. ¿Qué debemos hacer?', 'Ser diferentes no nos quita valor.', 'single-choice', 'respetarlas', '[{"id": "a", "label": "Respetarlas", "value": "respetarlas"}, {"id": "b", "label": "Burlarnos", "value": "burlarnos"}, {"id": "c", "label": "Ignorarlas", "value": "ignorarlas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-14', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Actividades familiares 14', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-14-01', 'act-np1-semilla-14', 'Piensa en tu vida diaria: ¿Qué actividad puede hacer una familia junta?', 'Busca una actividad de unión familiar.', 'single-choice', 'comer y conversar', '[{"id": "a", "label": "Comer y conversar", "value": "comer y conversar"}, {"id": "b", "label": "Pelear siempre", "value": "pelear siempre"}, {"id": "c", "label": "Ensuciar la calle", "value": "ensuciar la calle"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-15', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Escucho emociones 15', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-15-01', 'act-np1-semilla-15', 'Piensa en tu vida diaria: Si un familiar está triste, ¿qué puedes hacer?', 'El buen trato empieza escuchando.', 'single-choice', 'escucharlo con cariño', '[{"id": "a", "label": "Escucharlo con cariño", "value": "escucharlo con cariño"}, {"id": "b", "label": "Reírte", "value": "reírte"}, {"id": "c", "label": "Alejarte sin hablar", "value": "alejarte sin hablar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-16', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Adultos que cuidan 16', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-16-01', 'act-np1-semilla-16', 'Piensa en tu vida diaria: ¿Qué persona puede cuidarte en casa?', 'Los adultos responsables protegen a niñas y niños.', 'single-choice', 'una persona adulta responsable', '[{"id": "a", "label": "Una persona adulta responsable", "value": "una persona adulta responsable"}, {"id": "b", "label": "Un desconocido", "value": "un desconocido"}, {"id": "c", "label": "Nadie", "value": "nadie"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-17', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Historia familiar 17', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-17-01', 'act-np1-semilla-17', 'Piensa en tu vida diaria: ¿Qué dato pertenece a tu historia familiar?', 'La historia familiar habla de quiénes somos.', 'single-choice', 'lugar de origen de mi familia', '[{"id": "a", "label": "Lugar de origen de mi familia", "value": "lugar de origen de mi familia"}, {"id": "b", "label": "El color de un semáforo", "value": "el color de un semáforo"}, {"id": "c", "label": "El precio de una tienda", "value": "el precio de una tienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-18', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Aprendo en familia 18', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-18-01', 'act-np1-semilla-18', 'Piensa en tu vida diaria: ¿Qué se aprende en familia?', 'La familia enseña muchas cosas de la vida diaria.', 'single-choice', 'hábitos y valores', '[{"id": "a", "label": "Hábitos y valores", "value": "hábitos y valores"}, {"id": "b", "label": "Solo videojuegos", "value": "solo videojuegos"}, {"id": "c", "label": "Nada importante", "value": "nada importante"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-19', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Compartimos tareas 19', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-19-01', 'act-np1-semilla-19', 'Piensa en tu vida diaria: Si en casa todos comparten tareas, la familia...', 'Compartir responsabilidades mejora la convivencia.', 'single-choice', 'se organiza mejor', '[{"id": "a", "label": "se organiza mejor", "value": "se organiza mejor"}, {"id": "b", "label": "se desordena más", "value": "se desordena más"}, {"id": "c", "label": "deja de ayudarse", "value": "deja de ayudarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-20', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Expreso emociones 20', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-20-01', 'act-np1-semilla-20', 'Piensa en tu vida diaria: Cuando algo me molesta, lo mejor es...', 'Nombrar emociones ayuda a resolver problemas.', 'single-choice', 'decir cómo me siento con calma', '[{"id": "a", "label": "decir cómo me siento con calma", "value": "decir cómo me siento con calma"}, {"id": "b", "label": "gritar sin escuchar", "value": "gritar sin escuchar"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-21', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Mi familia valiosa 21', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-21-01', 'act-np1-semilla-21', 'En GenioKids: ¿Qué une a una familia?', 'Piensa en cómo se cuidan las personas en casa.', 'single-choice', 'amor y cuidado', '[{"id": "a", "label": "Amor y cuidado", "value": "amor y cuidado"}, {"id": "b", "label": "Solo juguetes", "value": "solo juguetes"}, {"id": "c", "label": "Solo televisión", "value": "solo televisión"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-22', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Tareas en casa 22', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-22-01', 'act-np1-semilla-22', 'En GenioKids: Si ayudas a ordenar tus juguetes, ¿qué responsabilidad estás cumpliendo?', 'Las tareas compartidas ayudan a la familia.', 'single-choice', 'colaborar en casa', '[{"id": "a", "label": "Colaborar en casa", "value": "colaborar en casa"}, {"id": "b", "label": "Hacer bulla", "value": "hacer bulla"}, {"id": "c", "label": "Romper cosas", "value": "romper cosas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-23', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Personas diferentes 23', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-23-01', 'act-np1-semilla-23', 'En GenioKids: Todas las personas son diferentes. ¿Qué debemos hacer?', 'Ser diferentes no nos quita valor.', 'single-choice', 'respetarlas', '[{"id": "a", "label": "Respetarlas", "value": "respetarlas"}, {"id": "b", "label": "Burlarnos", "value": "burlarnos"}, {"id": "c", "label": "Ignorarlas", "value": "ignorarlas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-24', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Actividades familiares 24', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-24-01', 'act-np1-semilla-24', 'En GenioKids: ¿Qué actividad puede hacer una familia junta?', 'Busca una actividad de unión familiar.', 'single-choice', 'comer y conversar', '[{"id": "a", "label": "Comer y conversar", "value": "comer y conversar"}, {"id": "b", "label": "Pelear siempre", "value": "pelear siempre"}, {"id": "c", "label": "Ensuciar la calle", "value": "ensuciar la calle"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-25', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Escucho emociones 25', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-25-01', 'act-np1-semilla-25', 'En GenioKids: Si un familiar está triste, ¿qué puedes hacer?', 'El buen trato empieza escuchando.', 'single-choice', 'escucharlo con cariño', '[{"id": "a", "label": "Escucharlo con cariño", "value": "escucharlo con cariño"}, {"id": "b", "label": "Reírte", "value": "reírte"}, {"id": "c", "label": "Alejarte sin hablar", "value": "alejarte sin hablar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-26', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Adultos que cuidan 26', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-26-01', 'act-np1-semilla-26', 'En GenioKids: ¿Qué persona puede cuidarte en casa?', 'Los adultos responsables protegen a niñas y niños.', 'single-choice', 'una persona adulta responsable', '[{"id": "a", "label": "Una persona adulta responsable", "value": "una persona adulta responsable"}, {"id": "b", "label": "Un desconocido", "value": "un desconocido"}, {"id": "c", "label": "Nadie", "value": "nadie"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-27', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Historia familiar 27', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-27-01', 'act-np1-semilla-27', 'En GenioKids: ¿Qué dato pertenece a tu historia familiar?', 'La historia familiar habla de quiénes somos.', 'single-choice', 'lugar de origen de mi familia', '[{"id": "a", "label": "Lugar de origen de mi familia", "value": "lugar de origen de mi familia"}, {"id": "b", "label": "El color de un semáforo", "value": "el color de un semáforo"}, {"id": "c", "label": "El precio de una tienda", "value": "el precio de una tienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-28', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Aprendo en familia 28', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-28-01', 'act-np1-semilla-28', 'En GenioKids: ¿Qué se aprende en familia?', 'La familia enseña muchas cosas de la vida diaria.', 'single-choice', 'hábitos y valores', '[{"id": "a", "label": "Hábitos y valores", "value": "hábitos y valores"}, {"id": "b", "label": "Solo videojuegos", "value": "solo videojuegos"}, {"id": "c", "label": "Nada importante", "value": "nada importante"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-29', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Compartimos tareas 29', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-29-01', 'act-np1-semilla-29', 'En GenioKids: Si en casa todos comparten tareas, la familia...', 'Compartir responsabilidades mejora la convivencia.', 'single-choice', 'se organiza mejor', '[{"id": "a", "label": "se organiza mejor", "value": "se organiza mejor"}, {"id": "b", "label": "se desordena más", "value": "se desordena más"}, {"id": "c", "label": "deja de ayudarse", "value": "deja de ayudarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-30', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Expreso emociones 30', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-30-01', 'act-np1-semilla-30', 'En GenioKids: Cuando algo me molesta, lo mejor es...', 'Nombrar emociones ayuda a resolver problemas.', 'single-choice', 'decir cómo me siento con calma', '[{"id": "a", "label": "decir cómo me siento con calma", "value": "decir cómo me siento con calma"}, {"id": "b", "label": "gritar sin escuchar", "value": "gritar sin escuchar"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-31', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Mi familia valiosa 31', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-31-01', 'act-np1-semilla-31', 'Reto ciudadano: ¿Qué une a una familia?', 'Piensa en cómo se cuidan las personas en casa.', 'single-choice', 'amor y cuidado', '[{"id": "a", "label": "Amor y cuidado", "value": "amor y cuidado"}, {"id": "b", "label": "Solo juguetes", "value": "solo juguetes"}, {"id": "c", "label": "Solo televisión", "value": "solo televisión"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-32', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Tareas en casa 32', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-32-01', 'act-np1-semilla-32', 'Reto ciudadano: Si ayudas a ordenar tus juguetes, ¿qué responsabilidad estás cumpliendo?', 'Las tareas compartidas ayudan a la familia.', 'single-choice', 'colaborar en casa', '[{"id": "a", "label": "Colaborar en casa", "value": "colaborar en casa"}, {"id": "b", "label": "Hacer bulla", "value": "hacer bulla"}, {"id": "c", "label": "Romper cosas", "value": "romper cosas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-33', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Personas diferentes 33', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-33-01', 'act-np1-semilla-33', 'Reto ciudadano: Todas las personas son diferentes. ¿Qué debemos hacer?', 'Ser diferentes no nos quita valor.', 'single-choice', 'respetarlas', '[{"id": "a", "label": "Respetarlas", "value": "respetarlas"}, {"id": "b", "label": "Burlarnos", "value": "burlarnos"}, {"id": "c", "label": "Ignorarlas", "value": "ignorarlas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-34', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Actividades familiares 34', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-34-01', 'act-np1-semilla-34', 'Reto ciudadano: ¿Qué actividad puede hacer una familia junta?', 'Busca una actividad de unión familiar.', 'single-choice', 'comer y conversar', '[{"id": "a", "label": "Comer y conversar", "value": "comer y conversar"}, {"id": "b", "label": "Pelear siempre", "value": "pelear siempre"}, {"id": "c", "label": "Ensuciar la calle", "value": "ensuciar la calle"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-35', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Escucho emociones 35', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-35-01', 'act-np1-semilla-35', 'Reto ciudadano: Si un familiar está triste, ¿qué puedes hacer?', 'El buen trato empieza escuchando.', 'single-choice', 'escucharlo con cariño', '[{"id": "a", "label": "Escucharlo con cariño", "value": "escucharlo con cariño"}, {"id": "b", "label": "Reírte", "value": "reírte"}, {"id": "c", "label": "Alejarte sin hablar", "value": "alejarte sin hablar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-36', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Adultos que cuidan 36', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-36-01', 'act-np1-semilla-36', 'Reto ciudadano: ¿Qué persona puede cuidarte en casa?', 'Los adultos responsables protegen a niñas y niños.', 'single-choice', 'una persona adulta responsable', '[{"id": "a", "label": "Una persona adulta responsable", "value": "una persona adulta responsable"}, {"id": "b", "label": "Un desconocido", "value": "un desconocido"}, {"id": "c", "label": "Nadie", "value": "nadie"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-37', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Historia familiar 37', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-37-01', 'act-np1-semilla-37', 'Reto ciudadano: ¿Qué dato pertenece a tu historia familiar?', 'La historia familiar habla de quiénes somos.', 'single-choice', 'lugar de origen de mi familia', '[{"id": "a", "label": "Lugar de origen de mi familia", "value": "lugar de origen de mi familia"}, {"id": "b", "label": "El color de un semáforo", "value": "el color de un semáforo"}, {"id": "c", "label": "El precio de una tienda", "value": "el precio de una tienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-38', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Aprendo en familia 38', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-38-01', 'act-np1-semilla-38', 'Reto ciudadano: ¿Qué se aprende en familia?', 'La familia enseña muchas cosas de la vida diaria.', 'single-choice', 'hábitos y valores', '[{"id": "a", "label": "Hábitos y valores", "value": "hábitos y valores"}, {"id": "b", "label": "Solo videojuegos", "value": "solo videojuegos"}, {"id": "c", "label": "Nada importante", "value": "nada importante"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-39', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Compartimos tareas 39', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-39-01', 'act-np1-semilla-39', 'Reto ciudadano: Si en casa todos comparten tareas, la familia...', 'Compartir responsabilidades mejora la convivencia.', 'single-choice', 'se organiza mejor', '[{"id": "a", "label": "se organiza mejor", "value": "se organiza mejor"}, {"id": "b", "label": "se desordena más", "value": "se desordena más"}, {"id": "c", "label": "deja de ayudarse", "value": "deja de ayudarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-40', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Expreso emociones 40', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-40-01', 'act-np1-semilla-40', 'Reto ciudadano: Cuando algo me molesta, lo mejor es...', 'Nombrar emociones ayuda a resolver problemas.', 'single-choice', 'decir cómo me siento con calma', '[{"id": "a", "label": "decir cómo me siento con calma", "value": "decir cómo me siento con calma"}, {"id": "b", "label": "gritar sin escuchar", "value": "gritar sin escuchar"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-41', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Mi familia valiosa 41', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-41-01', 'act-np1-semilla-41', 'Elige la mejor acción: ¿Qué une a una familia?', 'Piensa en cómo se cuidan las personas en casa.', 'single-choice', 'amor y cuidado', '[{"id": "a", "label": "Amor y cuidado", "value": "amor y cuidado"}, {"id": "b", "label": "Solo juguetes", "value": "solo juguetes"}, {"id": "c", "label": "Solo televisión", "value": "solo televisión"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-42', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Tareas en casa 42', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-42-01', 'act-np1-semilla-42', 'Elige la mejor acción: Si ayudas a ordenar tus juguetes, ¿qué responsabilidad estás cumpliendo?', 'Las tareas compartidas ayudan a la familia.', 'single-choice', 'colaborar en casa', '[{"id": "a", "label": "Colaborar en casa", "value": "colaborar en casa"}, {"id": "b", "label": "Hacer bulla", "value": "hacer bulla"}, {"id": "c", "label": "Romper cosas", "value": "romper cosas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-43', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Personas diferentes 43', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-43-01', 'act-np1-semilla-43', 'Elige la mejor acción: Todas las personas son diferentes. ¿Qué debemos hacer?', 'Ser diferentes no nos quita valor.', 'single-choice', 'respetarlas', '[{"id": "a", "label": "Respetarlas", "value": "respetarlas"}, {"id": "b", "label": "Burlarnos", "value": "burlarnos"}, {"id": "c", "label": "Ignorarlas", "value": "ignorarlas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-44', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Actividades familiares 44', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-44-01', 'act-np1-semilla-44', 'Elige la mejor acción: ¿Qué actividad puede hacer una familia junta?', 'Busca una actividad de unión familiar.', 'single-choice', 'comer y conversar', '[{"id": "a", "label": "Comer y conversar", "value": "comer y conversar"}, {"id": "b", "label": "Pelear siempre", "value": "pelear siempre"}, {"id": "c", "label": "Ensuciar la calle", "value": "ensuciar la calle"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-45', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Escucho emociones 45', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-45-01', 'act-np1-semilla-45', 'Elige la mejor acción: Si un familiar está triste, ¿qué puedes hacer?', 'El buen trato empieza escuchando.', 'single-choice', 'escucharlo con cariño', '[{"id": "a", "label": "Escucharlo con cariño", "value": "escucharlo con cariño"}, {"id": "b", "label": "Reírte", "value": "reírte"}, {"id": "c", "label": "Alejarte sin hablar", "value": "alejarte sin hablar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-46', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Adultos que cuidan 46', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-46-01', 'act-np1-semilla-46', 'Elige la mejor acción: ¿Qué persona puede cuidarte en casa?', 'Los adultos responsables protegen a niñas y niños.', 'single-choice', 'una persona adulta responsable', '[{"id": "a", "label": "Una persona adulta responsable", "value": "una persona adulta responsable"}, {"id": "b", "label": "Un desconocido", "value": "un desconocido"}, {"id": "c", "label": "Nadie", "value": "nadie"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-47', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Historia familiar 47', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-47-01', 'act-np1-semilla-47', 'Elige la mejor acción: ¿Qué dato pertenece a tu historia familiar?', 'La historia familiar habla de quiénes somos.', 'single-choice', 'lugar de origen de mi familia', '[{"id": "a", "label": "Lugar de origen de mi familia", "value": "lugar de origen de mi familia"}, {"id": "b", "label": "El color de un semáforo", "value": "el color de un semáforo"}, {"id": "c", "label": "El precio de una tienda", "value": "el precio de una tienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-48', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Aprendo en familia 48', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-48-01', 'act-np1-semilla-48', 'Elige la mejor acción: ¿Qué se aprende en familia?', 'La familia enseña muchas cosas de la vida diaria.', 'single-choice', 'hábitos y valores', '[{"id": "a", "label": "Hábitos y valores", "value": "hábitos y valores"}, {"id": "b", "label": "Solo videojuegos", "value": "solo videojuegos"}, {"id": "c", "label": "Nada importante", "value": "nada importante"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-49', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Compartimos tareas 49', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-49-01', 'act-np1-semilla-49', 'Elige la mejor acción: Si en casa todos comparten tareas, la familia...', 'Compartir responsabilidades mejora la convivencia.', 'single-choice', 'se organiza mejor', '[{"id": "a", "label": "se organiza mejor", "value": "se organiza mejor"}, {"id": "b", "label": "se desordena más", "value": "se desordena más"}, {"id": "c", "label": "deja de ayudarse", "value": "deja de ayudarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-semilla-50', 'les-nuestro-pais-1p-semilla', 'nuestro-pais-primaria', '1-primaria', 'Expreso emociones 50', 'Actividad de Nuestro País sobre mi familia y yo. Cada misión vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-semilla-50-01', 'act-np1-semilla-50', 'Elige la mejor acción: Cuando algo me molesta, lo mejor es...', 'Nombrar emociones ayuda a resolver problemas.', 'single-choice', 'decir cómo me siento con calma', '[{"id": "a", "label": "decir cómo me siento con calma", "value": "decir cómo me siento con calma"}, {"id": "b", "label": "gritar sin escuchar", "value": "gritar sin escuchar"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'explorador', '🔎 Explorador Curioso - Mi localidad y yo', 'Localidad, espacios públicos, servicios, instituciones y normas.', 2, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-01', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Conozco mi localidad 01', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-01-01', 'act-np1-explorador-01', '¿Qué es una localidad?', 'Tu barrio, comunidad o ciudad forman parte de tu localidad.', 'single-choice', 'el lugar donde vivimos', '[{"id": "a", "label": "El lugar donde vivimos", "value": "el lugar donde vivimos"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una fruta", "value": "una fruta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-02', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Espacios públicos 02', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-02-01', 'act-np1-explorador-02', '¿Cuál es un espacio público?', 'Los espacios públicos son compartidos por todos.', 'single-choice', 'el parque', '[{"id": "a", "label": "El parque", "value": "el parque"}, {"id": "b", "label": "Mi cama", "value": "mi cama"}, {"id": "c", "label": "Mi cuaderno", "value": "mi cuaderno"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-03', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Bomberos 03', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-03-01', 'act-np1-explorador-03', '¿Qué institución ayuda en emergencias de fuego?', 'Los bomberos atienden incendios y emergencias.', 'single-choice', 'compañía de bomberos', '[{"id": "a", "label": "Compañía de bomberos", "value": "compañía de bomberos"}, {"id": "b", "label": "Panadería", "value": "panadería"}, {"id": "c", "label": "Juguetería", "value": "juguetería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-04', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Posta médica 04', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-04-01', 'act-np1-explorador-04', '¿Qué institución ayuda a cuidar la salud?', 'La posta médica brinda atención de salud.', 'single-choice', 'posta médica', '[{"id": "a", "label": "Posta médica", "value": "posta médica"}, {"id": "b", "label": "Cancha", "value": "cancha"}, {"id": "c", "label": "Heladería", "value": "heladería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-05', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Municipalidad 05', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-05-01', 'act-np1-explorador-05', '¿Qué servicio puede brindar la municipalidad?', 'La municipalidad ayuda con servicios para la comunidad.', 'single-choice', 'recoger basura', '[{"id": "a", "label": "Recoger basura", "value": "recoger basura"}, {"id": "b", "label": "Vender dulces", "value": "vender dulces"}, {"id": "c", "label": "Hacer tareas", "value": "hacer tareas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-06', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Normas de limpieza 06', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-06-01', 'act-np1-explorador-06', '¿Qué norma ayuda a cuidar la localidad?', 'Cuidar la limpieza es responsabilidad de todos.', 'single-choice', 'botar basura en tachos', '[{"id": "a", "label": "Botar basura en tachos", "value": "botar basura en tachos"}, {"id": "b", "label": "Ensuciar las calles", "value": "ensuciar las calles"}, {"id": "c", "label": "Romper plantas", "value": "romper plantas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-07', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Institución educativa 07', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-07-01', 'act-np1-explorador-07', '¿Qué lugar de la localidad sirve para aprender?', 'La escuela es un espacio de aprendizaje.', 'single-choice', 'institución educativa', '[{"id": "a", "label": "Institución educativa", "value": "institución educativa"}, {"id": "b", "label": "Tienda de helados", "value": "tienda de helados"}, {"id": "c", "label": "Paradero", "value": "paradero"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-08', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Vecinos y vecinas 08', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-08-01', 'act-np1-explorador-08', '¿Quiénes comparten los espacios públicos?', 'Son para uso común y responsable.', 'single-choice', 'vecinas y vecinos', '[{"id": "a", "label": "Vecinas y vecinos", "value": "vecinas y vecinos"}, {"id": "b", "label": "Solo una persona", "value": "solo una persona"}, {"id": "c", "label": "Solo mascotas", "value": "solo mascotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-09', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Solucionamos problemas 09', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-09-01', 'act-np1-explorador-09', 'Si hay un problema en la localidad, debemos...', 'La convivencia mejora con acuerdos.', 'single-choice', 'dialogar y proponer mejoras', '[{"id": "a", "label": "dialogar y proponer mejoras", "value": "dialogar y proponer mejoras"}, {"id": "b", "label": "pelear", "value": "pelear"}, {"id": "c", "label": "hacer más desorden", "value": "hacer más desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-10', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la localidad 10', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-10-01', 'act-np1-explorador-10', '¿Qué acción cuida tu localidad?', 'Cuidar espacios públicos beneficia a todos.', 'single-choice', 'respetar señales y espacios', '[{"id": "a", "label": "Respetar señales y espacios", "value": "respetar señales y espacios"}, {"id": "b", "label": "Rayar paredes", "value": "rayar paredes"}, {"id": "c", "label": "Dejar basura", "value": "dejar basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-11', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Conozco mi localidad 11', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-11-01', 'act-np1-explorador-11', 'Piensa en tu vida diaria: ¿Qué es una localidad?', 'Tu barrio, comunidad o ciudad forman parte de tu localidad.', 'single-choice', 'el lugar donde vivimos', '[{"id": "a", "label": "El lugar donde vivimos", "value": "el lugar donde vivimos"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una fruta", "value": "una fruta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-12', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Espacios públicos 12', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-12-01', 'act-np1-explorador-12', 'Piensa en tu vida diaria: ¿Cuál es un espacio público?', 'Los espacios públicos son compartidos por todos.', 'single-choice', 'el parque', '[{"id": "a", "label": "El parque", "value": "el parque"}, {"id": "b", "label": "Mi cama", "value": "mi cama"}, {"id": "c", "label": "Mi cuaderno", "value": "mi cuaderno"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-13', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Bomberos 13', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-13-01', 'act-np1-explorador-13', 'Piensa en tu vida diaria: ¿Qué institución ayuda en emergencias de fuego?', 'Los bomberos atienden incendios y emergencias.', 'single-choice', 'compañía de bomberos', '[{"id": "a", "label": "Compañía de bomberos", "value": "compañía de bomberos"}, {"id": "b", "label": "Panadería", "value": "panadería"}, {"id": "c", "label": "Juguetería", "value": "juguetería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-14', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Posta médica 14', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-14-01', 'act-np1-explorador-14', 'Piensa en tu vida diaria: ¿Qué institución ayuda a cuidar la salud?', 'La posta médica brinda atención de salud.', 'single-choice', 'posta médica', '[{"id": "a", "label": "Posta médica", "value": "posta médica"}, {"id": "b", "label": "Cancha", "value": "cancha"}, {"id": "c", "label": "Heladería", "value": "heladería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-15', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Municipalidad 15', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-15-01', 'act-np1-explorador-15', 'Piensa en tu vida diaria: ¿Qué servicio puede brindar la municipalidad?', 'La municipalidad ayuda con servicios para la comunidad.', 'single-choice', 'recoger basura', '[{"id": "a", "label": "Recoger basura", "value": "recoger basura"}, {"id": "b", "label": "Vender dulces", "value": "vender dulces"}, {"id": "c", "label": "Hacer tareas", "value": "hacer tareas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-16', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Normas de limpieza 16', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-16-01', 'act-np1-explorador-16', 'Piensa en tu vida diaria: ¿Qué norma ayuda a cuidar la localidad?', 'Cuidar la limpieza es responsabilidad de todos.', 'single-choice', 'botar basura en tachos', '[{"id": "a", "label": "Botar basura en tachos", "value": "botar basura en tachos"}, {"id": "b", "label": "Ensuciar las calles", "value": "ensuciar las calles"}, {"id": "c", "label": "Romper plantas", "value": "romper plantas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-17', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Institución educativa 17', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-17-01', 'act-np1-explorador-17', 'Piensa en tu vida diaria: ¿Qué lugar de la localidad sirve para aprender?', 'La escuela es un espacio de aprendizaje.', 'single-choice', 'institución educativa', '[{"id": "a", "label": "Institución educativa", "value": "institución educativa"}, {"id": "b", "label": "Tienda de helados", "value": "tienda de helados"}, {"id": "c", "label": "Paradero", "value": "paradero"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-18', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Vecinos y vecinas 18', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-18-01', 'act-np1-explorador-18', 'Piensa en tu vida diaria: ¿Quiénes comparten los espacios públicos?', 'Son para uso común y responsable.', 'single-choice', 'vecinas y vecinos', '[{"id": "a", "label": "Vecinas y vecinos", "value": "vecinas y vecinos"}, {"id": "b", "label": "Solo una persona", "value": "solo una persona"}, {"id": "c", "label": "Solo mascotas", "value": "solo mascotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-19', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Solucionamos problemas 19', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-19-01', 'act-np1-explorador-19', 'Piensa en tu vida diaria: Si hay un problema en la localidad, debemos...', 'La convivencia mejora con acuerdos.', 'single-choice', 'dialogar y proponer mejoras', '[{"id": "a", "label": "dialogar y proponer mejoras", "value": "dialogar y proponer mejoras"}, {"id": "b", "label": "pelear", "value": "pelear"}, {"id": "c", "label": "hacer más desorden", "value": "hacer más desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-20', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la localidad 20', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-20-01', 'act-np1-explorador-20', 'Piensa en tu vida diaria: ¿Qué acción cuida tu localidad?', 'Cuidar espacios públicos beneficia a todos.', 'single-choice', 'respetar señales y espacios', '[{"id": "a", "label": "Respetar señales y espacios", "value": "respetar señales y espacios"}, {"id": "b", "label": "Rayar paredes", "value": "rayar paredes"}, {"id": "c", "label": "Dejar basura", "value": "dejar basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-21', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Conozco mi localidad 21', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-21-01', 'act-np1-explorador-21', 'En GenioKids: ¿Qué es una localidad?', 'Tu barrio, comunidad o ciudad forman parte de tu localidad.', 'single-choice', 'el lugar donde vivimos', '[{"id": "a", "label": "El lugar donde vivimos", "value": "el lugar donde vivimos"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una fruta", "value": "una fruta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-22', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Espacios públicos 22', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-22-01', 'act-np1-explorador-22', 'En GenioKids: ¿Cuál es un espacio público?', 'Los espacios públicos son compartidos por todos.', 'single-choice', 'el parque', '[{"id": "a", "label": "El parque", "value": "el parque"}, {"id": "b", "label": "Mi cama", "value": "mi cama"}, {"id": "c", "label": "Mi cuaderno", "value": "mi cuaderno"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-23', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Bomberos 23', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-23-01', 'act-np1-explorador-23', 'En GenioKids: ¿Qué institución ayuda en emergencias de fuego?', 'Los bomberos atienden incendios y emergencias.', 'single-choice', 'compañía de bomberos', '[{"id": "a", "label": "Compañía de bomberos", "value": "compañía de bomberos"}, {"id": "b", "label": "Panadería", "value": "panadería"}, {"id": "c", "label": "Juguetería", "value": "juguetería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-24', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Posta médica 24', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-24-01', 'act-np1-explorador-24', 'En GenioKids: ¿Qué institución ayuda a cuidar la salud?', 'La posta médica brinda atención de salud.', 'single-choice', 'posta médica', '[{"id": "a", "label": "Posta médica", "value": "posta médica"}, {"id": "b", "label": "Cancha", "value": "cancha"}, {"id": "c", "label": "Heladería", "value": "heladería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-25', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Municipalidad 25', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-25-01', 'act-np1-explorador-25', 'En GenioKids: ¿Qué servicio puede brindar la municipalidad?', 'La municipalidad ayuda con servicios para la comunidad.', 'single-choice', 'recoger basura', '[{"id": "a", "label": "Recoger basura", "value": "recoger basura"}, {"id": "b", "label": "Vender dulces", "value": "vender dulces"}, {"id": "c", "label": "Hacer tareas", "value": "hacer tareas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-26', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Normas de limpieza 26', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-26-01', 'act-np1-explorador-26', 'En GenioKids: ¿Qué norma ayuda a cuidar la localidad?', 'Cuidar la limpieza es responsabilidad de todos.', 'single-choice', 'botar basura en tachos', '[{"id": "a", "label": "Botar basura en tachos", "value": "botar basura en tachos"}, {"id": "b", "label": "Ensuciar las calles", "value": "ensuciar las calles"}, {"id": "c", "label": "Romper plantas", "value": "romper plantas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-27', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Institución educativa 27', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-27-01', 'act-np1-explorador-27', 'En GenioKids: ¿Qué lugar de la localidad sirve para aprender?', 'La escuela es un espacio de aprendizaje.', 'single-choice', 'institución educativa', '[{"id": "a", "label": "Institución educativa", "value": "institución educativa"}, {"id": "b", "label": "Tienda de helados", "value": "tienda de helados"}, {"id": "c", "label": "Paradero", "value": "paradero"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-28', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Vecinos y vecinas 28', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-28-01', 'act-np1-explorador-28', 'En GenioKids: ¿Quiénes comparten los espacios públicos?', 'Son para uso común y responsable.', 'single-choice', 'vecinas y vecinos', '[{"id": "a", "label": "Vecinas y vecinos", "value": "vecinas y vecinos"}, {"id": "b", "label": "Solo una persona", "value": "solo una persona"}, {"id": "c", "label": "Solo mascotas", "value": "solo mascotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-29', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Solucionamos problemas 29', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-29-01', 'act-np1-explorador-29', 'En GenioKids: Si hay un problema en la localidad, debemos...', 'La convivencia mejora con acuerdos.', 'single-choice', 'dialogar y proponer mejoras', '[{"id": "a", "label": "dialogar y proponer mejoras", "value": "dialogar y proponer mejoras"}, {"id": "b", "label": "pelear", "value": "pelear"}, {"id": "c", "label": "hacer más desorden", "value": "hacer más desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-30', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la localidad 30', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-30-01', 'act-np1-explorador-30', 'En GenioKids: ¿Qué acción cuida tu localidad?', 'Cuidar espacios públicos beneficia a todos.', 'single-choice', 'respetar señales y espacios', '[{"id": "a", "label": "Respetar señales y espacios", "value": "respetar señales y espacios"}, {"id": "b", "label": "Rayar paredes", "value": "rayar paredes"}, {"id": "c", "label": "Dejar basura", "value": "dejar basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-31', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Conozco mi localidad 31', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-31-01', 'act-np1-explorador-31', 'Reto ciudadano: ¿Qué es una localidad?', 'Tu barrio, comunidad o ciudad forman parte de tu localidad.', 'single-choice', 'el lugar donde vivimos', '[{"id": "a", "label": "El lugar donde vivimos", "value": "el lugar donde vivimos"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una fruta", "value": "una fruta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-32', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Espacios públicos 32', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-32-01', 'act-np1-explorador-32', 'Reto ciudadano: ¿Cuál es un espacio público?', 'Los espacios públicos son compartidos por todos.', 'single-choice', 'el parque', '[{"id": "a", "label": "El parque", "value": "el parque"}, {"id": "b", "label": "Mi cama", "value": "mi cama"}, {"id": "c", "label": "Mi cuaderno", "value": "mi cuaderno"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-33', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Bomberos 33', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-33-01', 'act-np1-explorador-33', 'Reto ciudadano: ¿Qué institución ayuda en emergencias de fuego?', 'Los bomberos atienden incendios y emergencias.', 'single-choice', 'compañía de bomberos', '[{"id": "a", "label": "Compañía de bomberos", "value": "compañía de bomberos"}, {"id": "b", "label": "Panadería", "value": "panadería"}, {"id": "c", "label": "Juguetería", "value": "juguetería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-34', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Posta médica 34', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-34-01', 'act-np1-explorador-34', 'Reto ciudadano: ¿Qué institución ayuda a cuidar la salud?', 'La posta médica brinda atención de salud.', 'single-choice', 'posta médica', '[{"id": "a", "label": "Posta médica", "value": "posta médica"}, {"id": "b", "label": "Cancha", "value": "cancha"}, {"id": "c", "label": "Heladería", "value": "heladería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-35', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Municipalidad 35', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-35-01', 'act-np1-explorador-35', 'Reto ciudadano: ¿Qué servicio puede brindar la municipalidad?', 'La municipalidad ayuda con servicios para la comunidad.', 'single-choice', 'recoger basura', '[{"id": "a", "label": "Recoger basura", "value": "recoger basura"}, {"id": "b", "label": "Vender dulces", "value": "vender dulces"}, {"id": "c", "label": "Hacer tareas", "value": "hacer tareas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-36', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Normas de limpieza 36', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-36-01', 'act-np1-explorador-36', 'Reto ciudadano: ¿Qué norma ayuda a cuidar la localidad?', 'Cuidar la limpieza es responsabilidad de todos.', 'single-choice', 'botar basura en tachos', '[{"id": "a", "label": "Botar basura en tachos", "value": "botar basura en tachos"}, {"id": "b", "label": "Ensuciar las calles", "value": "ensuciar las calles"}, {"id": "c", "label": "Romper plantas", "value": "romper plantas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-37', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Institución educativa 37', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-37-01', 'act-np1-explorador-37', 'Reto ciudadano: ¿Qué lugar de la localidad sirve para aprender?', 'La escuela es un espacio de aprendizaje.', 'single-choice', 'institución educativa', '[{"id": "a", "label": "Institución educativa", "value": "institución educativa"}, {"id": "b", "label": "Tienda de helados", "value": "tienda de helados"}, {"id": "c", "label": "Paradero", "value": "paradero"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-38', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Vecinos y vecinas 38', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-38-01', 'act-np1-explorador-38', 'Reto ciudadano: ¿Quiénes comparten los espacios públicos?', 'Son para uso común y responsable.', 'single-choice', 'vecinas y vecinos', '[{"id": "a", "label": "Vecinas y vecinos", "value": "vecinas y vecinos"}, {"id": "b", "label": "Solo una persona", "value": "solo una persona"}, {"id": "c", "label": "Solo mascotas", "value": "solo mascotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-39', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Solucionamos problemas 39', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-39-01', 'act-np1-explorador-39', 'Reto ciudadano: Si hay un problema en la localidad, debemos...', 'La convivencia mejora con acuerdos.', 'single-choice', 'dialogar y proponer mejoras', '[{"id": "a", "label": "dialogar y proponer mejoras", "value": "dialogar y proponer mejoras"}, {"id": "b", "label": "pelear", "value": "pelear"}, {"id": "c", "label": "hacer más desorden", "value": "hacer más desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-40', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la localidad 40', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-40-01', 'act-np1-explorador-40', 'Reto ciudadano: ¿Qué acción cuida tu localidad?', 'Cuidar espacios públicos beneficia a todos.', 'single-choice', 'respetar señales y espacios', '[{"id": "a", "label": "Respetar señales y espacios", "value": "respetar señales y espacios"}, {"id": "b", "label": "Rayar paredes", "value": "rayar paredes"}, {"id": "c", "label": "Dejar basura", "value": "dejar basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-41', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Conozco mi localidad 41', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-41-01', 'act-np1-explorador-41', 'Elige la mejor acción: ¿Qué es una localidad?', 'Tu barrio, comunidad o ciudad forman parte de tu localidad.', 'single-choice', 'el lugar donde vivimos', '[{"id": "a", "label": "El lugar donde vivimos", "value": "el lugar donde vivimos"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una fruta", "value": "una fruta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-42', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Espacios públicos 42', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-42-01', 'act-np1-explorador-42', 'Elige la mejor acción: ¿Cuál es un espacio público?', 'Los espacios públicos son compartidos por todos.', 'single-choice', 'el parque', '[{"id": "a", "label": "El parque", "value": "el parque"}, {"id": "b", "label": "Mi cama", "value": "mi cama"}, {"id": "c", "label": "Mi cuaderno", "value": "mi cuaderno"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-43', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Bomberos 43', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-43-01', 'act-np1-explorador-43', 'Elige la mejor acción: ¿Qué institución ayuda en emergencias de fuego?', 'Los bomberos atienden incendios y emergencias.', 'single-choice', 'compañía de bomberos', '[{"id": "a", "label": "Compañía de bomberos", "value": "compañía de bomberos"}, {"id": "b", "label": "Panadería", "value": "panadería"}, {"id": "c", "label": "Juguetería", "value": "juguetería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-44', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Posta médica 44', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-44-01', 'act-np1-explorador-44', 'Elige la mejor acción: ¿Qué institución ayuda a cuidar la salud?', 'La posta médica brinda atención de salud.', 'single-choice', 'posta médica', '[{"id": "a", "label": "Posta médica", "value": "posta médica"}, {"id": "b", "label": "Cancha", "value": "cancha"}, {"id": "c", "label": "Heladería", "value": "heladería"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-45', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Municipalidad 45', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-45-01', 'act-np1-explorador-45', 'Elige la mejor acción: ¿Qué servicio puede brindar la municipalidad?', 'La municipalidad ayuda con servicios para la comunidad.', 'single-choice', 'recoger basura', '[{"id": "a", "label": "Recoger basura", "value": "recoger basura"}, {"id": "b", "label": "Vender dulces", "value": "vender dulces"}, {"id": "c", "label": "Hacer tareas", "value": "hacer tareas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-46', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Normas de limpieza 46', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-46-01', 'act-np1-explorador-46', 'Elige la mejor acción: ¿Qué norma ayuda a cuidar la localidad?', 'Cuidar la limpieza es responsabilidad de todos.', 'single-choice', 'botar basura en tachos', '[{"id": "a", "label": "Botar basura en tachos", "value": "botar basura en tachos"}, {"id": "b", "label": "Ensuciar las calles", "value": "ensuciar las calles"}, {"id": "c", "label": "Romper plantas", "value": "romper plantas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-47', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Institución educativa 47', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-47-01', 'act-np1-explorador-47', 'Elige la mejor acción: ¿Qué lugar de la localidad sirve para aprender?', 'La escuela es un espacio de aprendizaje.', 'single-choice', 'institución educativa', '[{"id": "a", "label": "Institución educativa", "value": "institución educativa"}, {"id": "b", "label": "Tienda de helados", "value": "tienda de helados"}, {"id": "c", "label": "Paradero", "value": "paradero"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-48', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Vecinos y vecinas 48', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-48-01', 'act-np1-explorador-48', 'Elige la mejor acción: ¿Quiénes comparten los espacios públicos?', 'Son para uso común y responsable.', 'single-choice', 'vecinas y vecinos', '[{"id": "a", "label": "Vecinas y vecinos", "value": "vecinas y vecinos"}, {"id": "b", "label": "Solo una persona", "value": "solo una persona"}, {"id": "c", "label": "Solo mascotas", "value": "solo mascotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-49', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Solucionamos problemas 49', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-49-01', 'act-np1-explorador-49', 'Elige la mejor acción: Si hay un problema en la localidad, debemos...', 'La convivencia mejora con acuerdos.', 'single-choice', 'dialogar y proponer mejoras', '[{"id": "a", "label": "dialogar y proponer mejoras", "value": "dialogar y proponer mejoras"}, {"id": "b", "label": "pelear", "value": "pelear"}, {"id": "c", "label": "hacer más desorden", "value": "hacer más desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-explorador-50', 'les-nuestro-pais-1p-explorador', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la localidad 50', 'Actividad de Nuestro País sobre mi localidad y yo. Cada misión vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-explorador-50-01', 'act-np1-explorador-50', 'Elige la mejor acción: ¿Qué acción cuida tu localidad?', 'Cuidar espacios públicos beneficia a todos.', 'single-choice', 'respetar señales y espacios', '[{"id": "a", "label": "Respetar señales y espacios", "value": "respetar señales y espacios"}, {"id": "b", "label": "Rayar paredes", "value": "rayar paredes"}, {"id": "c", "label": "Dejar basura", "value": "dejar basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'aventurero', '🧭 Aventurero Ágil - Mi escuela y yo', 'Escuela, ambientes, trabajadores, acuerdos y convivencia.', 3, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-01', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Mi escuela 01', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-01-01', 'act-np1-aventurero-01', '¿Para qué sirve la escuela?', 'La escuela ayuda a aprender y relacionarnos mejor.', 'single-choice', 'para aprender y convivir', '[{"id": "a", "label": "Para aprender y convivir", "value": "para aprender y convivir"}, {"id": "b", "label": "Para dormir todo el día", "value": "para dormir todo el día"}, {"id": "c", "label": "Para romper útiles", "value": "para romper útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-02', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Biblioteca 02', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-02-01', 'act-np1-aventurero-02', '¿Qué espacio escolar se usa para leer libros?', 'La biblioteca guarda libros y materiales de lectura.', 'single-choice', 'biblioteca', '[{"id": "a", "label": "Biblioteca", "value": "biblioteca"}, {"id": "b", "label": "Baño", "value": "baño"}, {"id": "c", "label": "Patio de recreo", "value": "patio de recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-03', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Emergencias en la escuela 03', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-03-01', 'act-np1-aventurero-03', '¿Quién puede ayudar cuando hay una emergencia de salud en la escuela?', 'En la escuela hay adultos que ayudan.', 'single-choice', 'personal responsable o enfermería', '[{"id": "a", "label": "Personal responsable o enfermería", "value": "personal responsable o enfermería"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una pared", "value": "una pared"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-04', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Acuerdos de aula 04', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-04-01', 'act-np1-aventurero-04', '¿Qué es un acuerdo de aula?', 'Los acuerdos orientan el buen trato.', 'single-choice', 'una regla para convivir mejor', '[{"id": "a", "label": "Una regla para convivir mejor", "value": "una regla para convivir mejor"}, {"id": "b", "label": "Un dulce", "value": "un dulce"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-05', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Ayuda entre compañeros 05', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-05-01', 'act-np1-aventurero-05', 'Si un compañero no entiende una actividad, puedo...', 'La cooperación fortalece el aula.', 'single-choice', 'ayudarlo con respeto', '[{"id": "a", "label": "ayudarlo con respeto", "value": "ayudarlo con respeto"}, {"id": "b", "label": "burlarme", "value": "burlarme"}, {"id": "c", "label": "quitarle su lápiz", "value": "quitarle su lápiz"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-06', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la escuela 06', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-06-01', 'act-np1-aventurero-06', '¿Qué acción demuestra cuidado de la escuela?', 'La escuela es de todos.', 'single-choice', 'mantener limpia el aula', '[{"id": "a", "label": "Mantener limpia el aula", "value": "mantener limpia el aula"}, {"id": "b", "label": "Ensuciar carpetas", "value": "ensuciar carpetas"}, {"id": "c", "label": "Gritar siempre", "value": "gritar siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-07', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Comunidad educativa 07', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-07-01', 'act-np1-aventurero-07', '¿Quiénes forman parte de la comunidad educativa?', 'La escuela se construye con muchas personas.', 'single-choice', 'estudiantes, docentes y familias', '[{"id": "a", "label": "Estudiantes, docentes y familias", "value": "estudiantes, docentes y familias"}, {"id": "b", "label": "Solo los lápices", "value": "solo los lápices"}, {"id": "c", "label": "Solo las pelotas", "value": "solo las pelotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-08', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Conflictos escolares 08', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-08-01', 'act-np1-aventurero-08', '¿Qué debemos hacer si hay un conflicto en la escuela?', 'El diálogo evita más problemas.', 'single-choice', 'hablar y buscar solución', '[{"id": "a", "label": "Hablar y buscar solución", "value": "hablar y buscar solución"}, {"id": "b", "label": "Empujar", "value": "empujar"}, {"id": "c", "label": "No escuchar", "value": "no escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-09', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Patio seguro 09', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-09-01', 'act-np1-aventurero-09', '¿Qué espacio escolar se usa para jugar con cuidado?', 'El patio sirve para recrearse respetando normas.', 'single-choice', 'patio', '[{"id": "a", "label": "Patio", "value": "patio"}, {"id": "b", "label": "Dirección", "value": "dirección"}, {"id": "c", "label": "Biblioteca silenciosa", "value": "biblioteca silenciosa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-10', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Participar para aprender 10', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-10-01', 'act-np1-aventurero-10', '¿Qué actitud ayuda a aprender mejor?', 'Participar con respeto mejora el aprendizaje.', 'single-choice', 'escuchar y participar', '[{"id": "a", "label": "Escuchar y participar", "value": "escuchar y participar"}, {"id": "b", "label": "Interrumpir siempre", "value": "interrumpir siempre"}, {"id": "c", "label": "Esconder cuadernos", "value": "esconder cuadernos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-11', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Mi escuela 11', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-11-01', 'act-np1-aventurero-11', 'Piensa en tu vida diaria: ¿Para qué sirve la escuela?', 'La escuela ayuda a aprender y relacionarnos mejor.', 'single-choice', 'para aprender y convivir', '[{"id": "a", "label": "Para aprender y convivir", "value": "para aprender y convivir"}, {"id": "b", "label": "Para dormir todo el día", "value": "para dormir todo el día"}, {"id": "c", "label": "Para romper útiles", "value": "para romper útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-12', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Biblioteca 12', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-12-01', 'act-np1-aventurero-12', 'Piensa en tu vida diaria: ¿Qué espacio escolar se usa para leer libros?', 'La biblioteca guarda libros y materiales de lectura.', 'single-choice', 'biblioteca', '[{"id": "a", "label": "Biblioteca", "value": "biblioteca"}, {"id": "b", "label": "Baño", "value": "baño"}, {"id": "c", "label": "Patio de recreo", "value": "patio de recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-13', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Emergencias en la escuela 13', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-13-01', 'act-np1-aventurero-13', 'Piensa en tu vida diaria: ¿Quién puede ayudar cuando hay una emergencia de salud en la escuela?', 'En la escuela hay adultos que ayudan.', 'single-choice', 'personal responsable o enfermería', '[{"id": "a", "label": "Personal responsable o enfermería", "value": "personal responsable o enfermería"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una pared", "value": "una pared"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-14', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Acuerdos de aula 14', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-14-01', 'act-np1-aventurero-14', 'Piensa en tu vida diaria: ¿Qué es un acuerdo de aula?', 'Los acuerdos orientan el buen trato.', 'single-choice', 'una regla para convivir mejor', '[{"id": "a", "label": "Una regla para convivir mejor", "value": "una regla para convivir mejor"}, {"id": "b", "label": "Un dulce", "value": "un dulce"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-15', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Ayuda entre compañeros 15', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-15-01', 'act-np1-aventurero-15', 'Piensa en tu vida diaria: Si un compañero no entiende una actividad, puedo...', 'La cooperación fortalece el aula.', 'single-choice', 'ayudarlo con respeto', '[{"id": "a", "label": "ayudarlo con respeto", "value": "ayudarlo con respeto"}, {"id": "b", "label": "burlarme", "value": "burlarme"}, {"id": "c", "label": "quitarle su lápiz", "value": "quitarle su lápiz"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-16', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la escuela 16', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-16-01', 'act-np1-aventurero-16', 'Piensa en tu vida diaria: ¿Qué acción demuestra cuidado de la escuela?', 'La escuela es de todos.', 'single-choice', 'mantener limpia el aula', '[{"id": "a", "label": "Mantener limpia el aula", "value": "mantener limpia el aula"}, {"id": "b", "label": "Ensuciar carpetas", "value": "ensuciar carpetas"}, {"id": "c", "label": "Gritar siempre", "value": "gritar siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-17', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Comunidad educativa 17', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-17-01', 'act-np1-aventurero-17', 'Piensa en tu vida diaria: ¿Quiénes forman parte de la comunidad educativa?', 'La escuela se construye con muchas personas.', 'single-choice', 'estudiantes, docentes y familias', '[{"id": "a", "label": "Estudiantes, docentes y familias", "value": "estudiantes, docentes y familias"}, {"id": "b", "label": "Solo los lápices", "value": "solo los lápices"}, {"id": "c", "label": "Solo las pelotas", "value": "solo las pelotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-18', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Conflictos escolares 18', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-18-01', 'act-np1-aventurero-18', 'Piensa en tu vida diaria: ¿Qué debemos hacer si hay un conflicto en la escuela?', 'El diálogo evita más problemas.', 'single-choice', 'hablar y buscar solución', '[{"id": "a", "label": "Hablar y buscar solución", "value": "hablar y buscar solución"}, {"id": "b", "label": "Empujar", "value": "empujar"}, {"id": "c", "label": "No escuchar", "value": "no escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-19', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Patio seguro 19', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-19-01', 'act-np1-aventurero-19', 'Piensa en tu vida diaria: ¿Qué espacio escolar se usa para jugar con cuidado?', 'El patio sirve para recrearse respetando normas.', 'single-choice', 'patio', '[{"id": "a", "label": "Patio", "value": "patio"}, {"id": "b", "label": "Dirección", "value": "dirección"}, {"id": "c", "label": "Biblioteca silenciosa", "value": "biblioteca silenciosa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-20', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Participar para aprender 20', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-20-01', 'act-np1-aventurero-20', 'Piensa en tu vida diaria: ¿Qué actitud ayuda a aprender mejor?', 'Participar con respeto mejora el aprendizaje.', 'single-choice', 'escuchar y participar', '[{"id": "a", "label": "Escuchar y participar", "value": "escuchar y participar"}, {"id": "b", "label": "Interrumpir siempre", "value": "interrumpir siempre"}, {"id": "c", "label": "Esconder cuadernos", "value": "esconder cuadernos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-21', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Mi escuela 21', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-21-01', 'act-np1-aventurero-21', 'En GenioKids: ¿Para qué sirve la escuela?', 'La escuela ayuda a aprender y relacionarnos mejor.', 'single-choice', 'para aprender y convivir', '[{"id": "a", "label": "Para aprender y convivir", "value": "para aprender y convivir"}, {"id": "b", "label": "Para dormir todo el día", "value": "para dormir todo el día"}, {"id": "c", "label": "Para romper útiles", "value": "para romper útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-22', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Biblioteca 22', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-22-01', 'act-np1-aventurero-22', 'En GenioKids: ¿Qué espacio escolar se usa para leer libros?', 'La biblioteca guarda libros y materiales de lectura.', 'single-choice', 'biblioteca', '[{"id": "a", "label": "Biblioteca", "value": "biblioteca"}, {"id": "b", "label": "Baño", "value": "baño"}, {"id": "c", "label": "Patio de recreo", "value": "patio de recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-23', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Emergencias en la escuela 23', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-23-01', 'act-np1-aventurero-23', 'En GenioKids: ¿Quién puede ayudar cuando hay una emergencia de salud en la escuela?', 'En la escuela hay adultos que ayudan.', 'single-choice', 'personal responsable o enfermería', '[{"id": "a", "label": "Personal responsable o enfermería", "value": "personal responsable o enfermería"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una pared", "value": "una pared"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-24', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Acuerdos de aula 24', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-24-01', 'act-np1-aventurero-24', 'En GenioKids: ¿Qué es un acuerdo de aula?', 'Los acuerdos orientan el buen trato.', 'single-choice', 'una regla para convivir mejor', '[{"id": "a", "label": "Una regla para convivir mejor", "value": "una regla para convivir mejor"}, {"id": "b", "label": "Un dulce", "value": "un dulce"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-25', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Ayuda entre compañeros 25', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-25-01', 'act-np1-aventurero-25', 'En GenioKids: Si un compañero no entiende una actividad, puedo...', 'La cooperación fortalece el aula.', 'single-choice', 'ayudarlo con respeto', '[{"id": "a", "label": "ayudarlo con respeto", "value": "ayudarlo con respeto"}, {"id": "b", "label": "burlarme", "value": "burlarme"}, {"id": "c", "label": "quitarle su lápiz", "value": "quitarle su lápiz"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-26', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la escuela 26', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-26-01', 'act-np1-aventurero-26', 'En GenioKids: ¿Qué acción demuestra cuidado de la escuela?', 'La escuela es de todos.', 'single-choice', 'mantener limpia el aula', '[{"id": "a", "label": "Mantener limpia el aula", "value": "mantener limpia el aula"}, {"id": "b", "label": "Ensuciar carpetas", "value": "ensuciar carpetas"}, {"id": "c", "label": "Gritar siempre", "value": "gritar siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-27', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Comunidad educativa 27', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-27-01', 'act-np1-aventurero-27', 'En GenioKids: ¿Quiénes forman parte de la comunidad educativa?', 'La escuela se construye con muchas personas.', 'single-choice', 'estudiantes, docentes y familias', '[{"id": "a", "label": "Estudiantes, docentes y familias", "value": "estudiantes, docentes y familias"}, {"id": "b", "label": "Solo los lápices", "value": "solo los lápices"}, {"id": "c", "label": "Solo las pelotas", "value": "solo las pelotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-28', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Conflictos escolares 28', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-28-01', 'act-np1-aventurero-28', 'En GenioKids: ¿Qué debemos hacer si hay un conflicto en la escuela?', 'El diálogo evita más problemas.', 'single-choice', 'hablar y buscar solución', '[{"id": "a", "label": "Hablar y buscar solución", "value": "hablar y buscar solución"}, {"id": "b", "label": "Empujar", "value": "empujar"}, {"id": "c", "label": "No escuchar", "value": "no escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-29', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Patio seguro 29', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-29-01', 'act-np1-aventurero-29', 'En GenioKids: ¿Qué espacio escolar se usa para jugar con cuidado?', 'El patio sirve para recrearse respetando normas.', 'single-choice', 'patio', '[{"id": "a", "label": "Patio", "value": "patio"}, {"id": "b", "label": "Dirección", "value": "dirección"}, {"id": "c", "label": "Biblioteca silenciosa", "value": "biblioteca silenciosa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-30', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Participar para aprender 30', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-30-01', 'act-np1-aventurero-30', 'En GenioKids: ¿Qué actitud ayuda a aprender mejor?', 'Participar con respeto mejora el aprendizaje.', 'single-choice', 'escuchar y participar', '[{"id": "a", "label": "Escuchar y participar", "value": "escuchar y participar"}, {"id": "b", "label": "Interrumpir siempre", "value": "interrumpir siempre"}, {"id": "c", "label": "Esconder cuadernos", "value": "esconder cuadernos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-31', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Mi escuela 31', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-31-01', 'act-np1-aventurero-31', 'Reto ciudadano: ¿Para qué sirve la escuela?', 'La escuela ayuda a aprender y relacionarnos mejor.', 'single-choice', 'para aprender y convivir', '[{"id": "a", "label": "Para aprender y convivir", "value": "para aprender y convivir"}, {"id": "b", "label": "Para dormir todo el día", "value": "para dormir todo el día"}, {"id": "c", "label": "Para romper útiles", "value": "para romper útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-32', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Biblioteca 32', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-32-01', 'act-np1-aventurero-32', 'Reto ciudadano: ¿Qué espacio escolar se usa para leer libros?', 'La biblioteca guarda libros y materiales de lectura.', 'single-choice', 'biblioteca', '[{"id": "a", "label": "Biblioteca", "value": "biblioteca"}, {"id": "b", "label": "Baño", "value": "baño"}, {"id": "c", "label": "Patio de recreo", "value": "patio de recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-33', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Emergencias en la escuela 33', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-33-01', 'act-np1-aventurero-33', 'Reto ciudadano: ¿Quién puede ayudar cuando hay una emergencia de salud en la escuela?', 'En la escuela hay adultos que ayudan.', 'single-choice', 'personal responsable o enfermería', '[{"id": "a", "label": "Personal responsable o enfermería", "value": "personal responsable o enfermería"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una pared", "value": "una pared"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-34', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Acuerdos de aula 34', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-34-01', 'act-np1-aventurero-34', 'Reto ciudadano: ¿Qué es un acuerdo de aula?', 'Los acuerdos orientan el buen trato.', 'single-choice', 'una regla para convivir mejor', '[{"id": "a", "label": "Una regla para convivir mejor", "value": "una regla para convivir mejor"}, {"id": "b", "label": "Un dulce", "value": "un dulce"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-35', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Ayuda entre compañeros 35', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-35-01', 'act-np1-aventurero-35', 'Reto ciudadano: Si un compañero no entiende una actividad, puedo...', 'La cooperación fortalece el aula.', 'single-choice', 'ayudarlo con respeto', '[{"id": "a", "label": "ayudarlo con respeto", "value": "ayudarlo con respeto"}, {"id": "b", "label": "burlarme", "value": "burlarme"}, {"id": "c", "label": "quitarle su lápiz", "value": "quitarle su lápiz"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-36', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la escuela 36', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-36-01', 'act-np1-aventurero-36', 'Reto ciudadano: ¿Qué acción demuestra cuidado de la escuela?', 'La escuela es de todos.', 'single-choice', 'mantener limpia el aula', '[{"id": "a", "label": "Mantener limpia el aula", "value": "mantener limpia el aula"}, {"id": "b", "label": "Ensuciar carpetas", "value": "ensuciar carpetas"}, {"id": "c", "label": "Gritar siempre", "value": "gritar siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-37', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Comunidad educativa 37', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-37-01', 'act-np1-aventurero-37', 'Reto ciudadano: ¿Quiénes forman parte de la comunidad educativa?', 'La escuela se construye con muchas personas.', 'single-choice', 'estudiantes, docentes y familias', '[{"id": "a", "label": "Estudiantes, docentes y familias", "value": "estudiantes, docentes y familias"}, {"id": "b", "label": "Solo los lápices", "value": "solo los lápices"}, {"id": "c", "label": "Solo las pelotas", "value": "solo las pelotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-38', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Conflictos escolares 38', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-38-01', 'act-np1-aventurero-38', 'Reto ciudadano: ¿Qué debemos hacer si hay un conflicto en la escuela?', 'El diálogo evita más problemas.', 'single-choice', 'hablar y buscar solución', '[{"id": "a", "label": "Hablar y buscar solución", "value": "hablar y buscar solución"}, {"id": "b", "label": "Empujar", "value": "empujar"}, {"id": "c", "label": "No escuchar", "value": "no escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-39', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Patio seguro 39', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-39-01', 'act-np1-aventurero-39', 'Reto ciudadano: ¿Qué espacio escolar se usa para jugar con cuidado?', 'El patio sirve para recrearse respetando normas.', 'single-choice', 'patio', '[{"id": "a", "label": "Patio", "value": "patio"}, {"id": "b", "label": "Dirección", "value": "dirección"}, {"id": "c", "label": "Biblioteca silenciosa", "value": "biblioteca silenciosa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-40', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Participar para aprender 40', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-40-01', 'act-np1-aventurero-40', 'Reto ciudadano: ¿Qué actitud ayuda a aprender mejor?', 'Participar con respeto mejora el aprendizaje.', 'single-choice', 'escuchar y participar', '[{"id": "a", "label": "Escuchar y participar", "value": "escuchar y participar"}, {"id": "b", "label": "Interrumpir siempre", "value": "interrumpir siempre"}, {"id": "c", "label": "Esconder cuadernos", "value": "esconder cuadernos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-41', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Mi escuela 41', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-41-01', 'act-np1-aventurero-41', 'Elige la mejor acción: ¿Para qué sirve la escuela?', 'La escuela ayuda a aprender y relacionarnos mejor.', 'single-choice', 'para aprender y convivir', '[{"id": "a", "label": "Para aprender y convivir", "value": "para aprender y convivir"}, {"id": "b", "label": "Para dormir todo el día", "value": "para dormir todo el día"}, {"id": "c", "label": "Para romper útiles", "value": "para romper útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-42', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Biblioteca 42', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-42-01', 'act-np1-aventurero-42', 'Elige la mejor acción: ¿Qué espacio escolar se usa para leer libros?', 'La biblioteca guarda libros y materiales de lectura.', 'single-choice', 'biblioteca', '[{"id": "a", "label": "Biblioteca", "value": "biblioteca"}, {"id": "b", "label": "Baño", "value": "baño"}, {"id": "c", "label": "Patio de recreo", "value": "patio de recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-43', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Emergencias en la escuela 43', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-43-01', 'act-np1-aventurero-43', 'Elige la mejor acción: ¿Quién puede ayudar cuando hay una emergencia de salud en la escuela?', 'En la escuela hay adultos que ayudan.', 'single-choice', 'personal responsable o enfermería', '[{"id": "a", "label": "Personal responsable o enfermería", "value": "personal responsable o enfermería"}, {"id": "b", "label": "Un juguete", "value": "un juguete"}, {"id": "c", "label": "Una pared", "value": "una pared"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-44', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Acuerdos de aula 44', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-44-01', 'act-np1-aventurero-44', 'Elige la mejor acción: ¿Qué es un acuerdo de aula?', 'Los acuerdos orientan el buen trato.', 'single-choice', 'una regla para convivir mejor', '[{"id": "a", "label": "Una regla para convivir mejor", "value": "una regla para convivir mejor"}, {"id": "b", "label": "Un dulce", "value": "un dulce"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-45', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Ayuda entre compañeros 45', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-45-01', 'act-np1-aventurero-45', 'Elige la mejor acción: Si un compañero no entiende una actividad, puedo...', 'La cooperación fortalece el aula.', 'single-choice', 'ayudarlo con respeto', '[{"id": "a", "label": "ayudarlo con respeto", "value": "ayudarlo con respeto"}, {"id": "b", "label": "burlarme", "value": "burlarme"}, {"id": "c", "label": "quitarle su lápiz", "value": "quitarle su lápiz"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-46', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Cuidamos la escuela 46', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-46-01', 'act-np1-aventurero-46', 'Elige la mejor acción: ¿Qué acción demuestra cuidado de la escuela?', 'La escuela es de todos.', 'single-choice', 'mantener limpia el aula', '[{"id": "a", "label": "Mantener limpia el aula", "value": "mantener limpia el aula"}, {"id": "b", "label": "Ensuciar carpetas", "value": "ensuciar carpetas"}, {"id": "c", "label": "Gritar siempre", "value": "gritar siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-47', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Comunidad educativa 47', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-47-01', 'act-np1-aventurero-47', 'Elige la mejor acción: ¿Quiénes forman parte de la comunidad educativa?', 'La escuela se construye con muchas personas.', 'single-choice', 'estudiantes, docentes y familias', '[{"id": "a", "label": "Estudiantes, docentes y familias", "value": "estudiantes, docentes y familias"}, {"id": "b", "label": "Solo los lápices", "value": "solo los lápices"}, {"id": "c", "label": "Solo las pelotas", "value": "solo las pelotas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-48', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Conflictos escolares 48', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-48-01', 'act-np1-aventurero-48', 'Elige la mejor acción: ¿Qué debemos hacer si hay un conflicto en la escuela?', 'El diálogo evita más problemas.', 'single-choice', 'hablar y buscar solución', '[{"id": "a", "label": "Hablar y buscar solución", "value": "hablar y buscar solución"}, {"id": "b", "label": "Empujar", "value": "empujar"}, {"id": "c", "label": "No escuchar", "value": "no escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-49', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Patio seguro 49', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-49-01', 'act-np1-aventurero-49', 'Elige la mejor acción: ¿Qué espacio escolar se usa para jugar con cuidado?', 'El patio sirve para recrearse respetando normas.', 'single-choice', 'patio', '[{"id": "a", "label": "Patio", "value": "patio"}, {"id": "b", "label": "Dirección", "value": "dirección"}, {"id": "c", "label": "Biblioteca silenciosa", "value": "biblioteca silenciosa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-aventurero-50', 'les-nuestro-pais-1p-aventurero', 'nuestro-pais-primaria', '1-primaria', 'Participar para aprender 50', 'Actividad de Nuestro País sobre mi escuela y yo. Cada misión vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-aventurero-50-01', 'act-np1-aventurero-50', 'Elige la mejor acción: ¿Qué actitud ayuda a aprender mejor?', 'Participar con respeto mejora el aprendizaje.', 'single-choice', 'escuchar y participar', '[{"id": "a", "label": "Escuchar y participar", "value": "escuchar y participar"}, {"id": "b", "label": "Interrumpir siempre", "value": "interrumpir siempre"}, {"id": "c", "label": "Esconder cuadernos", "value": "esconder cuadernos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'estrella', '⭐ Estrella Brillante - Convivencia y buen trato', 'Respeto, igualdad, inclusión, cooperación, emociones y solución de conflictos.', 4, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-01', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Buen trato 01', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-01-01', 'act-np1-estrella-01', '¿Qué significa buen trato?', 'El buen trato reconoce el valor de cada persona.', 'single-choice', 'tratar con respeto y cuidado', '[{"id": "a", "label": "Tratar con respeto y cuidado", "value": "tratar con respeto y cuidado"}, {"id": "b", "label": "Insultar", "value": "insultar"}, {"id": "c", "label": "Ignorar a todos", "value": "ignorar a todos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-02', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a diferencias 02', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-02-01', 'act-np1-estrella-02', 'Si alguien es diferente a mí, debo...', 'Todas las personas merecen respeto.', 'single-choice', 'respetarlo', '[{"id": "a", "label": "respetarlo", "value": "respetarlo"}, {"id": "b", "label": "rechazarlo", "value": "rechazarlo"}, {"id": "c", "label": "burlarme", "value": "burlarme"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-03', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Dialogar 03', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-03-01', 'act-np1-estrella-03', '¿Qué ayuda a resolver un desacuerdo?', 'El diálogo permite entendernos.', 'single-choice', 'escuchar y dialogar', '[{"id": "a", "label": "Escuchar y dialogar", "value": "escuchar y dialogar"}, {"id": "b", "label": "Gritar más fuerte", "value": "gritar más fuerte"}, {"id": "c", "label": "Romper objetos", "value": "romper objetos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-04', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Inclusión 04', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-04-01', 'act-np1-estrella-04', '¿Qué acción muestra inclusión?', 'Incluir es permitir que todos formen parte.', 'single-choice', 'invitar a participar', '[{"id": "a", "label": "Invitar a participar", "value": "invitar a participar"}, {"id": "b", "label": "Dejar fuera", "value": "dejar fuera"}, {"id": "c", "label": "Esconder materiales", "value": "esconder materiales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-05', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Espacios comunes 05', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-05-01', 'act-np1-estrella-05', '¿Qué debemos hacer con los espacios comunes?', 'Los espacios comunes son de todos.', 'single-choice', 'cuidarlos', '[{"id": "a", "label": "Cuidarlos", "value": "cuidarlos"}, {"id": "b", "label": "Ensuciarlos", "value": "ensuciarlos"}, {"id": "c", "label": "Usarlos para pelear", "value": "usarlos para pelear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-06', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Pedir disculpas 06', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-06-01', 'act-np1-estrella-06', 'Cuando cometo un error, puedo...', 'Reconocer errores ayuda a convivir.', 'single-choice', 'pedir disculpas y mejorar', '[{"id": "a", "label": "pedir disculpas y mejorar", "value": "pedir disculpas y mejorar"}, {"id": "b", "label": "culpar siempre a otros", "value": "culpar siempre a otros"}, {"id": "c", "label": "molestarme y gritar", "value": "molestarme y gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-07', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Nombrar emociones 07', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-07-01', 'act-np1-estrella-07', '¿Qué emoción puedo expresar con palabras?', 'Las emociones se pueden nombrar y conversar.', 'single-choice', 'tristeza', '[{"id": "a", "label": "Tristeza", "value": "tristeza"}, {"id": "b", "label": "Una mesa", "value": "una mesa"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-08', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Colaborar 08', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-08-01', 'act-np1-estrella-08', '¿Qué es colaborar?', 'Colaborar une esfuerzos.', 'single-choice', 'ayudar en una tarea común', '[{"id": "a", "label": "Ayudar en una tarea común", "value": "ayudar en una tarea común"}, {"id": "b", "label": "Desordenar a propósito", "value": "desordenar a propósito"}, {"id": "c", "label": "No participar", "value": "no participar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-09', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Turnos de habla 09', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-09-01', 'act-np1-estrella-09', '¿Qué debemos hacer antes de hablar en grupo?', 'Respetar turnos mejora la comunicación.', 'single-choice', 'esperar turno', '[{"id": "a", "label": "Esperar turno", "value": "esperar turno"}, {"id": "b", "label": "Gritar encima", "value": "gritar encima"}, {"id": "c", "label": "Tapar la boca", "value": "tapar la boca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-10', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a mayores 10', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-10-01', 'act-np1-estrella-10', '¿Qué acción demuestra respeto a una persona mayor?', 'El respeto se practica con acciones.', 'single-choice', 'escucharla y tratarla bien', '[{"id": "a", "label": "Escucharla y tratarla bien", "value": "escucharla y tratarla bien"}, {"id": "b", "label": "Empujarla", "value": "empujarla"}, {"id": "c", "label": "Burlarse", "value": "burlarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-11', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Buen trato 11', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-11-01', 'act-np1-estrella-11', 'Piensa en tu vida diaria: ¿Qué significa buen trato?', 'El buen trato reconoce el valor de cada persona.', 'single-choice', 'tratar con respeto y cuidado', '[{"id": "a", "label": "Tratar con respeto y cuidado", "value": "tratar con respeto y cuidado"}, {"id": "b", "label": "Insultar", "value": "insultar"}, {"id": "c", "label": "Ignorar a todos", "value": "ignorar a todos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-12', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a diferencias 12', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-12-01', 'act-np1-estrella-12', 'Piensa en tu vida diaria: Si alguien es diferente a mí, debo...', 'Todas las personas merecen respeto.', 'single-choice', 'respetarlo', '[{"id": "a", "label": "respetarlo", "value": "respetarlo"}, {"id": "b", "label": "rechazarlo", "value": "rechazarlo"}, {"id": "c", "label": "burlarme", "value": "burlarme"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-13', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Dialogar 13', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-13-01', 'act-np1-estrella-13', 'Piensa en tu vida diaria: ¿Qué ayuda a resolver un desacuerdo?', 'El diálogo permite entendernos.', 'single-choice', 'escuchar y dialogar', '[{"id": "a", "label": "Escuchar y dialogar", "value": "escuchar y dialogar"}, {"id": "b", "label": "Gritar más fuerte", "value": "gritar más fuerte"}, {"id": "c", "label": "Romper objetos", "value": "romper objetos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-14', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Inclusión 14', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-14-01', 'act-np1-estrella-14', 'Piensa en tu vida diaria: ¿Qué acción muestra inclusión?', 'Incluir es permitir que todos formen parte.', 'single-choice', 'invitar a participar', '[{"id": "a", "label": "Invitar a participar", "value": "invitar a participar"}, {"id": "b", "label": "Dejar fuera", "value": "dejar fuera"}, {"id": "c", "label": "Esconder materiales", "value": "esconder materiales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-15', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Espacios comunes 15', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-15-01', 'act-np1-estrella-15', 'Piensa en tu vida diaria: ¿Qué debemos hacer con los espacios comunes?', 'Los espacios comunes son de todos.', 'single-choice', 'cuidarlos', '[{"id": "a", "label": "Cuidarlos", "value": "cuidarlos"}, {"id": "b", "label": "Ensuciarlos", "value": "ensuciarlos"}, {"id": "c", "label": "Usarlos para pelear", "value": "usarlos para pelear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-16', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Pedir disculpas 16', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-16-01', 'act-np1-estrella-16', 'Piensa en tu vida diaria: Cuando cometo un error, puedo...', 'Reconocer errores ayuda a convivir.', 'single-choice', 'pedir disculpas y mejorar', '[{"id": "a", "label": "pedir disculpas y mejorar", "value": "pedir disculpas y mejorar"}, {"id": "b", "label": "culpar siempre a otros", "value": "culpar siempre a otros"}, {"id": "c", "label": "molestarme y gritar", "value": "molestarme y gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-17', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Nombrar emociones 17', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-17-01', 'act-np1-estrella-17', 'Piensa en tu vida diaria: ¿Qué emoción puedo expresar con palabras?', 'Las emociones se pueden nombrar y conversar.', 'single-choice', 'tristeza', '[{"id": "a", "label": "Tristeza", "value": "tristeza"}, {"id": "b", "label": "Una mesa", "value": "una mesa"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-18', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Colaborar 18', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-18-01', 'act-np1-estrella-18', 'Piensa en tu vida diaria: ¿Qué es colaborar?', 'Colaborar une esfuerzos.', 'single-choice', 'ayudar en una tarea común', '[{"id": "a", "label": "Ayudar en una tarea común", "value": "ayudar en una tarea común"}, {"id": "b", "label": "Desordenar a propósito", "value": "desordenar a propósito"}, {"id": "c", "label": "No participar", "value": "no participar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-19', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Turnos de habla 19', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-19-01', 'act-np1-estrella-19', 'Piensa en tu vida diaria: ¿Qué debemos hacer antes de hablar en grupo?', 'Respetar turnos mejora la comunicación.', 'single-choice', 'esperar turno', '[{"id": "a", "label": "Esperar turno", "value": "esperar turno"}, {"id": "b", "label": "Gritar encima", "value": "gritar encima"}, {"id": "c", "label": "Tapar la boca", "value": "tapar la boca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-20', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a mayores 20', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-20-01', 'act-np1-estrella-20', 'Piensa en tu vida diaria: ¿Qué acción demuestra respeto a una persona mayor?', 'El respeto se practica con acciones.', 'single-choice', 'escucharla y tratarla bien', '[{"id": "a", "label": "Escucharla y tratarla bien", "value": "escucharla y tratarla bien"}, {"id": "b", "label": "Empujarla", "value": "empujarla"}, {"id": "c", "label": "Burlarse", "value": "burlarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-21', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Buen trato 21', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-21-01', 'act-np1-estrella-21', 'En GenioKids: ¿Qué significa buen trato?', 'El buen trato reconoce el valor de cada persona.', 'single-choice', 'tratar con respeto y cuidado', '[{"id": "a", "label": "Tratar con respeto y cuidado", "value": "tratar con respeto y cuidado"}, {"id": "b", "label": "Insultar", "value": "insultar"}, {"id": "c", "label": "Ignorar a todos", "value": "ignorar a todos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-22', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a diferencias 22', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-22-01', 'act-np1-estrella-22', 'En GenioKids: Si alguien es diferente a mí, debo...', 'Todas las personas merecen respeto.', 'single-choice', 'respetarlo', '[{"id": "a", "label": "respetarlo", "value": "respetarlo"}, {"id": "b", "label": "rechazarlo", "value": "rechazarlo"}, {"id": "c", "label": "burlarme", "value": "burlarme"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-23', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Dialogar 23', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-23-01', 'act-np1-estrella-23', 'En GenioKids: ¿Qué ayuda a resolver un desacuerdo?', 'El diálogo permite entendernos.', 'single-choice', 'escuchar y dialogar', '[{"id": "a", "label": "Escuchar y dialogar", "value": "escuchar y dialogar"}, {"id": "b", "label": "Gritar más fuerte", "value": "gritar más fuerte"}, {"id": "c", "label": "Romper objetos", "value": "romper objetos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-24', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Inclusión 24', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-24-01', 'act-np1-estrella-24', 'En GenioKids: ¿Qué acción muestra inclusión?', 'Incluir es permitir que todos formen parte.', 'single-choice', 'invitar a participar', '[{"id": "a", "label": "Invitar a participar", "value": "invitar a participar"}, {"id": "b", "label": "Dejar fuera", "value": "dejar fuera"}, {"id": "c", "label": "Esconder materiales", "value": "esconder materiales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-25', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Espacios comunes 25', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-25-01', 'act-np1-estrella-25', 'En GenioKids: ¿Qué debemos hacer con los espacios comunes?', 'Los espacios comunes son de todos.', 'single-choice', 'cuidarlos', '[{"id": "a", "label": "Cuidarlos", "value": "cuidarlos"}, {"id": "b", "label": "Ensuciarlos", "value": "ensuciarlos"}, {"id": "c", "label": "Usarlos para pelear", "value": "usarlos para pelear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-26', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Pedir disculpas 26', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-26-01', 'act-np1-estrella-26', 'En GenioKids: Cuando cometo un error, puedo...', 'Reconocer errores ayuda a convivir.', 'single-choice', 'pedir disculpas y mejorar', '[{"id": "a", "label": "pedir disculpas y mejorar", "value": "pedir disculpas y mejorar"}, {"id": "b", "label": "culpar siempre a otros", "value": "culpar siempre a otros"}, {"id": "c", "label": "molestarme y gritar", "value": "molestarme y gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-27', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Nombrar emociones 27', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-27-01', 'act-np1-estrella-27', 'En GenioKids: ¿Qué emoción puedo expresar con palabras?', 'Las emociones se pueden nombrar y conversar.', 'single-choice', 'tristeza', '[{"id": "a", "label": "Tristeza", "value": "tristeza"}, {"id": "b", "label": "Una mesa", "value": "una mesa"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-28', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Colaborar 28', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-28-01', 'act-np1-estrella-28', 'En GenioKids: ¿Qué es colaborar?', 'Colaborar une esfuerzos.', 'single-choice', 'ayudar en una tarea común', '[{"id": "a", "label": "Ayudar en una tarea común", "value": "ayudar en una tarea común"}, {"id": "b", "label": "Desordenar a propósito", "value": "desordenar a propósito"}, {"id": "c", "label": "No participar", "value": "no participar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-29', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Turnos de habla 29', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-29-01', 'act-np1-estrella-29', 'En GenioKids: ¿Qué debemos hacer antes de hablar en grupo?', 'Respetar turnos mejora la comunicación.', 'single-choice', 'esperar turno', '[{"id": "a", "label": "Esperar turno", "value": "esperar turno"}, {"id": "b", "label": "Gritar encima", "value": "gritar encima"}, {"id": "c", "label": "Tapar la boca", "value": "tapar la boca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-30', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a mayores 30', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-30-01', 'act-np1-estrella-30', 'En GenioKids: ¿Qué acción demuestra respeto a una persona mayor?', 'El respeto se practica con acciones.', 'single-choice', 'escucharla y tratarla bien', '[{"id": "a", "label": "Escucharla y tratarla bien", "value": "escucharla y tratarla bien"}, {"id": "b", "label": "Empujarla", "value": "empujarla"}, {"id": "c", "label": "Burlarse", "value": "burlarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-31', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Buen trato 31', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-31-01', 'act-np1-estrella-31', 'Reto ciudadano: ¿Qué significa buen trato?', 'El buen trato reconoce el valor de cada persona.', 'single-choice', 'tratar con respeto y cuidado', '[{"id": "a", "label": "Tratar con respeto y cuidado", "value": "tratar con respeto y cuidado"}, {"id": "b", "label": "Insultar", "value": "insultar"}, {"id": "c", "label": "Ignorar a todos", "value": "ignorar a todos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-32', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a diferencias 32', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-32-01', 'act-np1-estrella-32', 'Reto ciudadano: Si alguien es diferente a mí, debo...', 'Todas las personas merecen respeto.', 'single-choice', 'respetarlo', '[{"id": "a", "label": "respetarlo", "value": "respetarlo"}, {"id": "b", "label": "rechazarlo", "value": "rechazarlo"}, {"id": "c", "label": "burlarme", "value": "burlarme"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-33', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Dialogar 33', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-33-01', 'act-np1-estrella-33', 'Reto ciudadano: ¿Qué ayuda a resolver un desacuerdo?', 'El diálogo permite entendernos.', 'single-choice', 'escuchar y dialogar', '[{"id": "a", "label": "Escuchar y dialogar", "value": "escuchar y dialogar"}, {"id": "b", "label": "Gritar más fuerte", "value": "gritar más fuerte"}, {"id": "c", "label": "Romper objetos", "value": "romper objetos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-34', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Inclusión 34', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-34-01', 'act-np1-estrella-34', 'Reto ciudadano: ¿Qué acción muestra inclusión?', 'Incluir es permitir que todos formen parte.', 'single-choice', 'invitar a participar', '[{"id": "a", "label": "Invitar a participar", "value": "invitar a participar"}, {"id": "b", "label": "Dejar fuera", "value": "dejar fuera"}, {"id": "c", "label": "Esconder materiales", "value": "esconder materiales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-35', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Espacios comunes 35', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-35-01', 'act-np1-estrella-35', 'Reto ciudadano: ¿Qué debemos hacer con los espacios comunes?', 'Los espacios comunes son de todos.', 'single-choice', 'cuidarlos', '[{"id": "a", "label": "Cuidarlos", "value": "cuidarlos"}, {"id": "b", "label": "Ensuciarlos", "value": "ensuciarlos"}, {"id": "c", "label": "Usarlos para pelear", "value": "usarlos para pelear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-36', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Pedir disculpas 36', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-36-01', 'act-np1-estrella-36', 'Reto ciudadano: Cuando cometo un error, puedo...', 'Reconocer errores ayuda a convivir.', 'single-choice', 'pedir disculpas y mejorar', '[{"id": "a", "label": "pedir disculpas y mejorar", "value": "pedir disculpas y mejorar"}, {"id": "b", "label": "culpar siempre a otros", "value": "culpar siempre a otros"}, {"id": "c", "label": "molestarme y gritar", "value": "molestarme y gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-37', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Nombrar emociones 37', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-37-01', 'act-np1-estrella-37', 'Reto ciudadano: ¿Qué emoción puedo expresar con palabras?', 'Las emociones se pueden nombrar y conversar.', 'single-choice', 'tristeza', '[{"id": "a", "label": "Tristeza", "value": "tristeza"}, {"id": "b", "label": "Una mesa", "value": "una mesa"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-38', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Colaborar 38', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-38-01', 'act-np1-estrella-38', 'Reto ciudadano: ¿Qué es colaborar?', 'Colaborar une esfuerzos.', 'single-choice', 'ayudar en una tarea común', '[{"id": "a", "label": "Ayudar en una tarea común", "value": "ayudar en una tarea común"}, {"id": "b", "label": "Desordenar a propósito", "value": "desordenar a propósito"}, {"id": "c", "label": "No participar", "value": "no participar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-39', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Turnos de habla 39', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-39-01', 'act-np1-estrella-39', 'Reto ciudadano: ¿Qué debemos hacer antes de hablar en grupo?', 'Respetar turnos mejora la comunicación.', 'single-choice', 'esperar turno', '[{"id": "a", "label": "Esperar turno", "value": "esperar turno"}, {"id": "b", "label": "Gritar encima", "value": "gritar encima"}, {"id": "c", "label": "Tapar la boca", "value": "tapar la boca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-40', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a mayores 40', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-40-01', 'act-np1-estrella-40', 'Reto ciudadano: ¿Qué acción demuestra respeto a una persona mayor?', 'El respeto se practica con acciones.', 'single-choice', 'escucharla y tratarla bien', '[{"id": "a", "label": "Escucharla y tratarla bien", "value": "escucharla y tratarla bien"}, {"id": "b", "label": "Empujarla", "value": "empujarla"}, {"id": "c", "label": "Burlarse", "value": "burlarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-41', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Buen trato 41', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-41-01', 'act-np1-estrella-41', 'Elige la mejor acción: ¿Qué significa buen trato?', 'El buen trato reconoce el valor de cada persona.', 'single-choice', 'tratar con respeto y cuidado', '[{"id": "a", "label": "Tratar con respeto y cuidado", "value": "tratar con respeto y cuidado"}, {"id": "b", "label": "Insultar", "value": "insultar"}, {"id": "c", "label": "Ignorar a todos", "value": "ignorar a todos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-42', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a diferencias 42', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-42-01', 'act-np1-estrella-42', 'Elige la mejor acción: Si alguien es diferente a mí, debo...', 'Todas las personas merecen respeto.', 'single-choice', 'respetarlo', '[{"id": "a", "label": "respetarlo", "value": "respetarlo"}, {"id": "b", "label": "rechazarlo", "value": "rechazarlo"}, {"id": "c", "label": "burlarme", "value": "burlarme"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-43', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Dialogar 43', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-43-01', 'act-np1-estrella-43', 'Elige la mejor acción: ¿Qué ayuda a resolver un desacuerdo?', 'El diálogo permite entendernos.', 'single-choice', 'escuchar y dialogar', '[{"id": "a", "label": "Escuchar y dialogar", "value": "escuchar y dialogar"}, {"id": "b", "label": "Gritar más fuerte", "value": "gritar más fuerte"}, {"id": "c", "label": "Romper objetos", "value": "romper objetos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-44', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Inclusión 44', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-44-01', 'act-np1-estrella-44', 'Elige la mejor acción: ¿Qué acción muestra inclusión?', 'Incluir es permitir que todos formen parte.', 'single-choice', 'invitar a participar', '[{"id": "a", "label": "Invitar a participar", "value": "invitar a participar"}, {"id": "b", "label": "Dejar fuera", "value": "dejar fuera"}, {"id": "c", "label": "Esconder materiales", "value": "esconder materiales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-45', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Espacios comunes 45', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-45-01', 'act-np1-estrella-45', 'Elige la mejor acción: ¿Qué debemos hacer con los espacios comunes?', 'Los espacios comunes son de todos.', 'single-choice', 'cuidarlos', '[{"id": "a", "label": "Cuidarlos", "value": "cuidarlos"}, {"id": "b", "label": "Ensuciarlos", "value": "ensuciarlos"}, {"id": "c", "label": "Usarlos para pelear", "value": "usarlos para pelear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-46', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Pedir disculpas 46', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-46-01', 'act-np1-estrella-46', 'Elige la mejor acción: Cuando cometo un error, puedo...', 'Reconocer errores ayuda a convivir.', 'single-choice', 'pedir disculpas y mejorar', '[{"id": "a", "label": "pedir disculpas y mejorar", "value": "pedir disculpas y mejorar"}, {"id": "b", "label": "culpar siempre a otros", "value": "culpar siempre a otros"}, {"id": "c", "label": "molestarme y gritar", "value": "molestarme y gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-47', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Nombrar emociones 47', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-47-01', 'act-np1-estrella-47', 'Elige la mejor acción: ¿Qué emoción puedo expresar con palabras?', 'Las emociones se pueden nombrar y conversar.', 'single-choice', 'tristeza', '[{"id": "a", "label": "Tristeza", "value": "tristeza"}, {"id": "b", "label": "Una mesa", "value": "una mesa"}, {"id": "c", "label": "Una mochila", "value": "una mochila"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-48', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Colaborar 48', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-48-01', 'act-np1-estrella-48', 'Elige la mejor acción: ¿Qué es colaborar?', 'Colaborar une esfuerzos.', 'single-choice', 'ayudar en una tarea común', '[{"id": "a", "label": "Ayudar en una tarea común", "value": "ayudar en una tarea común"}, {"id": "b", "label": "Desordenar a propósito", "value": "desordenar a propósito"}, {"id": "c", "label": "No participar", "value": "no participar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-49', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Turnos de habla 49', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-49-01', 'act-np1-estrella-49', 'Elige la mejor acción: ¿Qué debemos hacer antes de hablar en grupo?', 'Respetar turnos mejora la comunicación.', 'single-choice', 'esperar turno', '[{"id": "a", "label": "Esperar turno", "value": "esperar turno"}, {"id": "b", "label": "Gritar encima", "value": "gritar encima"}, {"id": "c", "label": "Tapar la boca", "value": "tapar la boca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-estrella-50', 'les-nuestro-pais-1p-estrella', 'nuestro-pais-primaria', '1-primaria', 'Respeto a mayores 50', 'Actividad de Nuestro País sobre convivimos con respeto. Cada misión vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-estrella-50-01', 'act-np1-estrella-50', 'Elige la mejor acción: ¿Qué acción demuestra respeto a una persona mayor?', 'El respeto se practica con acciones.', 'single-choice', 'escucharla y tratarla bien', '[{"id": "a", "label": "Escucharla y tratarla bien", "value": "escucharla y tratarla bien"}, {"id": "b", "label": "Empujarla", "value": "empujarla"}, {"id": "c", "label": "Burlarse", "value": "burlarse"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'maestro', '🏆 Maestro Genio - Proyecto ciudadano', 'Integra aprendizajes para cuidar familia, escuela, localidad y país.', 5, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, order_number = excluded.order_number, is_active = true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-01', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Mejoro mi aula 01', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-01-01', 'act-np1-maestro-01', '¿Qué puedes proponer para mejorar tu aula?', 'Una propuesta debe ayudar al grupo.', 'single-choice', 'mantenerla limpia y ordenada', '[{"id": "a", "label": "Mantenerla limpia y ordenada", "value": "mantenerla limpia y ordenada"}, {"id": "b", "label": "Romper carteles", "value": "romper carteles"}, {"id": "c", "label": "Esconder útiles", "value": "esconder útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-02', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Álbum familiar 02', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-02-01', 'act-np1-maestro-02', '¿Qué proyecto puedes hacer sobre tu familia?', 'Un álbum ayuda a valorar tu historia.', 'single-choice', 'un álbum familiar', '[{"id": "a", "label": "Un álbum familiar", "value": "un álbum familiar"}, {"id": "b", "label": "Una pelea", "value": "una pelea"}, {"id": "c", "label": "Un desorden", "value": "un desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-03', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Cuido mi localidad 03', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-03-01', 'act-np1-maestro-03', '¿Qué puedes hacer para cuidar tu localidad?', 'Las pequeñas acciones cuidan el entorno.', 'single-choice', 'no botar basura', '[{"id": "a", "label": "No botar basura", "value": "no botar basura"}, {"id": "b", "label": "Ensuciar parques", "value": "ensuciar parques"}, {"id": "c", "label": "Romper señales", "value": "romper señales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-04', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Convivencia en paz 04', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-04-01', 'act-np1-maestro-04', '¿Qué se debe hacer para convivir en paz?', 'Los acuerdos protegen la convivencia.', 'single-choice', 'respetar acuerdos', '[{"id": "a", "label": "Respetar acuerdos", "value": "respetar acuerdos"}, {"id": "b", "label": "Ignorar normas", "value": "ignorar normas"}, {"id": "c", "label": "Golpear", "value": "golpear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-05', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Bienvenida 05', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-05-01', 'act-np1-maestro-05', '¿Qué acción ayuda a una persona nueva en la escuela?', 'La acogida muestra buen trato.', 'single-choice', 'darle la bienvenida', '[{"id": "a", "label": "Darle la bienvenida", "value": "darle la bienvenida"}, {"id": "b", "label": "Rechazarla", "value": "rechazarla"}, {"id": "c", "label": "No hablarle nunca", "value": "no hablarle nunca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-06', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ciudadano pequeño 06', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-06-01', 'act-np1-maestro-06', '¿Qué hace un buen ciudadano pequeño?', 'La ciudadanía se aprende desde la infancia.', 'single-choice', 'cuida, respeta y participa', '[{"id": "a", "label": "Cuida, respeta y participa", "value": "cuida, respeta y participa"}, {"id": "b", "label": "Solo manda", "value": "solo manda"}, {"id": "c", "label": "No colabora", "value": "no colabora"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-07', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ficha personal 07', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-07-01', 'act-np1-maestro-07', '¿Qué información puede ir en una ficha personal?', 'Los datos personales se usan con cuidado.', 'single-choice', 'nombre y edad', '[{"id": "a", "label": "Nombre y edad", "value": "nombre y edad"}, {"id": "b", "label": "Contraseña secreta", "value": "contraseña secreta"}, {"id": "c", "label": "Datos de desconocidos", "value": "datos de desconocidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-08', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Meta escolar 08', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-08-01', 'act-np1-maestro-08', '¿Cuál es una meta de mejora para la escuela?', 'Las metas deben beneficiar a todos.', 'single-choice', 'usar tachos y cuidar plantas', '[{"id": "a", "label": "Usar tachos y cuidar plantas", "value": "usar tachos y cuidar plantas"}, {"id": "b", "label": "Ensuciar paredes", "value": "ensuciar paredes"}, {"id": "c", "label": "Romper libros", "value": "romper libros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-09', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Comunidad fuerte 09', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-09-01', 'act-np1-maestro-09', '¿Cómo se fortalece una comunidad?', 'Participar mejora la comunidad.', 'single-choice', 'con participación y respeto', '[{"id": "a", "label": "Con participación y respeto", "value": "con participación y respeto"}, {"id": "b", "label": "Con burlas", "value": "con burlas"}, {"id": "c", "label": "Con peleas", "value": "con peleas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-10', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Pido ayuda 10', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-10-01', 'act-np1-maestro-10', '¿Qué debes hacer si ves una situación injusta?', 'Pedir ayuda protege a las personas.', 'single-choice', 'avisar a un adulto de confianza', '[{"id": "a", "label": "Avisar a un adulto de confianza", "value": "avisar a un adulto de confianza"}, {"id": "b", "label": "Quedarte callado siempre", "value": "quedarte callado siempre"}, {"id": "c", "label": "Reírte", "value": "reírte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-11', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Mejoro mi aula 11', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-11-01', 'act-np1-maestro-11', 'Piensa en tu vida diaria: ¿Qué puedes proponer para mejorar tu aula?', 'Una propuesta debe ayudar al grupo.', 'single-choice', 'mantenerla limpia y ordenada', '[{"id": "a", "label": "Mantenerla limpia y ordenada", "value": "mantenerla limpia y ordenada"}, {"id": "b", "label": "Romper carteles", "value": "romper carteles"}, {"id": "c", "label": "Esconder útiles", "value": "esconder útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-12', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Álbum familiar 12', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-12-01', 'act-np1-maestro-12', 'Piensa en tu vida diaria: ¿Qué proyecto puedes hacer sobre tu familia?', 'Un álbum ayuda a valorar tu historia.', 'single-choice', 'un álbum familiar', '[{"id": "a", "label": "Un álbum familiar", "value": "un álbum familiar"}, {"id": "b", "label": "Una pelea", "value": "una pelea"}, {"id": "c", "label": "Un desorden", "value": "un desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-13', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Cuido mi localidad 13', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-13-01', 'act-np1-maestro-13', 'Piensa en tu vida diaria: ¿Qué puedes hacer para cuidar tu localidad?', 'Las pequeñas acciones cuidan el entorno.', 'single-choice', 'no botar basura', '[{"id": "a", "label": "No botar basura", "value": "no botar basura"}, {"id": "b", "label": "Ensuciar parques", "value": "ensuciar parques"}, {"id": "c", "label": "Romper señales", "value": "romper señales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-14', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Convivencia en paz 14', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-14-01', 'act-np1-maestro-14', 'Piensa en tu vida diaria: ¿Qué se debe hacer para convivir en paz?', 'Los acuerdos protegen la convivencia.', 'single-choice', 'respetar acuerdos', '[{"id": "a", "label": "Respetar acuerdos", "value": "respetar acuerdos"}, {"id": "b", "label": "Ignorar normas", "value": "ignorar normas"}, {"id": "c", "label": "Golpear", "value": "golpear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-15', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Bienvenida 15', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-15-01', 'act-np1-maestro-15', 'Piensa en tu vida diaria: ¿Qué acción ayuda a una persona nueva en la escuela?', 'La acogida muestra buen trato.', 'single-choice', 'darle la bienvenida', '[{"id": "a", "label": "Darle la bienvenida", "value": "darle la bienvenida"}, {"id": "b", "label": "Rechazarla", "value": "rechazarla"}, {"id": "c", "label": "No hablarle nunca", "value": "no hablarle nunca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-16', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ciudadano pequeño 16', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-16-01', 'act-np1-maestro-16', 'Piensa en tu vida diaria: ¿Qué hace un buen ciudadano pequeño?', 'La ciudadanía se aprende desde la infancia.', 'single-choice', 'cuida, respeta y participa', '[{"id": "a", "label": "Cuida, respeta y participa", "value": "cuida, respeta y participa"}, {"id": "b", "label": "Solo manda", "value": "solo manda"}, {"id": "c", "label": "No colabora", "value": "no colabora"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-17', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ficha personal 17', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-17-01', 'act-np1-maestro-17', 'Piensa en tu vida diaria: ¿Qué información puede ir en una ficha personal?', 'Los datos personales se usan con cuidado.', 'single-choice', 'nombre y edad', '[{"id": "a", "label": "Nombre y edad", "value": "nombre y edad"}, {"id": "b", "label": "Contraseña secreta", "value": "contraseña secreta"}, {"id": "c", "label": "Datos de desconocidos", "value": "datos de desconocidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-18', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Meta escolar 18', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-18-01', 'act-np1-maestro-18', 'Piensa en tu vida diaria: ¿Cuál es una meta de mejora para la escuela?', 'Las metas deben beneficiar a todos.', 'single-choice', 'usar tachos y cuidar plantas', '[{"id": "a", "label": "Usar tachos y cuidar plantas", "value": "usar tachos y cuidar plantas"}, {"id": "b", "label": "Ensuciar paredes", "value": "ensuciar paredes"}, {"id": "c", "label": "Romper libros", "value": "romper libros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-19', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Comunidad fuerte 19', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-19-01', 'act-np1-maestro-19', 'Piensa en tu vida diaria: ¿Cómo se fortalece una comunidad?', 'Participar mejora la comunidad.', 'single-choice', 'con participación y respeto', '[{"id": "a", "label": "Con participación y respeto", "value": "con participación y respeto"}, {"id": "b", "label": "Con burlas", "value": "con burlas"}, {"id": "c", "label": "Con peleas", "value": "con peleas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-20', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Pido ayuda 20', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-20-01', 'act-np1-maestro-20', 'Piensa en tu vida diaria: ¿Qué debes hacer si ves una situación injusta?', 'Pedir ayuda protege a las personas.', 'single-choice', 'avisar a un adulto de confianza', '[{"id": "a", "label": "Avisar a un adulto de confianza", "value": "avisar a un adulto de confianza"}, {"id": "b", "label": "Quedarte callado siempre", "value": "quedarte callado siempre"}, {"id": "c", "label": "Reírte", "value": "reírte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-21', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Mejoro mi aula 21', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-21-01', 'act-np1-maestro-21', 'En GenioKids: ¿Qué puedes proponer para mejorar tu aula?', 'Una propuesta debe ayudar al grupo.', 'single-choice', 'mantenerla limpia y ordenada', '[{"id": "a", "label": "Mantenerla limpia y ordenada", "value": "mantenerla limpia y ordenada"}, {"id": "b", "label": "Romper carteles", "value": "romper carteles"}, {"id": "c", "label": "Esconder útiles", "value": "esconder útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-22', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Álbum familiar 22', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-22-01', 'act-np1-maestro-22', 'En GenioKids: ¿Qué proyecto puedes hacer sobre tu familia?', 'Un álbum ayuda a valorar tu historia.', 'single-choice', 'un álbum familiar', '[{"id": "a", "label": "Un álbum familiar", "value": "un álbum familiar"}, {"id": "b", "label": "Una pelea", "value": "una pelea"}, {"id": "c", "label": "Un desorden", "value": "un desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-23', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Cuido mi localidad 23', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-23-01', 'act-np1-maestro-23', 'En GenioKids: ¿Qué puedes hacer para cuidar tu localidad?', 'Las pequeñas acciones cuidan el entorno.', 'single-choice', 'no botar basura', '[{"id": "a", "label": "No botar basura", "value": "no botar basura"}, {"id": "b", "label": "Ensuciar parques", "value": "ensuciar parques"}, {"id": "c", "label": "Romper señales", "value": "romper señales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-24', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Convivencia en paz 24', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-24-01', 'act-np1-maestro-24', 'En GenioKids: ¿Qué se debe hacer para convivir en paz?', 'Los acuerdos protegen la convivencia.', 'single-choice', 'respetar acuerdos', '[{"id": "a", "label": "Respetar acuerdos", "value": "respetar acuerdos"}, {"id": "b", "label": "Ignorar normas", "value": "ignorar normas"}, {"id": "c", "label": "Golpear", "value": "golpear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-25', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Bienvenida 25', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-25-01', 'act-np1-maestro-25', 'En GenioKids: ¿Qué acción ayuda a una persona nueva en la escuela?', 'La acogida muestra buen trato.', 'single-choice', 'darle la bienvenida', '[{"id": "a", "label": "Darle la bienvenida", "value": "darle la bienvenida"}, {"id": "b", "label": "Rechazarla", "value": "rechazarla"}, {"id": "c", "label": "No hablarle nunca", "value": "no hablarle nunca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-26', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ciudadano pequeño 26', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-26-01', 'act-np1-maestro-26', 'En GenioKids: ¿Qué hace un buen ciudadano pequeño?', 'La ciudadanía se aprende desde la infancia.', 'single-choice', 'cuida, respeta y participa', '[{"id": "a", "label": "Cuida, respeta y participa", "value": "cuida, respeta y participa"}, {"id": "b", "label": "Solo manda", "value": "solo manda"}, {"id": "c", "label": "No colabora", "value": "no colabora"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-27', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ficha personal 27', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-27-01', 'act-np1-maestro-27', 'En GenioKids: ¿Qué información puede ir en una ficha personal?', 'Los datos personales se usan con cuidado.', 'single-choice', 'nombre y edad', '[{"id": "a", "label": "Nombre y edad", "value": "nombre y edad"}, {"id": "b", "label": "Contraseña secreta", "value": "contraseña secreta"}, {"id": "c", "label": "Datos de desconocidos", "value": "datos de desconocidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-28', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Meta escolar 28', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-28-01', 'act-np1-maestro-28', 'En GenioKids: ¿Cuál es una meta de mejora para la escuela?', 'Las metas deben beneficiar a todos.', 'single-choice', 'usar tachos y cuidar plantas', '[{"id": "a", "label": "Usar tachos y cuidar plantas", "value": "usar tachos y cuidar plantas"}, {"id": "b", "label": "Ensuciar paredes", "value": "ensuciar paredes"}, {"id": "c", "label": "Romper libros", "value": "romper libros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-29', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Comunidad fuerte 29', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-29-01', 'act-np1-maestro-29', 'En GenioKids: ¿Cómo se fortalece una comunidad?', 'Participar mejora la comunidad.', 'single-choice', 'con participación y respeto', '[{"id": "a", "label": "Con participación y respeto", "value": "con participación y respeto"}, {"id": "b", "label": "Con burlas", "value": "con burlas"}, {"id": "c", "label": "Con peleas", "value": "con peleas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-30', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Pido ayuda 30', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-30-01', 'act-np1-maestro-30', 'En GenioKids: ¿Qué debes hacer si ves una situación injusta?', 'Pedir ayuda protege a las personas.', 'single-choice', 'avisar a un adulto de confianza', '[{"id": "a", "label": "Avisar a un adulto de confianza", "value": "avisar a un adulto de confianza"}, {"id": "b", "label": "Quedarte callado siempre", "value": "quedarte callado siempre"}, {"id": "c", "label": "Reírte", "value": "reírte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-31', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Mejoro mi aula 31', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-31-01', 'act-np1-maestro-31', 'Reto ciudadano: ¿Qué puedes proponer para mejorar tu aula?', 'Una propuesta debe ayudar al grupo.', 'single-choice', 'mantenerla limpia y ordenada', '[{"id": "a", "label": "Mantenerla limpia y ordenada", "value": "mantenerla limpia y ordenada"}, {"id": "b", "label": "Romper carteles", "value": "romper carteles"}, {"id": "c", "label": "Esconder útiles", "value": "esconder útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-32', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Álbum familiar 32', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-32-01', 'act-np1-maestro-32', 'Reto ciudadano: ¿Qué proyecto puedes hacer sobre tu familia?', 'Un álbum ayuda a valorar tu historia.', 'single-choice', 'un álbum familiar', '[{"id": "a", "label": "Un álbum familiar", "value": "un álbum familiar"}, {"id": "b", "label": "Una pelea", "value": "una pelea"}, {"id": "c", "label": "Un desorden", "value": "un desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-33', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Cuido mi localidad 33', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-33-01', 'act-np1-maestro-33', 'Reto ciudadano: ¿Qué puedes hacer para cuidar tu localidad?', 'Las pequeñas acciones cuidan el entorno.', 'single-choice', 'no botar basura', '[{"id": "a", "label": "No botar basura", "value": "no botar basura"}, {"id": "b", "label": "Ensuciar parques", "value": "ensuciar parques"}, {"id": "c", "label": "Romper señales", "value": "romper señales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-34', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Convivencia en paz 34', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-34-01', 'act-np1-maestro-34', 'Reto ciudadano: ¿Qué se debe hacer para convivir en paz?', 'Los acuerdos protegen la convivencia.', 'single-choice', 'respetar acuerdos', '[{"id": "a", "label": "Respetar acuerdos", "value": "respetar acuerdos"}, {"id": "b", "label": "Ignorar normas", "value": "ignorar normas"}, {"id": "c", "label": "Golpear", "value": "golpear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-35', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Bienvenida 35', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-35-01', 'act-np1-maestro-35', 'Reto ciudadano: ¿Qué acción ayuda a una persona nueva en la escuela?', 'La acogida muestra buen trato.', 'single-choice', 'darle la bienvenida', '[{"id": "a", "label": "Darle la bienvenida", "value": "darle la bienvenida"}, {"id": "b", "label": "Rechazarla", "value": "rechazarla"}, {"id": "c", "label": "No hablarle nunca", "value": "no hablarle nunca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-36', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ciudadano pequeño 36', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-36-01', 'act-np1-maestro-36', 'Reto ciudadano: ¿Qué hace un buen ciudadano pequeño?', 'La ciudadanía se aprende desde la infancia.', 'single-choice', 'cuida, respeta y participa', '[{"id": "a", "label": "Cuida, respeta y participa", "value": "cuida, respeta y participa"}, {"id": "b", "label": "Solo manda", "value": "solo manda"}, {"id": "c", "label": "No colabora", "value": "no colabora"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-37', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ficha personal 37', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-37-01', 'act-np1-maestro-37', 'Reto ciudadano: ¿Qué información puede ir en una ficha personal?', 'Los datos personales se usan con cuidado.', 'single-choice', 'nombre y edad', '[{"id": "a", "label": "Nombre y edad", "value": "nombre y edad"}, {"id": "b", "label": "Contraseña secreta", "value": "contraseña secreta"}, {"id": "c", "label": "Datos de desconocidos", "value": "datos de desconocidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-38', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Meta escolar 38', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-38-01', 'act-np1-maestro-38', 'Reto ciudadano: ¿Cuál es una meta de mejora para la escuela?', 'Las metas deben beneficiar a todos.', 'single-choice', 'usar tachos y cuidar plantas', '[{"id": "a", "label": "Usar tachos y cuidar plantas", "value": "usar tachos y cuidar plantas"}, {"id": "b", "label": "Ensuciar paredes", "value": "ensuciar paredes"}, {"id": "c", "label": "Romper libros", "value": "romper libros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-39', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Comunidad fuerte 39', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-39-01', 'act-np1-maestro-39', 'Reto ciudadano: ¿Cómo se fortalece una comunidad?', 'Participar mejora la comunidad.', 'single-choice', 'con participación y respeto', '[{"id": "a", "label": "Con participación y respeto", "value": "con participación y respeto"}, {"id": "b", "label": "Con burlas", "value": "con burlas"}, {"id": "c", "label": "Con peleas", "value": "con peleas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-40', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Pido ayuda 40', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-40-01', 'act-np1-maestro-40', 'Reto ciudadano: ¿Qué debes hacer si ves una situación injusta?', 'Pedir ayuda protege a las personas.', 'single-choice', 'avisar a un adulto de confianza', '[{"id": "a", "label": "Avisar a un adulto de confianza", "value": "avisar a un adulto de confianza"}, {"id": "b", "label": "Quedarte callado siempre", "value": "quedarte callado siempre"}, {"id": "c", "label": "Reírte", "value": "reírte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-41', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Mejoro mi aula 41', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-41-01', 'act-np1-maestro-41', 'Elige la mejor acción: ¿Qué puedes proponer para mejorar tu aula?', 'Una propuesta debe ayudar al grupo.', 'single-choice', 'mantenerla limpia y ordenada', '[{"id": "a", "label": "Mantenerla limpia y ordenada", "value": "mantenerla limpia y ordenada"}, {"id": "b", "label": "Romper carteles", "value": "romper carteles"}, {"id": "c", "label": "Esconder útiles", "value": "esconder útiles"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-42', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Álbum familiar 42', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-42-01', 'act-np1-maestro-42', 'Elige la mejor acción: ¿Qué proyecto puedes hacer sobre tu familia?', 'Un álbum ayuda a valorar tu historia.', 'single-choice', 'un álbum familiar', '[{"id": "a", "label": "Un álbum familiar", "value": "un álbum familiar"}, {"id": "b", "label": "Una pelea", "value": "una pelea"}, {"id": "c", "label": "Un desorden", "value": "un desorden"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-43', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Cuido mi localidad 43', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-43-01', 'act-np1-maestro-43', 'Elige la mejor acción: ¿Qué puedes hacer para cuidar tu localidad?', 'Las pequeñas acciones cuidan el entorno.', 'single-choice', 'no botar basura', '[{"id": "a", "label": "No botar basura", "value": "no botar basura"}, {"id": "b", "label": "Ensuciar parques", "value": "ensuciar parques"}, {"id": "c", "label": "Romper señales", "value": "romper señales"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-44', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Convivencia en paz 44', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-44-01', 'act-np1-maestro-44', 'Elige la mejor acción: ¿Qué se debe hacer para convivir en paz?', 'Los acuerdos protegen la convivencia.', 'single-choice', 'respetar acuerdos', '[{"id": "a", "label": "Respetar acuerdos", "value": "respetar acuerdos"}, {"id": "b", "label": "Ignorar normas", "value": "ignorar normas"}, {"id": "c", "label": "Golpear", "value": "golpear"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-45', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Bienvenida 45', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-45-01', 'act-np1-maestro-45', 'Elige la mejor acción: ¿Qué acción ayuda a una persona nueva en la escuela?', 'La acogida muestra buen trato.', 'single-choice', 'darle la bienvenida', '[{"id": "a", "label": "Darle la bienvenida", "value": "darle la bienvenida"}, {"id": "b", "label": "Rechazarla", "value": "rechazarla"}, {"id": "c", "label": "No hablarle nunca", "value": "no hablarle nunca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-46', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ciudadano pequeño 46', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-46-01', 'act-np1-maestro-46', 'Elige la mejor acción: ¿Qué hace un buen ciudadano pequeño?', 'La ciudadanía se aprende desde la infancia.', 'single-choice', 'cuida, respeta y participa', '[{"id": "a", "label": "Cuida, respeta y participa", "value": "cuida, respeta y participa"}, {"id": "b", "label": "Solo manda", "value": "solo manda"}, {"id": "c", "label": "No colabora", "value": "no colabora"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-47', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Ficha personal 47', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-47-01', 'act-np1-maestro-47', 'Elige la mejor acción: ¿Qué información puede ir en una ficha personal?', 'Los datos personales se usan con cuidado.', 'single-choice', 'nombre y edad', '[{"id": "a", "label": "Nombre y edad", "value": "nombre y edad"}, {"id": "b", "label": "Contraseña secreta", "value": "contraseña secreta"}, {"id": "c", "label": "Datos de desconocidos", "value": "datos de desconocidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-48', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Meta escolar 48', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-48-01', 'act-np1-maestro-48', 'Elige la mejor acción: ¿Cuál es una meta de mejora para la escuela?', 'Las metas deben beneficiar a todos.', 'single-choice', 'usar tachos y cuidar plantas', '[{"id": "a", "label": "Usar tachos y cuidar plantas", "value": "usar tachos y cuidar plantas"}, {"id": "b", "label": "Ensuciar paredes", "value": "ensuciar paredes"}, {"id": "c", "label": "Romper libros", "value": "romper libros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-49', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Comunidad fuerte 49', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-49-01', 'act-np1-maestro-49', 'Elige la mejor acción: ¿Cómo se fortalece una comunidad?', 'Participar mejora la comunidad.', 'single-choice', 'con participación y respeto', '[{"id": "a", "label": "Con participación y respeto", "value": "con participación y respeto"}, {"id": "b", "label": "Con burlas", "value": "con burlas"}, {"id": "c", "label": "Con peleas", "value": "con peleas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-np1-maestro-50', 'les-nuestro-pais-1p-maestro', 'nuestro-pais-primaria', '1-primaria', 'Pido ayuda 50', 'Actividad de Nuestro País sobre ciudadano pequeño, gran país. Cada misión vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set title = excluded.title, description = excluded.description, activity_type = excluded.activity_type, order_number = excluded.order_number, points = excluded.points, is_active = true;
insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-np1-maestro-50-01', 'act-np1-maestro-50', 'Elige la mejor acción: ¿Qué debes hacer si ves una situación injusta?', 'Pedir ayuda protege a las personas.', 'single-choice', 'avisar a un adulto de confianza', '[{"id": "a", "label": "Avisar a un adulto de confianza", "value": "avisar a un adulto de confianza"}, {"id": "b", "label": "Quedarte callado siempre", "value": "quedarte callado siempre"}, {"id": "c", "label": "Reírte", "value": "reírte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set prompt = excluded.prompt, helper = excluded.helper, question_type = excluded.question_type, correct_answer = excluded.correct_answer, options = excluded.options, pairs = excluded.pairs, order_number = excluded.order_number;


insert into public.badges (id, name, description, icon, requirement, color, category, order_number) values
('badge-np1-familia','Guardián de mi familia','Completó actividades de familia, identidad y responsabilidades.','🏡','Completar o aprobar el nivel Semilla de Nuestro País 1.º','#2ecc71','curso',41),
('badge-np1-localidad','Explorador de mi localidad','Avanzó en espacios públicos, instituciones y normas de convivencia.','🏘️','Completar o aprobar el nivel Explorador de Nuestro País 1.º','#27ae60','curso',42),
('badge-np1-escuela','Constructor de convivencia escolar','Reconoció acuerdos y responsabilidades en la escuela.','🏫','Completar o aprobar el nivel Aventurero de Nuestro País 1.º','#16a085','curso',43),
('badge-np1-ciudadano','Ciudadano pequeño, gran país','Demostró respeto, cuidado y participación ciudadana.','🇵🇪','Completar Nuestro País 1.º primaria.','#e74c3c','excelencia',44)
on conflict (id) do update set
  name = excluded.name,
  description = excluded.description,
  icon = excluded.icon,
  requirement = excluded.requirement,
  color = excluded.color,
  category = excluded.category,
  order_number = excluded.order_number;

notify pgrst, 'reload schema';
