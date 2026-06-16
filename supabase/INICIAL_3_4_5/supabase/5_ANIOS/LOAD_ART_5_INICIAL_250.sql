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

-- GenioKids - Arte y creatividad Inicial 5 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'semilla', '🌱 Semilla Genial - Arte y creatividad Inicial 5 años', 'crear una obra', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-01', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 01', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-01-01', 'act-art-5i-semilla-01', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-02', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 02', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-02-01', 'act-art-5i-semilla-02', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-03', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 03', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-03-01', 'act-art-5i-semilla-03', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-04', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 04', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-04-01', 'act-art-5i-semilla-04', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-05', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 05', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-05-01', 'act-art-5i-semilla-05', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-06', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 06', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-06-01', 'act-art-5i-semilla-06', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-07', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 07', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-07-01', 'act-art-5i-semilla-07', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-08', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 08', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-08-01', 'act-art-5i-semilla-08', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-09', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 09', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-09-01', 'act-art-5i-semilla-09', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-10', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 10', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-10-01', 'act-art-5i-semilla-10', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-11', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 11', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-11-01', 'act-art-5i-semilla-11', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-12', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 12', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-12-01', 'act-art-5i-semilla-12', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-13', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 13', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-13-01', 'act-art-5i-semilla-13', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-14', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 14', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-14-01', 'act-art-5i-semilla-14', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-15', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 15', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-15-01', 'act-art-5i-semilla-15', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-16', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 16', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-16-01', 'act-art-5i-semilla-16', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-17', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 17', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-17-01', 'act-art-5i-semilla-17', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-18', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 18', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-18-01', 'act-art-5i-semilla-18', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-19', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 19', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-19-01', 'act-art-5i-semilla-19', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-20', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 20', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-20-01', 'act-art-5i-semilla-20', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-21', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 21', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-21-01', 'act-art-5i-semilla-21', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-22', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 22', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-22-01', 'act-art-5i-semilla-22', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-23', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 23', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-23-01', 'act-art-5i-semilla-23', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-24', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 24', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-24-01', 'act-art-5i-semilla-24', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-25', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 25', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-25-01', 'act-art-5i-semilla-25', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-26', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 26', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-26-01', 'act-art-5i-semilla-26', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-27', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 27', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-27-01', 'act-art-5i-semilla-27', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-28', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 28', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-28-01', 'act-art-5i-semilla-28', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-29', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 29', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-29-01', 'act-art-5i-semilla-29', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-30', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 30', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-30-01', 'act-art-5i-semilla-30', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-31', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 31', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-31-01', 'act-art-5i-semilla-31', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-32', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 32', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-32-01', 'act-art-5i-semilla-32', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-33', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 33', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-33-01', 'act-art-5i-semilla-33', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-34', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 34', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-34-01', 'act-art-5i-semilla-34', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-35', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 35', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-35-01', 'act-art-5i-semilla-35', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-36', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 36', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-36-01', 'act-art-5i-semilla-36', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-37', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 37', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-37-01', 'act-art-5i-semilla-37', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-38', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 38', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-38-01', 'act-art-5i-semilla-38', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-39', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 39', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-39-01', 'act-art-5i-semilla-39', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-40', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 40', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-40-01', 'act-art-5i-semilla-40', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-41', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 41', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-41-01', 'act-art-5i-semilla-41', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-42', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 42', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-42-01', 'act-art-5i-semilla-42', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-43', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 43', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-43-01', 'act-art-5i-semilla-43', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-44', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 44', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-44-01', 'act-art-5i-semilla-44', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-45', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 45', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-45-01', 'act-art-5i-semilla-45', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-46', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 46', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-46-01', 'act-art-5i-semilla-46', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-47', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 47', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-47-01', 'act-art-5i-semilla-47', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-48', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 48', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-48-01', 'act-art-5i-semilla-48', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-49', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 49', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-49-01', 'act-art-5i-semilla-49', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-semilla-50', 'les-art-5i-semilla', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 50', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-semilla-50-01', 'act-art-5i-semilla-50', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'explorador', '🔎 Explorador Curioso - Arte y creatividad Inicial 5 años', 'dramatizar historias', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-01', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 01', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-01-01', 'act-art-5i-explorador-01', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-02', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 02', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-02-01', 'act-art-5i-explorador-02', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-03', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 03', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-03-01', 'act-art-5i-explorador-03', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-04', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 04', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-04-01', 'act-art-5i-explorador-04', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-05', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 05', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-05-01', 'act-art-5i-explorador-05', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-06', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 06', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-06-01', 'act-art-5i-explorador-06', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-07', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 07', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-07-01', 'act-art-5i-explorador-07', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-08', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 08', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-08-01', 'act-art-5i-explorador-08', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-09', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 09', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-09-01', 'act-art-5i-explorador-09', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-10', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 10', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-10-01', 'act-art-5i-explorador-10', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-11', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 11', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-11-01', 'act-art-5i-explorador-11', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-12', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 12', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-12-01', 'act-art-5i-explorador-12', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-13', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 13', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-13-01', 'act-art-5i-explorador-13', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-14', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 14', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-14-01', 'act-art-5i-explorador-14', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-15', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 15', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-15-01', 'act-art-5i-explorador-15', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-16', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 16', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-16-01', 'act-art-5i-explorador-16', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-17', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 17', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-17-01', 'act-art-5i-explorador-17', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-18', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 18', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-18-01', 'act-art-5i-explorador-18', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-19', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 19', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-19-01', 'act-art-5i-explorador-19', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-20', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 20', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-20-01', 'act-art-5i-explorador-20', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-21', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 21', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-21-01', 'act-art-5i-explorador-21', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-22', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 22', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-22-01', 'act-art-5i-explorador-22', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-23', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 23', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-23-01', 'act-art-5i-explorador-23', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-24', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 24', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-24-01', 'act-art-5i-explorador-24', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-25', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 25', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-25-01', 'act-art-5i-explorador-25', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-26', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 26', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-26-01', 'act-art-5i-explorador-26', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-27', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 27', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-27-01', 'act-art-5i-explorador-27', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-28', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 28', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-28-01', 'act-art-5i-explorador-28', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-29', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 29', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-29-01', 'act-art-5i-explorador-29', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-30', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 30', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-30-01', 'act-art-5i-explorador-30', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-31', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 31', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-31-01', 'act-art-5i-explorador-31', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-32', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 32', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-32-01', 'act-art-5i-explorador-32', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-33', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 33', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-33-01', 'act-art-5i-explorador-33', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-34', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 34', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-34-01', 'act-art-5i-explorador-34', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-35', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 35', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-35-01', 'act-art-5i-explorador-35', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-36', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 36', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-36-01', 'act-art-5i-explorador-36', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-37', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 37', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-37-01', 'act-art-5i-explorador-37', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-38', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 38', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-38-01', 'act-art-5i-explorador-38', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-39', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 39', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-39-01', 'act-art-5i-explorador-39', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-40', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 40', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-40-01', 'act-art-5i-explorador-40', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-41', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 41', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-41-01', 'act-art-5i-explorador-41', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-42', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 42', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-42-01', 'act-art-5i-explorador-42', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-43', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 43', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-43-01', 'act-art-5i-explorador-43', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-44', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 44', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-44-01', 'act-art-5i-explorador-44', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-45', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 45', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-45-01', 'act-art-5i-explorador-45', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-46', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 46', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-46-01', 'act-art-5i-explorador-46', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-47', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 47', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-47-01', 'act-art-5i-explorador-47', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-48', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 48', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-48-01', 'act-art-5i-explorador-48', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-49', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 49', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-49-01', 'act-art-5i-explorador-49', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-explorador-50', 'les-art-5i-explorador', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 50', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-explorador-50-01', 'act-art-5i-explorador-50', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'aventurero', '🧭 Aventurero Ágil - Arte y creatividad Inicial 5 años', 'patrones con colores', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-01', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 01', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-01-01', 'act-art-5i-aventurero-01', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-02', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 02', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-02-01', 'act-art-5i-aventurero-02', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-03', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 03', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-03-01', 'act-art-5i-aventurero-03', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-04', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 04', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-04-01', 'act-art-5i-aventurero-04', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-05', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 05', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-05-01', 'act-art-5i-aventurero-05', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-06', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 06', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-06-01', 'act-art-5i-aventurero-06', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-07', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 07', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-07-01', 'act-art-5i-aventurero-07', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-08', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 08', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-08-01', 'act-art-5i-aventurero-08', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-09', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 09', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-09-01', 'act-art-5i-aventurero-09', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-10', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 10', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-10-01', 'act-art-5i-aventurero-10', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-11', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 11', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-11-01', 'act-art-5i-aventurero-11', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-12', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 12', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-12-01', 'act-art-5i-aventurero-12', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-13', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 13', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-13-01', 'act-art-5i-aventurero-13', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-14', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 14', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-14-01', 'act-art-5i-aventurero-14', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-15', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 15', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-15-01', 'act-art-5i-aventurero-15', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-16', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 16', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-16-01', 'act-art-5i-aventurero-16', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-17', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 17', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-17-01', 'act-art-5i-aventurero-17', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-18', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 18', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-18-01', 'act-art-5i-aventurero-18', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-19', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 19', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-19-01', 'act-art-5i-aventurero-19', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-20', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 20', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-20-01', 'act-art-5i-aventurero-20', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-21', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 21', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-21-01', 'act-art-5i-aventurero-21', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-22', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 22', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-22-01', 'act-art-5i-aventurero-22', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-23', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 23', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-23-01', 'act-art-5i-aventurero-23', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-24', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 24', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-24-01', 'act-art-5i-aventurero-24', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-25', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 25', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-25-01', 'act-art-5i-aventurero-25', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-26', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 26', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-26-01', 'act-art-5i-aventurero-26', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-27', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 27', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-27-01', 'act-art-5i-aventurero-27', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-28', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 28', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-28-01', 'act-art-5i-aventurero-28', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-29', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 29', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-29-01', 'act-art-5i-aventurero-29', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-30', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 30', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-30-01', 'act-art-5i-aventurero-30', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-31', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 31', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-31-01', 'act-art-5i-aventurero-31', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-32', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 32', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-32-01', 'act-art-5i-aventurero-32', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-33', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 33', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-33-01', 'act-art-5i-aventurero-33', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-34', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 34', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-34-01', 'act-art-5i-aventurero-34', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-35', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 35', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-35-01', 'act-art-5i-aventurero-35', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-36', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 36', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-36-01', 'act-art-5i-aventurero-36', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-37', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 37', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-37-01', 'act-art-5i-aventurero-37', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-38', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 38', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-38-01', 'act-art-5i-aventurero-38', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-39', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 39', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-39-01', 'act-art-5i-aventurero-39', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-40', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 40', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-40-01', 'act-art-5i-aventurero-40', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-41', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 41', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-41-01', 'act-art-5i-aventurero-41', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-42', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 42', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-42-01', 'act-art-5i-aventurero-42', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-43', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 43', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-43-01', 'act-art-5i-aventurero-43', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-44', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 44', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-44-01', 'act-art-5i-aventurero-44', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-45', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 45', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-45-01', 'act-art-5i-aventurero-45', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-46', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 46', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-46-01', 'act-art-5i-aventurero-46', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-47', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 47', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-47-01', 'act-art-5i-aventurero-47', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-48', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 48', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-48-01', 'act-art-5i-aventurero-48', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-49', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 49', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-49-01', 'act-art-5i-aventurero-49', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-aventurero-50', 'les-art-5i-aventurero', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 50', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-aventurero-50-01', 'act-art-5i-aventurero-50', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'estrella', '⭐ Estrella Brillante - Arte y creatividad Inicial 5 años', 'música y movimiento', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-01', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 01', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-01-01', 'act-art-5i-estrella-01', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-02', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 02', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-02-01', 'act-art-5i-estrella-02', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-03', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 03', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-03-01', 'act-art-5i-estrella-03', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-04', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 04', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-04-01', 'act-art-5i-estrella-04', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-05', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 05', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-05-01', 'act-art-5i-estrella-05', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-06', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 06', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-06-01', 'act-art-5i-estrella-06', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-07', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 07', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-07-01', 'act-art-5i-estrella-07', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-08', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 08', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-08-01', 'act-art-5i-estrella-08', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-09', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 09', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-09-01', 'act-art-5i-estrella-09', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-10', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 10', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-10-01', 'act-art-5i-estrella-10', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-11', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 11', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-11-01', 'act-art-5i-estrella-11', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-12', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 12', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-12-01', 'act-art-5i-estrella-12', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-13', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 13', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-13-01', 'act-art-5i-estrella-13', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-14', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 14', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-14-01', 'act-art-5i-estrella-14', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-15', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 15', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-15-01', 'act-art-5i-estrella-15', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-16', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 16', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-16-01', 'act-art-5i-estrella-16', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-17', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 17', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-17-01', 'act-art-5i-estrella-17', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-18', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 18', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-18-01', 'act-art-5i-estrella-18', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-19', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 19', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-19-01', 'act-art-5i-estrella-19', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-20', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 20', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-20-01', 'act-art-5i-estrella-20', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-21', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 21', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-21-01', 'act-art-5i-estrella-21', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-22', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 22', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-22-01', 'act-art-5i-estrella-22', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-23', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 23', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-23-01', 'act-art-5i-estrella-23', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-24', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 24', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-24-01', 'act-art-5i-estrella-24', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-25', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 25', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-25-01', 'act-art-5i-estrella-25', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-26', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 26', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-26-01', 'act-art-5i-estrella-26', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-27', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 27', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-27-01', 'act-art-5i-estrella-27', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-28', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 28', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-28-01', 'act-art-5i-estrella-28', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-29', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 29', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-29-01', 'act-art-5i-estrella-29', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-30', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 30', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-30-01', 'act-art-5i-estrella-30', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-31', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 31', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-31-01', 'act-art-5i-estrella-31', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-32', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 32', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-32-01', 'act-art-5i-estrella-32', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-33', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 33', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-33-01', 'act-art-5i-estrella-33', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-34', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 34', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-34-01', 'act-art-5i-estrella-34', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-35', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 35', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-35-01', 'act-art-5i-estrella-35', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-36', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 36', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-36-01', 'act-art-5i-estrella-36', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-37', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 37', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-37-01', 'act-art-5i-estrella-37', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-38', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 38', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-38-01', 'act-art-5i-estrella-38', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-39', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 39', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-39-01', 'act-art-5i-estrella-39', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-40', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 40', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-40-01', 'act-art-5i-estrella-40', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-41', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 41', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-41-01', 'act-art-5i-estrella-41', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-42', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 42', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-42-01', 'act-art-5i-estrella-42', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-43', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 43', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-43-01', 'act-art-5i-estrella-43', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-44', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 44', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-44-01', 'act-art-5i-estrella-44', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-45', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 45', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-45-01', 'act-art-5i-estrella-45', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-46', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 46', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-46-01', 'act-art-5i-estrella-46', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-47', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 47', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-47-01', 'act-art-5i-estrella-47', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-48', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 48', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-48-01', 'act-art-5i-estrella-48', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-49', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 49', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-49-01', 'act-art-5i-estrella-49', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-estrella-50', 'les-art-5i-estrella', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 50', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-estrella-50-01', 'act-art-5i-estrella-50', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'maestro', '🏆 Maestro Genio - Arte y creatividad Inicial 5 años', 'explicar su creación', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-01', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 01', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-01-01', 'act-art-5i-maestro-01', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-02', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 02', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-02-01', 'act-art-5i-maestro-02', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-03', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 03', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-03-01', 'act-art-5i-maestro-03', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-04', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 04', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-04-01', 'act-art-5i-maestro-04', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-05', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 05', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-05-01', 'act-art-5i-maestro-05', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-06', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 06', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-06-01', 'act-art-5i-maestro-06', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-07', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 07', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-07-01', 'act-art-5i-maestro-07', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-08', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 08', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-08-01', 'act-art-5i-maestro-08', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-09', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 09', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-09-01', 'act-art-5i-maestro-09', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-10', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 10', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-10-01', 'act-art-5i-maestro-10', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-11', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 11', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-11-01', 'act-art-5i-maestro-11', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-12', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 12', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-12-01', 'act-art-5i-maestro-12', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-13', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 13', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-13-01', 'act-art-5i-maestro-13', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-14', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 14', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-14-01', 'act-art-5i-maestro-14', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-15', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 15', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-15-01', 'act-art-5i-maestro-15', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-16', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 16', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-16-01', 'act-art-5i-maestro-16', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-17', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 17', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-17-01', 'act-art-5i-maestro-17', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-18', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 18', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-18-01', 'act-art-5i-maestro-18', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-19', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 19', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-19-01', 'act-art-5i-maestro-19', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-20', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 20', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-20-01', 'act-art-5i-maestro-20', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-21', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 21', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-21-01', 'act-art-5i-maestro-21', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-22', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 22', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-22-01', 'act-art-5i-maestro-22', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-23', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 23', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-23-01', 'act-art-5i-maestro-23', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-24', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 24', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-24-01', 'act-art-5i-maestro-24', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-25', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 25', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-25-01', 'act-art-5i-maestro-25', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-26', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 26', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-26-01', 'act-art-5i-maestro-26', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-27', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 27', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-27-01', 'act-art-5i-maestro-27', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-28', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 28', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-28-01', 'act-art-5i-maestro-28', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-29', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 29', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-29-01', 'act-art-5i-maestro-29', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-30', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 30', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-30-01', 'act-art-5i-maestro-30', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-31', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 31', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-31-01', 'act-art-5i-maestro-31', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-32', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 32', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-32-01', 'act-art-5i-maestro-32', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-33', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 33', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-33-01', 'act-art-5i-maestro-33', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-34', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 34', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-34-01', 'act-art-5i-maestro-34', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-35', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 35', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-35-01', 'act-art-5i-maestro-35', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-36', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 36', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-36-01', 'act-art-5i-maestro-36', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dormir", "value": "dormir"}, {"id": "b", "label": "dramatizar", "value": "dramatizar"}, {"id": "c", "label": "sumar", "value": "sumar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-37', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 37', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-37-01', 'act-art-5i-maestro-37', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "patrón", "value": "patrón"}, {"id": "b", "label": "cuento", "value": "cuento"}, {"id": "c", "label": "animal", "value": "animal"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-38', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 38', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-38-01', 'act-art-5i-maestro-38', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "tamaños", "value": "tamaños"}, {"id": "b", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "c", "label": "emociones", "value": "emociones"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-39', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 39', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-39-01', 'act-art-5i-maestro-39', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "b", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "c", "label": "qué escondiste", "value": "qué escondiste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-40', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 40', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-40-01', 'act-art-5i-maestro-40', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "expresar", "value": "expresar"}, {"id": "b", "label": "esconder", "value": "esconder"}, {"id": "c", "label": "ensuciar", "value": "ensuciar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-41', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 41', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-41-01', 'act-art-5i-maestro-41', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "sumar", "value": "sumar"}, {"id": "b", "label": "dormir", "value": "dormir"}, {"id": "c", "label": "dramatizar", "value": "dramatizar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-42', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 42', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-42-01', 'act-art-5i-maestro-42', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "animal", "value": "animal"}, {"id": "b", "label": "patrón", "value": "patrón"}, {"id": "c", "label": "cuento", "value": "cuento"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-43', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 43', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-43-01', 'act-art-5i-maestro-43', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "emociones", "value": "emociones"}, {"id": "b", "label": "tamaños", "value": "tamaños"}, {"id": "c", "label": "direcciones escritas", "value": "direcciones escritas"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-44', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 44', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-44-01', 'act-art-5i-maestro-44', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "b", "label": "por qué gritaste", "value": "por qué gritaste"}, {"id": "c", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-45', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 45', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-45-01', 'act-art-5i-maestro-45', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "ensuciar", "value": "ensuciar"}, {"id": "b", "label": "expresar", "value": "expresar"}, {"id": "c", "label": "esconder", "value": "esconder"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-46', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 46', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-46-01', 'act-art-5i-maestro-46', 'Representar un cuento con gestos y voz es...', 'Une comunicación y arte.', 'single-choice', 'dramatizar', '[{"id": "a", "label": "dramatizar", "value": "dramatizar"}, {"id": "b", "label": "sumar", "value": "sumar"}, {"id": "c", "label": "dormir", "value": "dormir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-47', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 47', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-47-01', 'act-art-5i-maestro-47', 'Rojo, azul, rojo, azul en una pulsera forma un...', 'Reconoce repetición visual.', 'single-choice', 'patrón', '[{"id": "a", "label": "cuento", "value": "cuento"}, {"id": "b", "label": "animal", "value": "animal"}, {"id": "c", "label": "patrón", "value": "patrón"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-48', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 48', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-48-01', 'act-art-5i-maestro-48', 'Moverse siguiendo música rápida y lenta permite expresar...', 'Usa cuerpo y música.', 'single-choice', 'emociones', '[{"id": "a", "label": "direcciones escritas", "value": "direcciones escritas"}, {"id": "b", "label": "emociones", "value": "emociones"}, {"id": "c", "label": "tamaños", "value": "tamaños"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-49', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 49', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-49-01', 'act-art-5i-maestro-49', 'Después de terminar tu dibujo, puedes contar...', 'Comunica tu proceso creativo.', 'single-choice', 'cómo lo hiciste', '[{"id": "a", "label": "cómo lo hiciste", "value": "cómo lo hiciste"}, {"id": "b", "label": "qué escondiste", "value": "qué escondiste"}, {"id": "c", "label": "por qué gritaste", "value": "por qué gritaste"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-art-5i-maestro-50', 'les-art-5i-maestro', 'arte-creatividad-inicial', '5-anios', 'Arte y creatividad Inicial 5 años - Misión 50', 'Actividad lúdica de Arte y creatividad para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-art-5i-maestro-50-01', 'act-art-5i-maestro-50', 'Antes de crear una obra, puedes pensar qué quieres...', 'Planifica tu creación.', 'single-choice', 'expresar', '[{"id": "a", "label": "esconder", "value": "esconder"}, {"id": "b", "label": "ensuciar", "value": "ensuciar"}, {"id": "c", "label": "expresar", "value": "expresar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
