-- Setup común GenioKids Inicial 3, 4 y 5 años
alter table public.subjects drop constraint if exists subjects_area_check;
alter table public.subjects add constraint subjects_area_check
check (area in ('matematica','comunicacion','ingles','ciencia','ciencia_tecnologia','razonamiento','juegos','nuestro_pais','educacion_financiera','tutoria','personal_social','psicomotriz','arte_creatividad'));

alter table public.activities drop constraint if exists activities_order_number_check;
alter table public.activities add constraint activities_order_number_check check (order_number between 1 and 50);

insert into public.difficulty_levels (id, name, short_name, stage_label, description, icon, color, order_number, is_active) values
('semilla', '🌱 Semilla Genial', 'Semilla Genial', 'Básico', 'Nivel básico de aprendizaje progresivo.', '🌱', '#2ecc71', 1, true),
('explorador', '🔎 Explorador Curioso', 'Explorador Curioso', 'Fácil', 'Nivel fácil de aprendizaje progresivo.', '🔎', '#3498db', 2, true),
('aventurero', '🧭 Aventurero Ágil', 'Aventurero Ágil', 'Medio', 'Nivel medio de aprendizaje progresivo.', '🧭', '#f39c12', 3, true),
('estrella', '⭐ Estrella Brillante', 'Estrella Brillante', 'Avanzado', 'Nivel avanzado de aprendizaje progresivo.', '⭐', '#9b59b6', 4, true),
('maestro', '🏆 Maestro Genio', 'Maestro Genio', 'Experto', 'Nivel experto de aprendizaje progresivo.', '🏆', '#e74c3c', 5, true)
on conflict (id) do update set name=excluded.name, short_name=excluded.short_name, stage_label=excluded.stage_label, description=excluded.description, icon=excluded.icon, color=excluded.color, order_number=excluded.order_number, is_active=true;

insert into public.subjects (id, name, area, level, grades, icon, color, description, is_active) values
('mat-inicial', 'Matemática', 'matematica', 'inicial', array['3-anios','4-anios','5-anios'], '🧮', '#6c5ce7', 'Conteo, clasificación, seriación, comparación, ubicación, formas, patrones y resolución de problemas desde el juego.', true),
('com-inicial', 'Comunicación', 'comunicacion', 'inicial', array['3-anios','4-anios','5-anios'], '🗣️', '#00b894', 'Oralidad, escucha, narración, lectura de imágenes, vocabulario, rimas y aproximación al mundo escrito.', true),
('personal-social-inicial', 'Personal Social', 'personal_social', 'inicial', array['3-anios','4-anios','5-anios'], '💛', '#fd79a8', 'Identidad, autonomía, emociones, convivencia, acuerdos, cuidado personal y participación en el aula.', true),
('psicomotriz-inicial', 'Psicomotriz', 'psicomotriz', 'inicial', array['3-anios','4-anios','5-anios'], '🏃', '#e17055', 'Movimiento, equilibrio, coordinación, lateralidad, juego corporal, expresión con el cuerpo y cuidado postural.', true),
('ciencia-tecnologia-inicial', 'Ciencia y Tecnología', 'ciencia_tecnologia', 'inicial', array['3-anios','4-anios','5-anios'], '🌱', '#00cec9', 'Observación, exploración, seres vivos, cuerpo, materiales, ambiente, preguntas e indagación sencilla.', true),
('arte-creatividad-inicial', 'Arte y creatividad', 'arte_creatividad', 'inicial', array['3-anios','4-anios','5-anios'], '🎨', '#a29bfe', 'Expresión con colores, música, dramatización, modelado, collage y creación mediante lenguajes artísticos.', true)
on conflict (id) do update set name=excluded.name, area=excluded.area, level=excluded.level, grades=excluded.grades, icon=excluded.icon, color=excluded.color, description=excluded.description, is_active=true;

