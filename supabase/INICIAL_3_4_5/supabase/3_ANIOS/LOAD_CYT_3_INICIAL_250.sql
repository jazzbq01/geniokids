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

-- GenioKids - Ciencia y Tecnología Inicial 3 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'semilla', '🌱 Semilla Genial - Ciencia y Tecnología Inicial 3 años', 'animales cercanos', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-01', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-01-01', 'act-cyt-3i-semilla-01', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-02', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-02-01', 'act-cyt-3i-semilla-02', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-03', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-03-01', 'act-cyt-3i-semilla-03', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-04', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-04-01', 'act-cyt-3i-semilla-04', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-05', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-05-01', 'act-cyt-3i-semilla-05', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-06', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-06-01', 'act-cyt-3i-semilla-06', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-07', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-07-01', 'act-cyt-3i-semilla-07', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-08', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-08-01', 'act-cyt-3i-semilla-08', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-09', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-09-01', 'act-cyt-3i-semilla-09', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-10', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-10-01', 'act-cyt-3i-semilla-10', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-11', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-11-01', 'act-cyt-3i-semilla-11', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-12', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-12-01', 'act-cyt-3i-semilla-12', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-13', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-13-01', 'act-cyt-3i-semilla-13', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-14', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-14-01', 'act-cyt-3i-semilla-14', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-15', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-15-01', 'act-cyt-3i-semilla-15', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-16', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-16-01', 'act-cyt-3i-semilla-16', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-17', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-17-01', 'act-cyt-3i-semilla-17', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-18', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-18-01', 'act-cyt-3i-semilla-18', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-19', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-19-01', 'act-cyt-3i-semilla-19', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-20', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-20-01', 'act-cyt-3i-semilla-20', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-21', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-21-01', 'act-cyt-3i-semilla-21', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-22', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-22-01', 'act-cyt-3i-semilla-22', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-23', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-23-01', 'act-cyt-3i-semilla-23', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-24', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-24-01', 'act-cyt-3i-semilla-24', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-25', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-25-01', 'act-cyt-3i-semilla-25', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-26', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-26-01', 'act-cyt-3i-semilla-26', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-27', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-27-01', 'act-cyt-3i-semilla-27', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-28', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-28-01', 'act-cyt-3i-semilla-28', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-29', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-29-01', 'act-cyt-3i-semilla-29', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-30', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-30-01', 'act-cyt-3i-semilla-30', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-31', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-31-01', 'act-cyt-3i-semilla-31', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-32', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-32-01', 'act-cyt-3i-semilla-32', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-33', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-33-01', 'act-cyt-3i-semilla-33', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-34', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-34-01', 'act-cyt-3i-semilla-34', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-35', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-35-01', 'act-cyt-3i-semilla-35', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-36', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-36-01', 'act-cyt-3i-semilla-36', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-37', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-37-01', 'act-cyt-3i-semilla-37', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-38', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-38-01', 'act-cyt-3i-semilla-38', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-39', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-39-01', 'act-cyt-3i-semilla-39', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-40', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-40-01', 'act-cyt-3i-semilla-40', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-41', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-41-01', 'act-cyt-3i-semilla-41', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-42', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-42-01', 'act-cyt-3i-semilla-42', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-43', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-43-01', 'act-cyt-3i-semilla-43', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-44', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-44-01', 'act-cyt-3i-semilla-44', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-45', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-45-01', 'act-cyt-3i-semilla-45', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-46', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-46-01', 'act-cyt-3i-semilla-46', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-47', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-47-01', 'act-cyt-3i-semilla-47', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-48', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-48-01', 'act-cyt-3i-semilla-48', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-49', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-49-01', 'act-cyt-3i-semilla-49', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-semilla-50', 'les-cyt-3i-semilla', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-semilla-50-01', 'act-cyt-3i-semilla-50', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'explorador', '🔎 Explorador Curioso - Ciencia y Tecnología Inicial 3 años', 'plantas del entorno', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-01', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-01-01', 'act-cyt-3i-explorador-01', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-02', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-02-01', 'act-cyt-3i-explorador-02', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-03', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-03-01', 'act-cyt-3i-explorador-03', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-04', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-04-01', 'act-cyt-3i-explorador-04', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-05', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-05-01', 'act-cyt-3i-explorador-05', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-06', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-06-01', 'act-cyt-3i-explorador-06', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-07', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-07-01', 'act-cyt-3i-explorador-07', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-08', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-08-01', 'act-cyt-3i-explorador-08', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-09', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-09-01', 'act-cyt-3i-explorador-09', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-10', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-10-01', 'act-cyt-3i-explorador-10', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-11', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-11-01', 'act-cyt-3i-explorador-11', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-12', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-12-01', 'act-cyt-3i-explorador-12', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-13', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-13-01', 'act-cyt-3i-explorador-13', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-14', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-14-01', 'act-cyt-3i-explorador-14', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-15', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-15-01', 'act-cyt-3i-explorador-15', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-16', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-16-01', 'act-cyt-3i-explorador-16', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-17', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-17-01', 'act-cyt-3i-explorador-17', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-18', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-18-01', 'act-cyt-3i-explorador-18', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-19', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-19-01', 'act-cyt-3i-explorador-19', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-20', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-20-01', 'act-cyt-3i-explorador-20', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-21', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-21-01', 'act-cyt-3i-explorador-21', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-22', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-22-01', 'act-cyt-3i-explorador-22', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-23', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-23-01', 'act-cyt-3i-explorador-23', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-24', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-24-01', 'act-cyt-3i-explorador-24', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-25', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-25-01', 'act-cyt-3i-explorador-25', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-26', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-26-01', 'act-cyt-3i-explorador-26', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-27', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-27-01', 'act-cyt-3i-explorador-27', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-28', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-28-01', 'act-cyt-3i-explorador-28', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-29', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-29-01', 'act-cyt-3i-explorador-29', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-30', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-30-01', 'act-cyt-3i-explorador-30', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-31', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-31-01', 'act-cyt-3i-explorador-31', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-32', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-32-01', 'act-cyt-3i-explorador-32', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-33', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-33-01', 'act-cyt-3i-explorador-33', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-34', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-34-01', 'act-cyt-3i-explorador-34', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-35', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-35-01', 'act-cyt-3i-explorador-35', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-36', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-36-01', 'act-cyt-3i-explorador-36', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-37', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-37-01', 'act-cyt-3i-explorador-37', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-38', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-38-01', 'act-cyt-3i-explorador-38', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-39', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-39-01', 'act-cyt-3i-explorador-39', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-40', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-40-01', 'act-cyt-3i-explorador-40', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-41', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-41-01', 'act-cyt-3i-explorador-41', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-42', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-42-01', 'act-cyt-3i-explorador-42', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-43', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-43-01', 'act-cyt-3i-explorador-43', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-44', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-44-01', 'act-cyt-3i-explorador-44', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-45', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-45-01', 'act-cyt-3i-explorador-45', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-46', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-46-01', 'act-cyt-3i-explorador-46', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-47', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-47-01', 'act-cyt-3i-explorador-47', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-48', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-48-01', 'act-cyt-3i-explorador-48', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-49', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-49-01', 'act-cyt-3i-explorador-49', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-explorador-50', 'les-cyt-3i-explorador', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-explorador-50-01', 'act-cyt-3i-explorador-50', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'aventurero', '🧭 Aventurero Ágil - Ciencia y Tecnología Inicial 3 años', 'sentidos', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-01', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-01-01', 'act-cyt-3i-aventurero-01', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-02', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-02-01', 'act-cyt-3i-aventurero-02', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-03', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-03-01', 'act-cyt-3i-aventurero-03', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-04', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-04-01', 'act-cyt-3i-aventurero-04', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-05', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-05-01', 'act-cyt-3i-aventurero-05', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-06', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-06-01', 'act-cyt-3i-aventurero-06', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-07', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-07-01', 'act-cyt-3i-aventurero-07', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-08', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-08-01', 'act-cyt-3i-aventurero-08', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-09', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-09-01', 'act-cyt-3i-aventurero-09', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-10', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-10-01', 'act-cyt-3i-aventurero-10', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-11', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-11-01', 'act-cyt-3i-aventurero-11', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-12', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-12-01', 'act-cyt-3i-aventurero-12', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-13', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-13-01', 'act-cyt-3i-aventurero-13', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-14', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-14-01', 'act-cyt-3i-aventurero-14', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-15', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-15-01', 'act-cyt-3i-aventurero-15', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-16', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-16-01', 'act-cyt-3i-aventurero-16', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-17', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-17-01', 'act-cyt-3i-aventurero-17', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-18', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-18-01', 'act-cyt-3i-aventurero-18', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-19', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-19-01', 'act-cyt-3i-aventurero-19', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-20', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-20-01', 'act-cyt-3i-aventurero-20', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-21', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-21-01', 'act-cyt-3i-aventurero-21', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-22', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-22-01', 'act-cyt-3i-aventurero-22', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-23', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-23-01', 'act-cyt-3i-aventurero-23', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-24', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-24-01', 'act-cyt-3i-aventurero-24', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-25', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-25-01', 'act-cyt-3i-aventurero-25', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-26', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-26-01', 'act-cyt-3i-aventurero-26', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-27', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-27-01', 'act-cyt-3i-aventurero-27', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-28', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-28-01', 'act-cyt-3i-aventurero-28', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-29', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-29-01', 'act-cyt-3i-aventurero-29', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-30', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-30-01', 'act-cyt-3i-aventurero-30', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-31', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-31-01', 'act-cyt-3i-aventurero-31', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-32', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-32-01', 'act-cyt-3i-aventurero-32', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-33', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-33-01', 'act-cyt-3i-aventurero-33', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-34', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-34-01', 'act-cyt-3i-aventurero-34', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-35', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-35-01', 'act-cyt-3i-aventurero-35', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-36', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-36-01', 'act-cyt-3i-aventurero-36', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-37', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-37-01', 'act-cyt-3i-aventurero-37', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-38', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-38-01', 'act-cyt-3i-aventurero-38', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-39', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-39-01', 'act-cyt-3i-aventurero-39', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-40', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-40-01', 'act-cyt-3i-aventurero-40', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-41', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-41-01', 'act-cyt-3i-aventurero-41', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-42', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-42-01', 'act-cyt-3i-aventurero-42', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-43', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-43-01', 'act-cyt-3i-aventurero-43', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-44', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-44-01', 'act-cyt-3i-aventurero-44', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-45', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-45-01', 'act-cyt-3i-aventurero-45', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-46', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-46-01', 'act-cyt-3i-aventurero-46', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-47', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-47-01', 'act-cyt-3i-aventurero-47', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-48', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-48-01', 'act-cyt-3i-aventurero-48', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-49', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-49-01', 'act-cyt-3i-aventurero-49', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-aventurero-50', 'les-cyt-3i-aventurero', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-aventurero-50-01', 'act-cyt-3i-aventurero-50', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'estrella', '⭐ Estrella Brillante - Ciencia y Tecnología Inicial 3 años', 'agua y limpieza', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-01', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-01-01', 'act-cyt-3i-estrella-01', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-02', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-02-01', 'act-cyt-3i-estrella-02', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-03', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-03-01', 'act-cyt-3i-estrella-03', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-04', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-04-01', 'act-cyt-3i-estrella-04', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-05', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-05-01', 'act-cyt-3i-estrella-05', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-06', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-06-01', 'act-cyt-3i-estrella-06', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-07', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-07-01', 'act-cyt-3i-estrella-07', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-08', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-08-01', 'act-cyt-3i-estrella-08', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-09', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-09-01', 'act-cyt-3i-estrella-09', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-10', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-10-01', 'act-cyt-3i-estrella-10', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-11', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-11-01', 'act-cyt-3i-estrella-11', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-12', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-12-01', 'act-cyt-3i-estrella-12', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-13', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-13-01', 'act-cyt-3i-estrella-13', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-14', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-14-01', 'act-cyt-3i-estrella-14', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-15', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-15-01', 'act-cyt-3i-estrella-15', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-16', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-16-01', 'act-cyt-3i-estrella-16', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-17', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-17-01', 'act-cyt-3i-estrella-17', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-18', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-18-01', 'act-cyt-3i-estrella-18', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-19', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-19-01', 'act-cyt-3i-estrella-19', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-20', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-20-01', 'act-cyt-3i-estrella-20', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-21', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-21-01', 'act-cyt-3i-estrella-21', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-22', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-22-01', 'act-cyt-3i-estrella-22', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-23', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-23-01', 'act-cyt-3i-estrella-23', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-24', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-24-01', 'act-cyt-3i-estrella-24', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-25', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-25-01', 'act-cyt-3i-estrella-25', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-26', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-26-01', 'act-cyt-3i-estrella-26', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-27', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-27-01', 'act-cyt-3i-estrella-27', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-28', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-28-01', 'act-cyt-3i-estrella-28', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-29', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-29-01', 'act-cyt-3i-estrella-29', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-30', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-30-01', 'act-cyt-3i-estrella-30', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-31', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-31-01', 'act-cyt-3i-estrella-31', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-32', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-32-01', 'act-cyt-3i-estrella-32', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-33', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-33-01', 'act-cyt-3i-estrella-33', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-34', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-34-01', 'act-cyt-3i-estrella-34', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-35', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-35-01', 'act-cyt-3i-estrella-35', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-36', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-36-01', 'act-cyt-3i-estrella-36', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-37', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-37-01', 'act-cyt-3i-estrella-37', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-38', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-38-01', 'act-cyt-3i-estrella-38', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-39', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-39-01', 'act-cyt-3i-estrella-39', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-40', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-40-01', 'act-cyt-3i-estrella-40', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-41', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-41-01', 'act-cyt-3i-estrella-41', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-42', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-42-01', 'act-cyt-3i-estrella-42', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-43', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-43-01', 'act-cyt-3i-estrella-43', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-44', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-44-01', 'act-cyt-3i-estrella-44', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-45', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-45-01', 'act-cyt-3i-estrella-45', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-46', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-46-01', 'act-cyt-3i-estrella-46', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-47', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-47-01', 'act-cyt-3i-estrella-47', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-48', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-48-01', 'act-cyt-3i-estrella-48', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-49', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-49-01', 'act-cyt-3i-estrella-49', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-estrella-50', 'les-cyt-3i-estrella', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-estrella-50-01', 'act-cyt-3i-estrella-50', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'maestro', '🏆 Maestro Genio - Ciencia y Tecnología Inicial 3 años', 'día y noche', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-01', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 01', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-01-01', 'act-cyt-3i-maestro-01', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-02', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 02', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-02-01', 'act-cyt-3i-maestro-02', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-03', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 03', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-03-01', 'act-cyt-3i-maestro-03', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-04', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 04', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-04-01', 'act-cyt-3i-maestro-04', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-05', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 05', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-05-01', 'act-cyt-3i-maestro-05', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-06', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 06', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-06-01', 'act-cyt-3i-maestro-06', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-07', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 07', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-07-01', 'act-cyt-3i-maestro-07', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-08', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 08', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-08-01', 'act-cyt-3i-maestro-08', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-09', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 09', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-09-01', 'act-cyt-3i-maestro-09', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-10', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 10', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-10-01', 'act-cyt-3i-maestro-10', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-11', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 11', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-11-01', 'act-cyt-3i-maestro-11', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-12', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 12', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-12-01', 'act-cyt-3i-maestro-12', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-13', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 13', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-13-01', 'act-cyt-3i-maestro-13', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-14', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 14', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-14-01', 'act-cyt-3i-maestro-14', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-15', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 15', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-15-01', 'act-cyt-3i-maestro-15', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-16', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 16', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-16-01', 'act-cyt-3i-maestro-16', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-17', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 17', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-17-01', 'act-cyt-3i-maestro-17', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-18', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 18', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-18-01', 'act-cyt-3i-maestro-18', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-19', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 19', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-19-01', 'act-cyt-3i-maestro-19', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-20', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 20', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-20-01', 'act-cyt-3i-maestro-20', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-21', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 21', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-21-01', 'act-cyt-3i-maestro-21', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-22', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 22', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-22-01', 'act-cyt-3i-maestro-22', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-23', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 23', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-23-01', 'act-cyt-3i-maestro-23', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-24', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 24', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-24-01', 'act-cyt-3i-maestro-24', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-25', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 25', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-25-01', 'act-cyt-3i-maestro-25', 'El perro está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'guau', '[{"id": "a", "label": "guau", "value": "guau"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-26', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 26', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-26-01', 'act-cyt-3i-maestro-26', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-27', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 27', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-27-01', 'act-cyt-3i-maestro-27', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-28', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 28', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-28-01', 'act-cyt-3i-maestro-28', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-29', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 29', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-29-01', 'act-cyt-3i-maestro-29', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-30', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 30', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-30-01', 'act-cyt-3i-maestro-30', 'El mariposa está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'vuela', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "vuela", "value": "vuela"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-31', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 31', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-31-01', 'act-cyt-3i-maestro-31', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-32', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 32', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-32-01', 'act-cyt-3i-maestro-32', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-33', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 33', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-33-01', 'act-cyt-3i-maestro-33', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-34', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 34', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-34-01', 'act-cyt-3i-maestro-34', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-35', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 35', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-35-01', 'act-cyt-3i-maestro-35', 'El gallina está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'clo-clo', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "clo-clo", "value": "clo-clo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-36', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 36', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-36-01', 'act-cyt-3i-maestro-36', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "b", "label": "agua", "value": "agua"}, {"id": "c", "label": "papel roto", "value": "papel roto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-37', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 37', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-37-01', 'act-cyt-3i-maestro-37', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "olfato", "value": "olfato"}, {"id": "b", "label": "oído", "value": "oído"}, {"id": "c", "label": "tacto", "value": "tacto"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-38', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 38', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-38-01', 'act-cyt-3i-maestro-38', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "b", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "c", "label": "lavarnos las manos", "value": "lavarnos las manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-39', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 39', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-39-01', 'act-cyt-3i-maestro-39', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "recreo", "value": "recreo"}, {"id": "b", "label": "día", "value": "día"}, {"id": "c", "label": "noche", "value": "noche"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-40', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 40', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-40-01', 'act-cyt-3i-maestro-40', 'El conejo está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'salta', '[{"id": "a", "label": "salta", "value": "salta"}, {"id": "b", "label": "rueda", "value": "rueda"}, {"id": "c", "label": "mesa", "value": "mesa"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-41', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 41', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-41-01', 'act-cyt-3i-maestro-41', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "papel roto", "value": "papel roto"}, {"id": "b", "label": "piedras siempre", "value": "piedras siempre"}, {"id": "c", "label": "agua", "value": "agua"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-42', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 42', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-42-01', 'act-cyt-3i-maestro-42', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "tacto", "value": "tacto"}, {"id": "b", "label": "olfato", "value": "olfato"}, {"id": "c", "label": "oído", "value": "oído"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-43', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 43', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-43-01', 'act-cyt-3i-maestro-43', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "b", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}, {"id": "c", "label": "comer sin limpiar", "value": "comer sin limpiar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-44', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 44', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-44-01', 'act-cyt-3i-maestro-44', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "noche", "value": "noche"}, {"id": "b", "label": "recreo", "value": "recreo"}, {"id": "c", "label": "día", "value": "día"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-45', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 45', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-45-01', 'act-cyt-3i-maestro-45', 'El pato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'cuac', '[{"id": "a", "label": "mesa", "value": "mesa"}, {"id": "b", "label": "cuac", "value": "cuac"}, {"id": "c", "label": "rueda", "value": "rueda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-46', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 46', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-46-01', 'act-cyt-3i-maestro-46', 'Para cuidar una planta, podemos darle...', 'Piensa qué necesita para vivir.', 'single-choice', 'agua', '[{"id": "a", "label": "agua", "value": "agua"}, {"id": "b", "label": "papel roto", "value": "papel roto"}, {"id": "c", "label": "piedras siempre", "value": "piedras siempre"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-47', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 47', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-47-01', 'act-cyt-3i-maestro-47', '¿Qué sentido usamos para oler una flor?', 'Relaciona el sentido con su órgano.', 'single-choice', 'olfato', '[{"id": "a", "label": "oído", "value": "oído"}, {"id": "b", "label": "tacto", "value": "tacto"}, {"id": "c", "label": "olfato", "value": "olfato"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-48', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 48', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-48-01', 'act-cyt-3i-maestro-48', 'Después de jugar con tierra, debemos...', 'Cuida tu salud.', 'single-choice', 'lavarnos las manos', '[{"id": "a", "label": "comer sin limpiar", "value": "comer sin limpiar"}, {"id": "b", "label": "lavarnos las manos", "value": "lavarnos las manos"}, {"id": "c", "label": "tocarnos los ojos", "value": "tocarnos los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-49', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 49', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-49-01', 'act-cyt-3i-maestro-49', 'Cuando sale el sol, normalmente es...', 'Diferencia día y noche.', 'single-choice', 'día', '[{"id": "a", "label": "día", "value": "día"}, {"id": "b", "label": "noche", "value": "noche"}, {"id": "c", "label": "recreo", "value": "recreo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-cyt-3i-maestro-50', 'les-cyt-3i-maestro', 'ciencia-tecnologia-inicial', '3-anios', 'Ciencia y Tecnología Inicial 3 años - Misión 50', 'Actividad lúdica de Ciencia y Tecnología para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-cyt-3i-maestro-50-01', 'act-cyt-3i-maestro-50', 'El gato está en el cuento. ¿Qué característica se relaciona con él?', 'Observa o recuerda al animal.', 'single-choice', 'miau', '[{"id": "a", "label": "rueda", "value": "rueda"}, {"id": "b", "label": "mesa", "value": "mesa"}, {"id": "c", "label": "miau", "value": "miau"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
