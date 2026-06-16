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

-- GenioKids - Psicomotriz Inicial 5 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'semilla', '🌱 Semilla Genial - Psicomotriz Inicial 5 años', 'lateralidad', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-01', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-01-01', 'act-psi-5i-semilla-01', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-02', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-02-01', 'act-psi-5i-semilla-02', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-03', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-03-01', 'act-psi-5i-semilla-03', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-04', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-04-01', 'act-psi-5i-semilla-04', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-05', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-05-01', 'act-psi-5i-semilla-05', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-06', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-06-01', 'act-psi-5i-semilla-06', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-07', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-07-01', 'act-psi-5i-semilla-07', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-08', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-08-01', 'act-psi-5i-semilla-08', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-09', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-09-01', 'act-psi-5i-semilla-09', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-10', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-10-01', 'act-psi-5i-semilla-10', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-11', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-11-01', 'act-psi-5i-semilla-11', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-12', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-12-01', 'act-psi-5i-semilla-12', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-13', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-13-01', 'act-psi-5i-semilla-13', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-14', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-14-01', 'act-psi-5i-semilla-14', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-15', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-15-01', 'act-psi-5i-semilla-15', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-16', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-16-01', 'act-psi-5i-semilla-16', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-17', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-17-01', 'act-psi-5i-semilla-17', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-18', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-18-01', 'act-psi-5i-semilla-18', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-19', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-19-01', 'act-psi-5i-semilla-19', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-20', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-20-01', 'act-psi-5i-semilla-20', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-21', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-21-01', 'act-psi-5i-semilla-21', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-22', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-22-01', 'act-psi-5i-semilla-22', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-23', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-23-01', 'act-psi-5i-semilla-23', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-24', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-24-01', 'act-psi-5i-semilla-24', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-25', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-25-01', 'act-psi-5i-semilla-25', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-26', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-26-01', 'act-psi-5i-semilla-26', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-27', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-27-01', 'act-psi-5i-semilla-27', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-28', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-28-01', 'act-psi-5i-semilla-28', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-29', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-29-01', 'act-psi-5i-semilla-29', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-30', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-30-01', 'act-psi-5i-semilla-30', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-31', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-31-01', 'act-psi-5i-semilla-31', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-32', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-32-01', 'act-psi-5i-semilla-32', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-33', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-33-01', 'act-psi-5i-semilla-33', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-34', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-34-01', 'act-psi-5i-semilla-34', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-35', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-35-01', 'act-psi-5i-semilla-35', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-36', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-36-01', 'act-psi-5i-semilla-36', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-37', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-37-01', 'act-psi-5i-semilla-37', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-38', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-38-01', 'act-psi-5i-semilla-38', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-39', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-39-01', 'act-psi-5i-semilla-39', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-40', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-40-01', 'act-psi-5i-semilla-40', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-41', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-41-01', 'act-psi-5i-semilla-41', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-42', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-42-01', 'act-psi-5i-semilla-42', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-43', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-43-01', 'act-psi-5i-semilla-43', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-44', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-44-01', 'act-psi-5i-semilla-44', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-45', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-45-01', 'act-psi-5i-semilla-45', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-46', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-46-01', 'act-psi-5i-semilla-46', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-47', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-47-01', 'act-psi-5i-semilla-47', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-48', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-48-01', 'act-psi-5i-semilla-48', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-49', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-49-01', 'act-psi-5i-semilla-49', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-semilla-50', 'les-psi-5i-semilla', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-semilla-50-01', 'act-psi-5i-semilla-50', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'explorador', '🔎 Explorador Curioso - Psicomotriz Inicial 5 años', 'coordinación dinámica', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-01', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-01-01', 'act-psi-5i-explorador-01', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-02', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-02-01', 'act-psi-5i-explorador-02', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-03', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-03-01', 'act-psi-5i-explorador-03', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-04', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-04-01', 'act-psi-5i-explorador-04', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-05', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-05-01', 'act-psi-5i-explorador-05', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-06', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-06-01', 'act-psi-5i-explorador-06', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-07', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-07-01', 'act-psi-5i-explorador-07', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-08', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-08-01', 'act-psi-5i-explorador-08', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-09', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-09-01', 'act-psi-5i-explorador-09', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-10', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-10-01', 'act-psi-5i-explorador-10', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-11', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-11-01', 'act-psi-5i-explorador-11', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-12', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-12-01', 'act-psi-5i-explorador-12', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-13', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-13-01', 'act-psi-5i-explorador-13', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-14', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-14-01', 'act-psi-5i-explorador-14', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-15', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-15-01', 'act-psi-5i-explorador-15', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-16', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-16-01', 'act-psi-5i-explorador-16', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-17', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-17-01', 'act-psi-5i-explorador-17', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-18', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-18-01', 'act-psi-5i-explorador-18', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-19', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-19-01', 'act-psi-5i-explorador-19', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-20', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-20-01', 'act-psi-5i-explorador-20', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-21', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-21-01', 'act-psi-5i-explorador-21', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-22', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-22-01', 'act-psi-5i-explorador-22', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-23', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-23-01', 'act-psi-5i-explorador-23', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-24', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-24-01', 'act-psi-5i-explorador-24', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-25', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-25-01', 'act-psi-5i-explorador-25', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-26', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-26-01', 'act-psi-5i-explorador-26', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-27', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-27-01', 'act-psi-5i-explorador-27', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-28', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-28-01', 'act-psi-5i-explorador-28', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-29', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-29-01', 'act-psi-5i-explorador-29', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-30', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-30-01', 'act-psi-5i-explorador-30', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-31', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-31-01', 'act-psi-5i-explorador-31', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-32', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-32-01', 'act-psi-5i-explorador-32', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-33', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-33-01', 'act-psi-5i-explorador-33', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-34', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-34-01', 'act-psi-5i-explorador-34', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-35', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-35-01', 'act-psi-5i-explorador-35', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-36', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-36-01', 'act-psi-5i-explorador-36', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-37', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-37-01', 'act-psi-5i-explorador-37', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-38', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-38-01', 'act-psi-5i-explorador-38', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-39', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-39-01', 'act-psi-5i-explorador-39', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-40', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-40-01', 'act-psi-5i-explorador-40', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-41', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-41-01', 'act-psi-5i-explorador-41', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-42', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-42-01', 'act-psi-5i-explorador-42', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-43', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-43-01', 'act-psi-5i-explorador-43', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-44', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-44-01', 'act-psi-5i-explorador-44', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-45', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-45-01', 'act-psi-5i-explorador-45', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-46', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-46-01', 'act-psi-5i-explorador-46', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-47', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-47-01', 'act-psi-5i-explorador-47', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-48', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-48-01', 'act-psi-5i-explorador-48', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-49', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-49-01', 'act-psi-5i-explorador-49', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-explorador-50', 'les-psi-5i-explorador', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-explorador-50-01', 'act-psi-5i-explorador-50', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'aventurero', '🧭 Aventurero Ágil - Psicomotriz Inicial 5 años', 'juegos con reglas', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-01', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-01-01', 'act-psi-5i-aventurero-01', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-02', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-02-01', 'act-psi-5i-aventurero-02', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-03', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-03-01', 'act-psi-5i-aventurero-03', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-04', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-04-01', 'act-psi-5i-aventurero-04', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-05', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-05-01', 'act-psi-5i-aventurero-05', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-06', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-06-01', 'act-psi-5i-aventurero-06', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-07', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-07-01', 'act-psi-5i-aventurero-07', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-08', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-08-01', 'act-psi-5i-aventurero-08', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-09', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-09-01', 'act-psi-5i-aventurero-09', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-10', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-10-01', 'act-psi-5i-aventurero-10', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-11', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-11-01', 'act-psi-5i-aventurero-11', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-12', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-12-01', 'act-psi-5i-aventurero-12', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-13', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-13-01', 'act-psi-5i-aventurero-13', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-14', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-14-01', 'act-psi-5i-aventurero-14', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-15', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-15-01', 'act-psi-5i-aventurero-15', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-16', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-16-01', 'act-psi-5i-aventurero-16', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-17', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-17-01', 'act-psi-5i-aventurero-17', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-18', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-18-01', 'act-psi-5i-aventurero-18', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-19', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-19-01', 'act-psi-5i-aventurero-19', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-20', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-20-01', 'act-psi-5i-aventurero-20', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-21', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-21-01', 'act-psi-5i-aventurero-21', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-22', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-22-01', 'act-psi-5i-aventurero-22', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-23', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-23-01', 'act-psi-5i-aventurero-23', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-24', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-24-01', 'act-psi-5i-aventurero-24', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-25', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-25-01', 'act-psi-5i-aventurero-25', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-26', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-26-01', 'act-psi-5i-aventurero-26', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-27', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-27-01', 'act-psi-5i-aventurero-27', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-28', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-28-01', 'act-psi-5i-aventurero-28', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-29', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-29-01', 'act-psi-5i-aventurero-29', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-30', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-30-01', 'act-psi-5i-aventurero-30', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-31', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-31-01', 'act-psi-5i-aventurero-31', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-32', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-32-01', 'act-psi-5i-aventurero-32', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-33', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-33-01', 'act-psi-5i-aventurero-33', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-34', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-34-01', 'act-psi-5i-aventurero-34', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-35', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-35-01', 'act-psi-5i-aventurero-35', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-36', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-36-01', 'act-psi-5i-aventurero-36', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-37', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-37-01', 'act-psi-5i-aventurero-37', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-38', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-38-01', 'act-psi-5i-aventurero-38', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-39', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-39-01', 'act-psi-5i-aventurero-39', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-40', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-40-01', 'act-psi-5i-aventurero-40', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-41', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-41-01', 'act-psi-5i-aventurero-41', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-42', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-42-01', 'act-psi-5i-aventurero-42', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-43', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-43-01', 'act-psi-5i-aventurero-43', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-44', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-44-01', 'act-psi-5i-aventurero-44', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-45', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-45-01', 'act-psi-5i-aventurero-45', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-46', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-46-01', 'act-psi-5i-aventurero-46', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-47', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-47-01', 'act-psi-5i-aventurero-47', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-48', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-48-01', 'act-psi-5i-aventurero-48', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-49', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-49-01', 'act-psi-5i-aventurero-49', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-aventurero-50', 'les-psi-5i-aventurero', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-aventurero-50-01', 'act-psi-5i-aventurero-50', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'estrella', '⭐ Estrella Brillante - Psicomotriz Inicial 5 años', 'postura y respiración', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-01', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-01-01', 'act-psi-5i-estrella-01', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-02', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-02-01', 'act-psi-5i-estrella-02', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-03', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-03-01', 'act-psi-5i-estrella-03', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-04', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-04-01', 'act-psi-5i-estrella-04', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-05', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-05-01', 'act-psi-5i-estrella-05', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-06', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-06-01', 'act-psi-5i-estrella-06', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-07', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-07-01', 'act-psi-5i-estrella-07', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-08', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-08-01', 'act-psi-5i-estrella-08', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-09', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-09-01', 'act-psi-5i-estrella-09', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-10', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-10-01', 'act-psi-5i-estrella-10', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-11', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-11-01', 'act-psi-5i-estrella-11', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-12', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-12-01', 'act-psi-5i-estrella-12', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-13', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-13-01', 'act-psi-5i-estrella-13', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-14', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-14-01', 'act-psi-5i-estrella-14', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-15', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-15-01', 'act-psi-5i-estrella-15', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-16', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-16-01', 'act-psi-5i-estrella-16', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-17', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-17-01', 'act-psi-5i-estrella-17', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-18', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-18-01', 'act-psi-5i-estrella-18', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-19', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-19-01', 'act-psi-5i-estrella-19', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-20', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-20-01', 'act-psi-5i-estrella-20', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-21', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-21-01', 'act-psi-5i-estrella-21', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-22', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-22-01', 'act-psi-5i-estrella-22', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-23', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-23-01', 'act-psi-5i-estrella-23', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-24', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-24-01', 'act-psi-5i-estrella-24', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-25', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-25-01', 'act-psi-5i-estrella-25', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-26', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-26-01', 'act-psi-5i-estrella-26', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-27', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-27-01', 'act-psi-5i-estrella-27', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-28', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-28-01', 'act-psi-5i-estrella-28', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-29', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-29-01', 'act-psi-5i-estrella-29', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-30', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-30-01', 'act-psi-5i-estrella-30', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-31', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-31-01', 'act-psi-5i-estrella-31', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-32', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-32-01', 'act-psi-5i-estrella-32', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-33', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-33-01', 'act-psi-5i-estrella-33', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-34', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-34-01', 'act-psi-5i-estrella-34', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-35', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-35-01', 'act-psi-5i-estrella-35', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-36', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-36-01', 'act-psi-5i-estrella-36', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-37', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-37-01', 'act-psi-5i-estrella-37', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-38', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-38-01', 'act-psi-5i-estrella-38', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-39', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-39-01', 'act-psi-5i-estrella-39', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-40', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-40-01', 'act-psi-5i-estrella-40', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-41', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-41-01', 'act-psi-5i-estrella-41', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-42', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-42-01', 'act-psi-5i-estrella-42', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-43', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-43-01', 'act-psi-5i-estrella-43', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-44', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-44-01', 'act-psi-5i-estrella-44', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-45', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-45-01', 'act-psi-5i-estrella-45', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-46', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-46-01', 'act-psi-5i-estrella-46', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-47', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-47-01', 'act-psi-5i-estrella-47', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-48', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-48-01', 'act-psi-5i-estrella-48', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-49', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-49-01', 'act-psi-5i-estrella-49', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-estrella-50', 'les-psi-5i-estrella', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-estrella-50-01', 'act-psi-5i-estrella-50', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'maestro', '🏆 Maestro Genio - Psicomotriz Inicial 5 años', 'expresión corporal', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-01', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-01-01', 'act-psi-5i-maestro-01', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-02', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-02-01', 'act-psi-5i-maestro-02', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-03', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-03-01', 'act-psi-5i-maestro-03', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-04', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-04-01', 'act-psi-5i-maestro-04', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-05', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-05-01', 'act-psi-5i-maestro-05', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-06', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-06-01', 'act-psi-5i-maestro-06', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-07', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-07-01', 'act-psi-5i-maestro-07', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-08', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-08-01', 'act-psi-5i-maestro-08', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-09', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-09-01', 'act-psi-5i-maestro-09', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-10', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-10-01', 'act-psi-5i-maestro-10', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-11', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-11-01', 'act-psi-5i-maestro-11', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-12', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-12-01', 'act-psi-5i-maestro-12', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-13', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-13-01', 'act-psi-5i-maestro-13', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-14', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-14-01', 'act-psi-5i-maestro-14', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-15', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-15-01', 'act-psi-5i-maestro-15', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-16', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-16-01', 'act-psi-5i-maestro-16', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-17', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-17-01', 'act-psi-5i-maestro-17', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-18', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-18-01', 'act-psi-5i-maestro-18', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-19', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-19-01', 'act-psi-5i-maestro-19', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-20', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-20-01', 'act-psi-5i-maestro-20', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-21', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-21-01', 'act-psi-5i-maestro-21', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-22', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-22-01', 'act-psi-5i-maestro-22', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-23', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-23-01', 'act-psi-5i-maestro-23', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-24', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-24-01', 'act-psi-5i-maestro-24', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-25', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-25-01', 'act-psi-5i-maestro-25', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-26', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-26-01', 'act-psi-5i-maestro-26', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-27', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-27-01', 'act-psi-5i-maestro-27', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-28', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-28-01', 'act-psi-5i-maestro-28', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-29', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-29-01', 'act-psi-5i-maestro-29', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-30', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-30-01', 'act-psi-5i-maestro-30', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-31', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-31-01', 'act-psi-5i-maestro-31', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-32', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-32-01', 'act-psi-5i-maestro-32', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-33', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-33-01', 'act-psi-5i-maestro-33', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-34', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-34-01', 'act-psi-5i-maestro-34', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-35', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-35-01', 'act-psi-5i-maestro-35', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-36', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-36-01', 'act-psi-5i-maestro-36', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "merienda", "value": "merienda"}, {"id": "b", "label": "coordinación", "value": "coordinación"}, {"id": "c", "label": "lectura", "value": "lectura"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-37', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-37-01', 'act-psi-5i-maestro-37', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "b", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "c", "label": "ocultar la pelota", "value": "ocultar la pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-38', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-38-01', 'act-psi-5i-maestro-38', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "sin parar", "value": "sin parar"}, {"id": "b", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "c", "label": "profundo y lento", "value": "profundo y lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-39', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-39-01', 'act-psi-5i-maestro-39', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "medición", "value": "medición"}, {"id": "b", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "c", "label": "conteo", "value": "conteo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-40', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-40-01', 'act-psi-5i-maestro-40', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "derecha", "value": "derecha"}, {"id": "b", "label": "izquierda", "value": "izquierda"}, {"id": "c", "label": "espalda", "value": "espalda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-41', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-41-01', 'act-psi-5i-maestro-41', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "lectura", "value": "lectura"}, {"id": "b", "label": "merienda", "value": "merienda"}, {"id": "c", "label": "coordinación", "value": "coordinación"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-42', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-42-01', 'act-psi-5i-maestro-42', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "b", "label": "escuchar las reglas", "value": "escuchar las reglas"}, {"id": "c", "label": "salir corriendo", "value": "salir corriendo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-43', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-43-01', 'act-psi-5i-maestro-43', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "b", "label": "sin parar", "value": "sin parar"}, {"id": "c", "label": "muy fuerte", "value": "muy fuerte"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-44', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-44-01', 'act-psi-5i-maestro-44', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "conteo", "value": "conteo"}, {"id": "b", "label": "medición", "value": "medición"}, {"id": "c", "label": "expresión corporal", "value": "expresión corporal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-45', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-45-01', 'act-psi-5i-maestro-45', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "espalda", "value": "espalda"}, {"id": "b", "label": "derecha", "value": "derecha"}, {"id": "c", "label": "izquierda", "value": "izquierda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-46', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-46-01', 'act-psi-5i-maestro-46', 'Saltar dentro y fuera de aros mejora la...', 'Coordina movimientos amplios.', 'single-choice', 'coordinación', '[{"id": "a", "label": "coordinación", "value": "coordinación"}, {"id": "b", "label": "lectura", "value": "lectura"}, {"id": "c", "label": "merienda", "value": "merienda"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-47', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-47-01', 'act-psi-5i-maestro-47', 'En un juego con reglas, antes de empezar debemos...', 'Respeta acuerdos del juego.', 'single-choice', 'escuchar las reglas', '[{"id": "a", "label": "salir corriendo", "value": "salir corriendo"}, {"id": "b", "label": "ocultar la pelota", "value": "ocultar la pelota"}, {"id": "c", "label": "escuchar las reglas", "value": "escuchar las reglas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-48', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-48-01', 'act-psi-5i-maestro-48', 'Cuando terminas una carrera, conviene respirar...', 'Recupera el ritmo del cuerpo.', 'single-choice', 'profundo y lento', '[{"id": "a", "label": "muy fuerte", "value": "muy fuerte"}, {"id": "b", "label": "profundo y lento", "value": "profundo y lento"}, {"id": "c", "label": "sin parar", "value": "sin parar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-49', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-49-01', 'act-psi-5i-maestro-49', 'Dramatizar un animal con el cuerpo es una forma de...', 'Expresa ideas con movimientos.', 'single-choice', 'expresión corporal', '[{"id": "a", "label": "expresión corporal", "value": "expresión corporal"}, {"id": "b", "label": "conteo", "value": "conteo"}, {"id": "c", "label": "medición", "value": "medición"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-5i-maestro-50', 'les-psi-5i-maestro', 'psicomotriz-inicial', '5-anios', 'Psicomotriz Inicial 5 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-5i-maestro-50-01', 'act-psi-5i-maestro-50', 'Si levantas la mano derecha, estás usando la...', 'Reconoce los lados del cuerpo.', 'single-choice', 'derecha', '[{"id": "a", "label": "izquierda", "value": "izquierda"}, {"id": "b", "label": "espalda", "value": "espalda"}, {"id": "c", "label": "derecha", "value": "derecha"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