-- GenioKids - Ciencia y Tecnología Inicial 4 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'semilla', '🌱 Semilla Genial - Ciencia y Tecnología Inicial 4 años', 'seres vivos y cuidados', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-01', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-01-01', 'act-cyt-4i-semilla-01', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-02', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-02-01', 'act-cyt-4i-semilla-02', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-03', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-03-01', 'act-cyt-4i-semilla-03', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-04', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-04-01', 'act-cyt-4i-semilla-04', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-05', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-05-01', 'act-cyt-4i-semilla-05', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-06', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-06-01', 'act-cyt-4i-semilla-06', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-07', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-07-01', 'act-cyt-4i-semilla-07', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-08', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-08-01', 'act-cyt-4i-semilla-08', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-09', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-09-01', 'act-cyt-4i-semilla-09', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-10', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-10-01', 'act-cyt-4i-semilla-10', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-11', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-11-01', 'act-cyt-4i-semilla-11', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-12', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-12-01', 'act-cyt-4i-semilla-12', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-13', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-13-01', 'act-cyt-4i-semilla-13', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-14', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-14-01', 'act-cyt-4i-semilla-14', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-15', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-15-01', 'act-cyt-4i-semilla-15', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-16', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-16-01', 'act-cyt-4i-semilla-16', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-17', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-17-01', 'act-cyt-4i-semilla-17', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-18', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-18-01', 'act-cyt-4i-semilla-18', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-19', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-19-01', 'act-cyt-4i-semilla-19', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-20', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-20-01', 'act-cyt-4i-semilla-20', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-21', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-21-01', 'act-cyt-4i-semilla-21', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-22', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-22-01', 'act-cyt-4i-semilla-22', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-23', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-23-01', 'act-cyt-4i-semilla-23', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-24', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-24-01', 'act-cyt-4i-semilla-24', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-25', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-25-01', 'act-cyt-4i-semilla-25', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-26', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-26-01', 'act-cyt-4i-semilla-26', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-27', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-27-01', 'act-cyt-4i-semilla-27', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-28', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-28-01', 'act-cyt-4i-semilla-28', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-29', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-29-01', 'act-cyt-4i-semilla-29', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-30', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-30-01', 'act-cyt-4i-semilla-30', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-31', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-31-01', 'act-cyt-4i-semilla-31', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-32', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-32-01', 'act-cyt-4i-semilla-32', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-33', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-33-01', 'act-cyt-4i-semilla-33', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-34', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-34-01', 'act-cyt-4i-semilla-34', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-35', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-35-01', 'act-cyt-4i-semilla-35', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-36', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-36-01', 'act-cyt-4i-semilla-36', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-37', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-37-01', 'act-cyt-4i-semilla-37', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-38', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-38-01', 'act-cyt-4i-semilla-38', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-39', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-39-01', 'act-cyt-4i-semilla-39', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-40', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-40-01', 'act-cyt-4i-semilla-40', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-41', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-41-01', 'act-cyt-4i-semilla-41', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-42', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-42-01', 'act-cyt-4i-semilla-42', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-43', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-43-01', 'act-cyt-4i-semilla-43', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-44', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-44-01', 'act-cyt-4i-semilla-44', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-45', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-45-01', 'act-cyt-4i-semilla-45', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-46', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-46-01', 'act-cyt-4i-semilla-46', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-47', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-47-01', 'act-cyt-4i-semilla-47', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-48', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-48-01', 'act-cyt-4i-semilla-48', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-49', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-49-01', 'act-cyt-4i-semilla-49', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-semilla-50', 'les-cyt-4i-semilla', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-semilla-50-01', 'act-cyt-4i-semilla-50', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'explorador', '🔎 Explorador Curioso - Ciencia y Tecnología Inicial 4 años', 'materiales cotidianos', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-01', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-01-01', 'act-cyt-4i-explorador-01', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-02', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-02-01', 'act-cyt-4i-explorador-02', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-03', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-03-01', 'act-cyt-4i-explorador-03', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-04', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-04-01', 'act-cyt-4i-explorador-04', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-05', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-05-01', 'act-cyt-4i-explorador-05', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-06', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-06-01', 'act-cyt-4i-explorador-06', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-07', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-07-01', 'act-cyt-4i-explorador-07', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-08', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-08-01', 'act-cyt-4i-explorador-08', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-09', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-09-01', 'act-cyt-4i-explorador-09', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-10', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-10-01', 'act-cyt-4i-explorador-10', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-11', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-11-01', 'act-cyt-4i-explorador-11', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-12', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-12-01', 'act-cyt-4i-explorador-12', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-13', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-13-01', 'act-cyt-4i-explorador-13', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-14', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-14-01', 'act-cyt-4i-explorador-14', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-15', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-15-01', 'act-cyt-4i-explorador-15', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-16', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-16-01', 'act-cyt-4i-explorador-16', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-17', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-17-01', 'act-cyt-4i-explorador-17', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-18', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-18-01', 'act-cyt-4i-explorador-18', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-19', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-19-01', 'act-cyt-4i-explorador-19', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-20', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-20-01', 'act-cyt-4i-explorador-20', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-21', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-21-01', 'act-cyt-4i-explorador-21', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-22', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-22-01', 'act-cyt-4i-explorador-22', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-23', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-23-01', 'act-cyt-4i-explorador-23', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-24', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-24-01', 'act-cyt-4i-explorador-24', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-25', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-25-01', 'act-cyt-4i-explorador-25', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-26', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-26-01', 'act-cyt-4i-explorador-26', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-27', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-27-01', 'act-cyt-4i-explorador-27', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-28', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-28-01', 'act-cyt-4i-explorador-28', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-29', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-29-01', 'act-cyt-4i-explorador-29', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-30', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-30-01', 'act-cyt-4i-explorador-30', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-31', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-31-01', 'act-cyt-4i-explorador-31', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-32', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-32-01', 'act-cyt-4i-explorador-32', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-33', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-33-01', 'act-cyt-4i-explorador-33', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-34', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-34-01', 'act-cyt-4i-explorador-34', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-35', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-35-01', 'act-cyt-4i-explorador-35', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-36', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-36-01', 'act-cyt-4i-explorador-36', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-37', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-37-01', 'act-cyt-4i-explorador-37', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-38', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-38-01', 'act-cyt-4i-explorador-38', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-39', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-39-01', 'act-cyt-4i-explorador-39', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-40', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-40-01', 'act-cyt-4i-explorador-40', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-41', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-41-01', 'act-cyt-4i-explorador-41', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-42', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-42-01', 'act-cyt-4i-explorador-42', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-43', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-43-01', 'act-cyt-4i-explorador-43', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-44', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-44-01', 'act-cyt-4i-explorador-44', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-45', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-45-01', 'act-cyt-4i-explorador-45', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-46', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-46-01', 'act-cyt-4i-explorador-46', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-47', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-47-01', 'act-cyt-4i-explorador-47', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-48', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-48-01', 'act-cyt-4i-explorador-48', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-49', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-49-01', 'act-cyt-4i-explorador-49', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-explorador-50', 'les-cyt-4i-explorador', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-explorador-50-01', 'act-cyt-4i-explorador-50', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'aventurero', '🧭 Aventurero Ágil - Ciencia y Tecnología Inicial 4 años', 'clima', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-01', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-01-01', 'act-cyt-4i-aventurero-01', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-02', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-02-01', 'act-cyt-4i-aventurero-02', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-03', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-03-01', 'act-cyt-4i-aventurero-03', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-04', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-04-01', 'act-cyt-4i-aventurero-04', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-05', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-05-01', 'act-cyt-4i-aventurero-05', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-06', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-06-01', 'act-cyt-4i-aventurero-06', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-07', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-07-01', 'act-cyt-4i-aventurero-07', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-08', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-08-01', 'act-cyt-4i-aventurero-08', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-09', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-09-01', 'act-cyt-4i-aventurero-09', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-10', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-10-01', 'act-cyt-4i-aventurero-10', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-11', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-11-01', 'act-cyt-4i-aventurero-11', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-12', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-12-01', 'act-cyt-4i-aventurero-12', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-13', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-13-01', 'act-cyt-4i-aventurero-13', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-14', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-14-01', 'act-cyt-4i-aventurero-14', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-15', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-15-01', 'act-cyt-4i-aventurero-15', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-16', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-16-01', 'act-cyt-4i-aventurero-16', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-17', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-17-01', 'act-cyt-4i-aventurero-17', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-18', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-18-01', 'act-cyt-4i-aventurero-18', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-19', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-19-01', 'act-cyt-4i-aventurero-19', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-20', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-20-01', 'act-cyt-4i-aventurero-20', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-21', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-21-01', 'act-cyt-4i-aventurero-21', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-22', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-22-01', 'act-cyt-4i-aventurero-22', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-23', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-23-01', 'act-cyt-4i-aventurero-23', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-24', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-24-01', 'act-cyt-4i-aventurero-24', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-25', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-25-01', 'act-cyt-4i-aventurero-25', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-26', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-26-01', 'act-cyt-4i-aventurero-26', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-27', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-27-01', 'act-cyt-4i-aventurero-27', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-28', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-28-01', 'act-cyt-4i-aventurero-28', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-29', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-29-01', 'act-cyt-4i-aventurero-29', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-30', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-30-01', 'act-cyt-4i-aventurero-30', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-31', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-31-01', 'act-cyt-4i-aventurero-31', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-32', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-32-01', 'act-cyt-4i-aventurero-32', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-33', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-33-01', 'act-cyt-4i-aventurero-33', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-34', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-34-01', 'act-cyt-4i-aventurero-34', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-35', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-35-01', 'act-cyt-4i-aventurero-35', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-36', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-36-01', 'act-cyt-4i-aventurero-36', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-37', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-37-01', 'act-cyt-4i-aventurero-37', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-38', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-38-01', 'act-cyt-4i-aventurero-38', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-39', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-39-01', 'act-cyt-4i-aventurero-39', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-40', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-40-01', 'act-cyt-4i-aventurero-40', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-41', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-41-01', 'act-cyt-4i-aventurero-41', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-42', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-42-01', 'act-cyt-4i-aventurero-42', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-43', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-43-01', 'act-cyt-4i-aventurero-43', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-44', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-44-01', 'act-cyt-4i-aventurero-44', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-45', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-45-01', 'act-cyt-4i-aventurero-45', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-46', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-46-01', 'act-cyt-4i-aventurero-46', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-47', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-47-01', 'act-cyt-4i-aventurero-47', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-48', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-48-01', 'act-cyt-4i-aventurero-48', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-49', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-49-01', 'act-cyt-4i-aventurero-49', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-aventurero-50', 'les-cyt-4i-aventurero', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-aventurero-50-01', 'act-cyt-4i-aventurero-50', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'estrella', '⭐ Estrella Brillante - Ciencia y Tecnología Inicial 4 años', 'partes del cuerpo', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-01', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-01-01', 'act-cyt-4i-estrella-01', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-02', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-02-01', 'act-cyt-4i-estrella-02', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-03', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-03-01', 'act-cyt-4i-estrella-03', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-04', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-04-01', 'act-cyt-4i-estrella-04', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-05', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-05-01', 'act-cyt-4i-estrella-05', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-06', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-06-01', 'act-cyt-4i-estrella-06', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-07', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-07-01', 'act-cyt-4i-estrella-07', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-08', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-08-01', 'act-cyt-4i-estrella-08', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-09', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-09-01', 'act-cyt-4i-estrella-09', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-10', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-10-01', 'act-cyt-4i-estrella-10', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-11', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-11-01', 'act-cyt-4i-estrella-11', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-12', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-12-01', 'act-cyt-4i-estrella-12', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-13', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-13-01', 'act-cyt-4i-estrella-13', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-14', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-14-01', 'act-cyt-4i-estrella-14', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-15', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-15-01', 'act-cyt-4i-estrella-15', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-16', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-16-01', 'act-cyt-4i-estrella-16', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-17', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-17-01', 'act-cyt-4i-estrella-17', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-18', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-18-01', 'act-cyt-4i-estrella-18', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-19', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-19-01', 'act-cyt-4i-estrella-19', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-20', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-20-01', 'act-cyt-4i-estrella-20', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-21', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-21-01', 'act-cyt-4i-estrella-21', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-22', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-22-01', 'act-cyt-4i-estrella-22', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-23', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-23-01', 'act-cyt-4i-estrella-23', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-24', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-24-01', 'act-cyt-4i-estrella-24', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-25', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-25-01', 'act-cyt-4i-estrella-25', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-26', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-26-01', 'act-cyt-4i-estrella-26', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-27', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-27-01', 'act-cyt-4i-estrella-27', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-28', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-28-01', 'act-cyt-4i-estrella-28', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-29', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-29-01', 'act-cyt-4i-estrella-29', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-30', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-30-01', 'act-cyt-4i-estrella-30', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-31', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-31-01', 'act-cyt-4i-estrella-31', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-32', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-32-01', 'act-cyt-4i-estrella-32', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-33', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-33-01', 'act-cyt-4i-estrella-33', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-34', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-34-01', 'act-cyt-4i-estrella-34', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-35', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-35-01', 'act-cyt-4i-estrella-35', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-36', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-36-01', 'act-cyt-4i-estrella-36', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-37', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-37-01', 'act-cyt-4i-estrella-37', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-38', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-38-01', 'act-cyt-4i-estrella-38', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-39', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-39-01', 'act-cyt-4i-estrella-39', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-40', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-40-01', 'act-cyt-4i-estrella-40', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-41', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-41-01', 'act-cyt-4i-estrella-41', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-42', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-42-01', 'act-cyt-4i-estrella-42', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-43', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-43-01', 'act-cyt-4i-estrella-43', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-44', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-44-01', 'act-cyt-4i-estrella-44', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-45', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-45-01', 'act-cyt-4i-estrella-45', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-46', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-46-01', 'act-cyt-4i-estrella-46', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-47', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-47-01', 'act-cyt-4i-estrella-47', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-48', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-48-01', 'act-cyt-4i-estrella-48', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-49', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-49-01', 'act-cyt-4i-estrella-49', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-estrella-50', 'les-cyt-4i-estrella', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-estrella-50-01', 'act-cyt-4i-estrella-50', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'maestro', '🏆 Maestro Genio - Ciencia y Tecnología Inicial 4 años', 'cuidado del ambiente', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-01', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-01-01', 'act-cyt-4i-maestro-01', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-02', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-02-01', 'act-cyt-4i-maestro-02', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-03', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-03-01', 'act-cyt-4i-maestro-03', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-04', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-04-01', 'act-cyt-4i-maestro-04', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-05', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-05-01', 'act-cyt-4i-maestro-05', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-06', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-06-01', 'act-cyt-4i-maestro-06', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-07', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-07-01', 'act-cyt-4i-maestro-07', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-08', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-08-01', 'act-cyt-4i-maestro-08', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-09', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-09-01', 'act-cyt-4i-maestro-09', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-10', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-10-01', 'act-cyt-4i-maestro-10', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-11', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-11-01', 'act-cyt-4i-maestro-11', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-12', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-12-01', 'act-cyt-4i-maestro-12', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-13', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-13-01', 'act-cyt-4i-maestro-13', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-14', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-14-01', 'act-cyt-4i-maestro-14', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-15', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-15-01', 'act-cyt-4i-maestro-15', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-16', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-16-01', 'act-cyt-4i-maestro-16', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-17', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-17-01', 'act-cyt-4i-maestro-17', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-18', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-18-01', 'act-cyt-4i-maestro-18', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-19', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-19-01', 'act-cyt-4i-maestro-19', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-20', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-20-01', 'act-cyt-4i-maestro-20', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-21', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-21-01', 'act-cyt-4i-maestro-21', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-22', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-22-01', 'act-cyt-4i-maestro-22', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-23', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-23-01', 'act-cyt-4i-maestro-23', 'Usamos los boca para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-24', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-24-01', 'act-cyt-4i-maestro-24', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-25', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-25-01', 'act-cyt-4i-maestro-25', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-26', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-26-01', 'act-cyt-4i-maestro-26', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-27', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-27-01', 'act-cyt-4i-maestro-27', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-28', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-28-01', 'act-cyt-4i-maestro-28', 'Usamos los nariz para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-29', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-29-01', 'act-cyt-4i-maestro-29', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-30', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-30-01', 'act-cyt-4i-maestro-30', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-31', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-31-01', 'act-cyt-4i-maestro-31', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-32', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-32-01', 'act-cyt-4i-maestro-32', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-33', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-33-01', 'act-cyt-4i-maestro-33', 'Usamos los ojos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-34', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-34-01', 'act-cyt-4i-maestro-34', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-35', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-35-01', 'act-cyt-4i-maestro-35', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-36', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-36-01', 'act-cyt-4i-maestro-36', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "edad", "value": "edad"}, {"id": "b", "label": "textura", "value": "textura"}, {"id": "c", "label": "nombre", "value": "nombre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-37', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-37-01', 'act-cyt-4i-maestro-37', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "lluvioso", "value": "lluvioso"}, {"id": "b", "label": "seco", "value": "seco"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-38', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-38-01', 'act-cyt-4i-maestro-38', 'Usamos los pies para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "juguete", "value": "juguete"}, {"id": "b", "label": "planta", "value": "planta"}, {"id": "c", "label": "parte del cuerpo", "value": "parte del cuerpo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-39', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-39-01', 'act-cyt-4i-maestro-39', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "jardín", "value": "jardín"}, {"id": "b", "label": "tacho", "value": "tacho"}, {"id": "c", "label": "piso", "value": "piso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-40', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-40-01', 'act-cyt-4i-maestro-40', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "b", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "c", "label": "basura", "value": "basura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-41', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-41-01', 'act-cyt-4i-maestro-41', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "nombre", "value": "nombre"}, {"id": "b", "label": "edad", "value": "edad"}, {"id": "c", "label": "textura", "value": "textura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-42', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-42-01', 'act-cyt-4i-maestro-42', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "lluvioso", "value": "lluvioso"}, {"id": "c", "label": "seco", "value": "seco"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-43', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-43-01', 'act-cyt-4i-maestro-43', 'Usamos los manos para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "b", "label": "juguete", "value": "juguete"}, {"id": "c", "label": "planta", "value": "planta"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-44', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-44-01', 'act-cyt-4i-maestro-44', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "piso", "value": "piso"}, {"id": "b", "label": "jardín", "value": "jardín"}, {"id": "c", "label": "tacho", "value": "tacho"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-45', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-45-01', 'act-cyt-4i-maestro-45', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "basura", "value": "basura"}, {"id": "b", "label": "agua y alimento", "value": "agua y alimento"}, {"id": "c", "label": "ruido fuerte", "value": "ruido fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-46', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-46-01', 'act-cyt-4i-maestro-46', 'Una esponja y una piedra se sienten diferentes. ¿Qué comparas?', 'Explora materiales.', 'single-choice', 'textura', '[{"id": "a", "label": "textura", "value": "textura"}, {"id": "b", "label": "nombre", "value": "nombre"}, {"id": "c", "label": "edad", "value": "edad"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-47', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-47-01', 'act-cyt-4i-maestro-47', 'Si el cielo está oscuro y caen gotas, el clima está...', 'Observa señales del tiempo.', 'single-choice', 'lluvioso', '[{"id": "a", "label": "seco", "value": "seco"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "lluvioso", "value": "lluvioso"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-48', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-48-01', 'act-cyt-4i-maestro-48', 'Usamos los orejas para cuidar y conocer nuestro cuerpo. ¿Qué son?', 'Reconoce partes del cuerpo.', 'single-choice', 'parte del cuerpo', '[{"id": "a", "label": "planta", "value": "planta"}, {"id": "b", "label": "parte del cuerpo", "value": "parte del cuerpo"}, {"id": "c", "label": "juguete", "value": "juguete"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-49', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-49-01', 'act-cyt-4i-maestro-49', 'Para cuidar el aula, la basura debe ir al...', 'Practica cuidado del ambiente.', 'single-choice', 'tacho', '[{"id": "a", "label": "tacho", "value": "tacho"}, {"id": "b", "label": "piso", "value": "piso"}, {"id": "c", "label": "jardín", "value": "jardín"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-4i-maestro-50', 'les-cyt-4i-maestro', 'ciencia-tecnologia-inicial', '4-anios', 'Ciencia y Tecnología Inicial 4 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-4i-maestro-50-01', 'act-cyt-4i-maestro-50', '¿Qué necesita un animal para estar bien cuidado?', 'Piensa en necesidades básicas.', 'single-choice', 'agua y alimento', '[{"id": "a", "label": "ruido fuerte", "value": "ruido fuerte"}, {"id": "b", "label": "basura", "value": "basura"}, {"id": "c", "label": "agua y alimento", "value": "agua y alimento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
