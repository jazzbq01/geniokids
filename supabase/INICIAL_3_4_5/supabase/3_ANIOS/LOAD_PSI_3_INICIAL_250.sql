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

-- GenioKids - Psicomotriz Inicial 3 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'semilla', '🌱 Semilla Genial - Psicomotriz Inicial 3 años', 'caminar y saltar', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-01', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-01-01', 'act-psi-3i-semilla-01', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-02', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-02-01', 'act-psi-3i-semilla-02', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-03', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-03-01', 'act-psi-3i-semilla-03', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-04', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-04-01', 'act-psi-3i-semilla-04', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-05', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-05-01', 'act-psi-3i-semilla-05', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-06', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-06-01', 'act-psi-3i-semilla-06', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-07', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-07-01', 'act-psi-3i-semilla-07', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-08', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-08-01', 'act-psi-3i-semilla-08', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-09', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-09-01', 'act-psi-3i-semilla-09', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-10', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-10-01', 'act-psi-3i-semilla-10', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-11', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-11-01', 'act-psi-3i-semilla-11', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-12', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-12-01', 'act-psi-3i-semilla-12', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-13', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-13-01', 'act-psi-3i-semilla-13', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-14', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-14-01', 'act-psi-3i-semilla-14', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-15', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-15-01', 'act-psi-3i-semilla-15', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-16', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-16-01', 'act-psi-3i-semilla-16', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-17', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-17-01', 'act-psi-3i-semilla-17', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-18', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-18-01', 'act-psi-3i-semilla-18', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-19', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-19-01', 'act-psi-3i-semilla-19', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-20', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-20-01', 'act-psi-3i-semilla-20', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-21', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-21-01', 'act-psi-3i-semilla-21', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-22', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-22-01', 'act-psi-3i-semilla-22', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-23', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-23-01', 'act-psi-3i-semilla-23', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-24', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-24-01', 'act-psi-3i-semilla-24', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-25', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-25-01', 'act-psi-3i-semilla-25', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-26', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-26-01', 'act-psi-3i-semilla-26', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-27', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-27-01', 'act-psi-3i-semilla-27', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-28', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-28-01', 'act-psi-3i-semilla-28', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-29', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-29-01', 'act-psi-3i-semilla-29', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-30', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-30-01', 'act-psi-3i-semilla-30', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-31', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-31-01', 'act-psi-3i-semilla-31', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-32', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-32-01', 'act-psi-3i-semilla-32', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-33', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-33-01', 'act-psi-3i-semilla-33', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-34', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-34-01', 'act-psi-3i-semilla-34', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-35', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-35-01', 'act-psi-3i-semilla-35', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-36', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-36-01', 'act-psi-3i-semilla-36', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-37', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-37-01', 'act-psi-3i-semilla-37', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-38', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-38-01', 'act-psi-3i-semilla-38', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-39', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-39-01', 'act-psi-3i-semilla-39', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-40', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-40-01', 'act-psi-3i-semilla-40', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-41', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-41-01', 'act-psi-3i-semilla-41', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-42', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-42-01', 'act-psi-3i-semilla-42', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-43', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-43-01', 'act-psi-3i-semilla-43', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-44', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-44-01', 'act-psi-3i-semilla-44', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-45', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-45-01', 'act-psi-3i-semilla-45', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-46', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-46-01', 'act-psi-3i-semilla-46', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-47', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-47-01', 'act-psi-3i-semilla-47', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-48', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-48-01', 'act-psi-3i-semilla-48', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-49', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-49-01', 'act-psi-3i-semilla-49', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-semilla-50', 'les-psi-3i-semilla', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-semilla-50-01', 'act-psi-3i-semilla-50', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'explorador', '🔎 Explorador Curioso - Psicomotriz Inicial 3 años', 'equilibrio simple', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-01', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-01-01', 'act-psi-3i-explorador-01', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-02', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-02-01', 'act-psi-3i-explorador-02', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-03', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-03-01', 'act-psi-3i-explorador-03', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-04', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-04-01', 'act-psi-3i-explorador-04', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-05', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-05-01', 'act-psi-3i-explorador-05', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-06', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-06-01', 'act-psi-3i-explorador-06', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-07', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-07-01', 'act-psi-3i-explorador-07', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-08', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-08-01', 'act-psi-3i-explorador-08', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-09', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-09-01', 'act-psi-3i-explorador-09', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-10', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-10-01', 'act-psi-3i-explorador-10', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-11', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-11-01', 'act-psi-3i-explorador-11', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-12', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-12-01', 'act-psi-3i-explorador-12', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-13', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-13-01', 'act-psi-3i-explorador-13', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-14', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-14-01', 'act-psi-3i-explorador-14', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-15', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-15-01', 'act-psi-3i-explorador-15', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-16', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-16-01', 'act-psi-3i-explorador-16', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-17', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-17-01', 'act-psi-3i-explorador-17', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-18', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-18-01', 'act-psi-3i-explorador-18', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-19', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-19-01', 'act-psi-3i-explorador-19', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-20', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-20-01', 'act-psi-3i-explorador-20', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-21', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-21-01', 'act-psi-3i-explorador-21', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-22', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-22-01', 'act-psi-3i-explorador-22', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-23', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-23-01', 'act-psi-3i-explorador-23', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-24', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-24-01', 'act-psi-3i-explorador-24', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-25', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-25-01', 'act-psi-3i-explorador-25', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-26', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-26-01', 'act-psi-3i-explorador-26', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-27', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-27-01', 'act-psi-3i-explorador-27', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-28', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-28-01', 'act-psi-3i-explorador-28', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-29', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-29-01', 'act-psi-3i-explorador-29', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-30', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-30-01', 'act-psi-3i-explorador-30', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-31', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-31-01', 'act-psi-3i-explorador-31', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-32', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-32-01', 'act-psi-3i-explorador-32', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-33', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-33-01', 'act-psi-3i-explorador-33', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-34', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-34-01', 'act-psi-3i-explorador-34', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-35', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-35-01', 'act-psi-3i-explorador-35', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-36', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-36-01', 'act-psi-3i-explorador-36', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-37', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-37-01', 'act-psi-3i-explorador-37', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-38', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-38-01', 'act-psi-3i-explorador-38', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-39', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-39-01', 'act-psi-3i-explorador-39', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-40', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-40-01', 'act-psi-3i-explorador-40', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-41', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-41-01', 'act-psi-3i-explorador-41', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-42', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-42-01', 'act-psi-3i-explorador-42', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-43', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-43-01', 'act-psi-3i-explorador-43', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-44', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-44-01', 'act-psi-3i-explorador-44', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-45', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-45-01', 'act-psi-3i-explorador-45', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-46', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-46-01', 'act-psi-3i-explorador-46', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-47', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-47-01', 'act-psi-3i-explorador-47', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-48', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-48-01', 'act-psi-3i-explorador-48', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-49', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-49-01', 'act-psi-3i-explorador-49', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-explorador-50', 'les-psi-3i-explorador', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-explorador-50-01', 'act-psi-3i-explorador-50', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'aventurero', '🧭 Aventurero Ágil - Psicomotriz Inicial 3 años', 'movimiento con música', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-01', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-01-01', 'act-psi-3i-aventurero-01', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-02', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-02-01', 'act-psi-3i-aventurero-02', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-03', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-03-01', 'act-psi-3i-aventurero-03', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-04', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-04-01', 'act-psi-3i-aventurero-04', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-05', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-05-01', 'act-psi-3i-aventurero-05', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-06', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-06-01', 'act-psi-3i-aventurero-06', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-07', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-07-01', 'act-psi-3i-aventurero-07', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-08', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-08-01', 'act-psi-3i-aventurero-08', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-09', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-09-01', 'act-psi-3i-aventurero-09', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-10', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-10-01', 'act-psi-3i-aventurero-10', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-11', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-11-01', 'act-psi-3i-aventurero-11', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-12', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-12-01', 'act-psi-3i-aventurero-12', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-13', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-13-01', 'act-psi-3i-aventurero-13', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-14', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-14-01', 'act-psi-3i-aventurero-14', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-15', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-15-01', 'act-psi-3i-aventurero-15', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-16', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-16-01', 'act-psi-3i-aventurero-16', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-17', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-17-01', 'act-psi-3i-aventurero-17', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-18', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-18-01', 'act-psi-3i-aventurero-18', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-19', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-19-01', 'act-psi-3i-aventurero-19', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-20', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-20-01', 'act-psi-3i-aventurero-20', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-21', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-21-01', 'act-psi-3i-aventurero-21', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-22', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-22-01', 'act-psi-3i-aventurero-22', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-23', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-23-01', 'act-psi-3i-aventurero-23', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-24', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-24-01', 'act-psi-3i-aventurero-24', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-25', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-25-01', 'act-psi-3i-aventurero-25', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-26', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-26-01', 'act-psi-3i-aventurero-26', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-27', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-27-01', 'act-psi-3i-aventurero-27', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-28', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-28-01', 'act-psi-3i-aventurero-28', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-29', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-29-01', 'act-psi-3i-aventurero-29', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-30', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-30-01', 'act-psi-3i-aventurero-30', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-31', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-31-01', 'act-psi-3i-aventurero-31', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-32', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-32-01', 'act-psi-3i-aventurero-32', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-33', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-33-01', 'act-psi-3i-aventurero-33', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-34', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-34-01', 'act-psi-3i-aventurero-34', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-35', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-35-01', 'act-psi-3i-aventurero-35', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-36', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-36-01', 'act-psi-3i-aventurero-36', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-37', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-37-01', 'act-psi-3i-aventurero-37', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-38', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-38-01', 'act-psi-3i-aventurero-38', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-39', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-39-01', 'act-psi-3i-aventurero-39', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-40', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-40-01', 'act-psi-3i-aventurero-40', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-41', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-41-01', 'act-psi-3i-aventurero-41', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-42', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-42-01', 'act-psi-3i-aventurero-42', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-43', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-43-01', 'act-psi-3i-aventurero-43', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-44', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-44-01', 'act-psi-3i-aventurero-44', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-45', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-45-01', 'act-psi-3i-aventurero-45', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-46', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-46-01', 'act-psi-3i-aventurero-46', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-47', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-47-01', 'act-psi-3i-aventurero-47', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-48', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-48-01', 'act-psi-3i-aventurero-48', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-49', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-49-01', 'act-psi-3i-aventurero-49', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-aventurero-50', 'les-psi-3i-aventurero', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-aventurero-50-01', 'act-psi-3i-aventurero-50', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'estrella', '⭐ Estrella Brillante - Psicomotriz Inicial 3 años', 'coordinación mano-ojo', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-01', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-01-01', 'act-psi-3i-estrella-01', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-02', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-02-01', 'act-psi-3i-estrella-02', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-03', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-03-01', 'act-psi-3i-estrella-03', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-04', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-04-01', 'act-psi-3i-estrella-04', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-05', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-05-01', 'act-psi-3i-estrella-05', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-06', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-06-01', 'act-psi-3i-estrella-06', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-07', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-07-01', 'act-psi-3i-estrella-07', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-08', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-08-01', 'act-psi-3i-estrella-08', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-09', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-09-01', 'act-psi-3i-estrella-09', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-10', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-10-01', 'act-psi-3i-estrella-10', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-11', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-11-01', 'act-psi-3i-estrella-11', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-12', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-12-01', 'act-psi-3i-estrella-12', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-13', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-13-01', 'act-psi-3i-estrella-13', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-14', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-14-01', 'act-psi-3i-estrella-14', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-15', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-15-01', 'act-psi-3i-estrella-15', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-16', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-16-01', 'act-psi-3i-estrella-16', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-17', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-17-01', 'act-psi-3i-estrella-17', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-18', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-18-01', 'act-psi-3i-estrella-18', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-19', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-19-01', 'act-psi-3i-estrella-19', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-20', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-20-01', 'act-psi-3i-estrella-20', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-21', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-21-01', 'act-psi-3i-estrella-21', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-22', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-22-01', 'act-psi-3i-estrella-22', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-23', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-23-01', 'act-psi-3i-estrella-23', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-24', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-24-01', 'act-psi-3i-estrella-24', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-25', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-25-01', 'act-psi-3i-estrella-25', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-26', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-26-01', 'act-psi-3i-estrella-26', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-27', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-27-01', 'act-psi-3i-estrella-27', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-28', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-28-01', 'act-psi-3i-estrella-28', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-29', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-29-01', 'act-psi-3i-estrella-29', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-30', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-30-01', 'act-psi-3i-estrella-30', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-31', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-31-01', 'act-psi-3i-estrella-31', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-32', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-32-01', 'act-psi-3i-estrella-32', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-33', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-33-01', 'act-psi-3i-estrella-33', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-34', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-34-01', 'act-psi-3i-estrella-34', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-35', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-35-01', 'act-psi-3i-estrella-35', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-36', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-36-01', 'act-psi-3i-estrella-36', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-37', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-37-01', 'act-psi-3i-estrella-37', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-38', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-38-01', 'act-psi-3i-estrella-38', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-39', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-39-01', 'act-psi-3i-estrella-39', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-40', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-40-01', 'act-psi-3i-estrella-40', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-41', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-41-01', 'act-psi-3i-estrella-41', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-42', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-42-01', 'act-psi-3i-estrella-42', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-43', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-43-01', 'act-psi-3i-estrella-43', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-44', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-44-01', 'act-psi-3i-estrella-44', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-45', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-45-01', 'act-psi-3i-estrella-45', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-46', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-46-01', 'act-psi-3i-estrella-46', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-47', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-47-01', 'act-psi-3i-estrella-47', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-48', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-48-01', 'act-psi-3i-estrella-48', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-49', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-49-01', 'act-psi-3i-estrella-49', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-estrella-50', 'les-psi-3i-estrella', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-estrella-50-01', 'act-psi-3i-estrella-50', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'maestro', '🏆 Maestro Genio - Psicomotriz Inicial 3 años', 'relajación corporal', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-01', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 01', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-01-01', 'act-psi-3i-maestro-01', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-02', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 02', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-02-01', 'act-psi-3i-maestro-02', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-03', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 03', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-03-01', 'act-psi-3i-maestro-03', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-04', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 04', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-04-01', 'act-psi-3i-maestro-04', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-05', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 05', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-05-01', 'act-psi-3i-maestro-05', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-06', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 06', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-06-01', 'act-psi-3i-maestro-06', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-07', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 07', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-07-01', 'act-psi-3i-maestro-07', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-08', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 08', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-08-01', 'act-psi-3i-maestro-08', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-09', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 09', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-09-01', 'act-psi-3i-maestro-09', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-10', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 10', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-10-01', 'act-psi-3i-maestro-10', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-11', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 11', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-11-01', 'act-psi-3i-maestro-11', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-12', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 12', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-12-01', 'act-psi-3i-maestro-12', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-13', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 13', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-13-01', 'act-psi-3i-maestro-13', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-14', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 14', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-14-01', 'act-psi-3i-maestro-14', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-15', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 15', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-15-01', 'act-psi-3i-maestro-15', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-16', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 16', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-16-01', 'act-psi-3i-maestro-16', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-17', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 17', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-17-01', 'act-psi-3i-maestro-17', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-18', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 18', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-18-01', 'act-psi-3i-maestro-18', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-19', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 19', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-19-01', 'act-psi-3i-maestro-19', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-20', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 20', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-20-01', 'act-psi-3i-maestro-20', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-21', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 21', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-21-01', 'act-psi-3i-maestro-21', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-22', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 22', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-22-01', 'act-psi-3i-maestro-22', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-23', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 23', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-23-01', 'act-psi-3i-maestro-23', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-24', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 24', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-24-01', 'act-psi-3i-maestro-24', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-25', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 25', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-25-01', 'act-psi-3i-maestro-25', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-26', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 26', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-26-01', 'act-psi-3i-maestro-26', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-27', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 27', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-27-01', 'act-psi-3i-maestro-27', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-28', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 28', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-28-01', 'act-psi-3i-maestro-28', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-29', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 29', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-29-01', 'act-psi-3i-maestro-29', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-30', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 30', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-30-01', 'act-psi-3i-maestro-30', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-31', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 31', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-31-01', 'act-psi-3i-maestro-31', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-32', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 32', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-32-01', 'act-psi-3i-maestro-32', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-33', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 33', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-33-01', 'act-psi-3i-maestro-33', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-34', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 34', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-34-01', 'act-psi-3i-maestro-34', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-35', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 35', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-35-01', 'act-psi-3i-maestro-35', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-36', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 36', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-36-01', 'act-psi-3i-maestro-36', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "empujar", "value": "empujar"}, {"id": "b", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "c", "label": "cerrar los ojos", "value": "cerrar los ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-37', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 37', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-37-01', 'act-psi-3i-maestro-37', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "despacio", "value": "despacio"}, {"id": "b", "label": "gritando", "value": "gritando"}, {"id": "c", "label": "dormido", "value": "dormido"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-38', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 38', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-38-01', 'act-psi-3i-maestro-38', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "rodillas", "value": "rodillas"}, {"id": "b", "label": "cejas", "value": "cejas"}, {"id": "c", "label": "manos", "value": "manos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-39', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 39', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-39-01', 'act-psi-3i-maestro-39', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "respirar lento", "value": "respirar lento"}, {"id": "c", "label": "correr más", "value": "correr más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-40', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 40', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-40-01', 'act-psi-3i-maestro-40', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "pies", "value": "pies"}, {"id": "b", "label": "ojos", "value": "ojos"}, {"id": "c", "label": "orejas", "value": "orejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-41', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 41', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-41-01', 'act-psi-3i-maestro-41', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "b", "label": "empujar", "value": "empujar"}, {"id": "c", "label": "mirar el camino", "value": "mirar el camino"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-42', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 42', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-42-01', 'act-psi-3i-maestro-42', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "dormido", "value": "dormido"}, {"id": "b", "label": "despacio", "value": "despacio"}, {"id": "c", "label": "gritando", "value": "gritando"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-43', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 43', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-43-01', 'act-psi-3i-maestro-43', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "manos", "value": "manos"}, {"id": "b", "label": "rodillas", "value": "rodillas"}, {"id": "c", "label": "cejas", "value": "cejas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-44', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 44', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-44-01', 'act-psi-3i-maestro-44', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "correr más", "value": "correr más"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "respirar lento", "value": "respirar lento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-45', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 45', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-45-01', 'act-psi-3i-maestro-45', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "orejas", "value": "orejas"}, {"id": "b", "label": "pies", "value": "pies"}, {"id": "c", "label": "ojos", "value": "ojos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-46', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 46', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-46-01', 'act-psi-3i-maestro-46', 'Para no chocar al caminar por el aula, debes...', 'Cuida tu cuerpo y el de otros.', 'single-choice', 'mirar el camino', '[{"id": "a", "label": "mirar el camino", "value": "mirar el camino"}, {"id": "b", "label": "cerrar los ojos", "value": "cerrar los ojos"}, {"id": "c", "label": "empujar", "value": "empujar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-47', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 47', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-47-01', 'act-psi-3i-maestro-47', 'Cuando la música suena suave, puedes moverte...', 'Relaciona sonido y movimiento.', 'single-choice', 'despacio', '[{"id": "a", "label": "gritando", "value": "gritando"}, {"id": "b", "label": "dormido", "value": "dormido"}, {"id": "c", "label": "despacio", "value": "despacio"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-48', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 48', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-48-01', 'act-psi-3i-maestro-48', 'Para lanzar una pelota pequeña usas más las...', 'Observa qué parte coordina la acción.', 'single-choice', 'manos', '[{"id": "a", "label": "cejas", "value": "cejas"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "rodillas", "value": "rodillas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-49', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 49', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-49-01', 'act-psi-3i-maestro-49', 'Después de correr, ayuda a calmar el cuerpo...', 'Recupera la respiración.', 'single-choice', 'respirar lento', '[{"id": "a", "label": "respirar lento", "value": "respirar lento"}, {"id": "b", "label": "correr más", "value": "correr más"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-psi-3i-maestro-50', 'les-psi-3i-maestro', 'psicomotriz-inicial', '3-anios', 'Psicomotriz Inicial 3 años - Misión 50', 'Actividad lúdica de Psicomotriz para inicial 3 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-psi-3i-maestro-50-01', 'act-psi-3i-maestro-50', '¿Qué parte del cuerpo usas principalmente para saltar?', 'Piensa en el movimiento.', 'single-choice', 'pies', '[{"id": "a", "label": "ojos", "value": "ojos"}, {"id": "b", "label": "orejas", "value": "orejas"}, {"id": "c", "label": "pies", "value": "pies"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
