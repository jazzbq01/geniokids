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

-- GenioKids - Comunicación Inicial 5 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-com-5i-semilla', 'com-inicial', '5-anios', 'semilla', '🌱 Semilla Genial - Comunicación Inicial 5 años', 'comprensión de cuentos', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-01', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 01', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-01-01', 'act-com-5i-semilla-01', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-02', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 02', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-02-01', 'act-com-5i-semilla-02', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-03', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 03', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-03-01', 'act-com-5i-semilla-03', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-04', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 04', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-04-01', 'act-com-5i-semilla-04', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-05', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 05', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-05-01', 'act-com-5i-semilla-05', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-06', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 06', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-06-01', 'act-com-5i-semilla-06', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-07', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 07', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-07-01', 'act-com-5i-semilla-07', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-08', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 08', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-08-01', 'act-com-5i-semilla-08', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-09', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 09', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-09-01', 'act-com-5i-semilla-09', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-10', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 10', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-10-01', 'act-com-5i-semilla-10', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-11', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 11', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-11-01', 'act-com-5i-semilla-11', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-12', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 12', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-12-01', 'act-com-5i-semilla-12', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-13', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 13', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-13-01', 'act-com-5i-semilla-13', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-14', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 14', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-14-01', 'act-com-5i-semilla-14', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-15', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 15', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-15-01', 'act-com-5i-semilla-15', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-16', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 16', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-16-01', 'act-com-5i-semilla-16', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-17', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 17', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-17-01', 'act-com-5i-semilla-17', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-18', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 18', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-18-01', 'act-com-5i-semilla-18', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-19', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 19', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-19-01', 'act-com-5i-semilla-19', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-20', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 20', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-20-01', 'act-com-5i-semilla-20', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-21', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 21', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-21-01', 'act-com-5i-semilla-21', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-22', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 22', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-22-01', 'act-com-5i-semilla-22', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-23', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 23', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-23-01', 'act-com-5i-semilla-23', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-24', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 24', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-24-01', 'act-com-5i-semilla-24', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-25', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 25', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-25-01', 'act-com-5i-semilla-25', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-26', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 26', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-26-01', 'act-com-5i-semilla-26', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-27', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 27', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-27-01', 'act-com-5i-semilla-27', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-28', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 28', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-28-01', 'act-com-5i-semilla-28', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-29', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 29', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-29-01', 'act-com-5i-semilla-29', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-30', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 30', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-30-01', 'act-com-5i-semilla-30', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-31', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 31', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-31-01', 'act-com-5i-semilla-31', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-32', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 32', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-32-01', 'act-com-5i-semilla-32', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-33', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 33', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-33-01', 'act-com-5i-semilla-33', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-34', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 34', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-34-01', 'act-com-5i-semilla-34', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-35', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 35', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-35-01', 'act-com-5i-semilla-35', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-36', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 36', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-36-01', 'act-com-5i-semilla-36', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-37', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 37', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-37-01', 'act-com-5i-semilla-37', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-38', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 38', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-38-01', 'act-com-5i-semilla-38', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-39', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 39', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-39-01', 'act-com-5i-semilla-39', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-40', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 40', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-40-01', 'act-com-5i-semilla-40', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-41', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 41', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-41-01', 'act-com-5i-semilla-41', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-42', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 42', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-42-01', 'act-com-5i-semilla-42', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-43', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 43', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-43-01', 'act-com-5i-semilla-43', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-44', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 44', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-44-01', 'act-com-5i-semilla-44', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-45', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 45', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-45-01', 'act-com-5i-semilla-45', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-46', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 46', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-46-01', 'act-com-5i-semilla-46', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-47', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 47', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-47-01', 'act-com-5i-semilla-47', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-48', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 48', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-48-01', 'act-com-5i-semilla-48', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-49', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 49', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-49-01', 'act-com-5i-semilla-49', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-semilla-50', 'les-com-5i-semilla', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 50', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-semilla-50-01', 'act-com-5i-semilla-50', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-com-5i-explorador', 'com-inicial', '5-anios', 'explorador', '🔎 Explorador Curioso - Comunicación Inicial 5 años', 'anticipar e inferir', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-01', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 01', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-01-01', 'act-com-5i-explorador-01', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-02', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 02', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-02-01', 'act-com-5i-explorador-02', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-03', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 03', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-03-01', 'act-com-5i-explorador-03', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-04', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 04', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-04-01', 'act-com-5i-explorador-04', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-05', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 05', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-05-01', 'act-com-5i-explorador-05', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-06', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 06', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-06-01', 'act-com-5i-explorador-06', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-07', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 07', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-07-01', 'act-com-5i-explorador-07', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-08', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 08', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-08-01', 'act-com-5i-explorador-08', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-09', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 09', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-09-01', 'act-com-5i-explorador-09', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-10', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 10', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-10-01', 'act-com-5i-explorador-10', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-11', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 11', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-11-01', 'act-com-5i-explorador-11', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-12', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 12', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-12-01', 'act-com-5i-explorador-12', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-13', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 13', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-13-01', 'act-com-5i-explorador-13', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-14', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 14', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-14-01', 'act-com-5i-explorador-14', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-15', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 15', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-15-01', 'act-com-5i-explorador-15', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-16', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 16', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-16-01', 'act-com-5i-explorador-16', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-17', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 17', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-17-01', 'act-com-5i-explorador-17', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-18', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 18', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-18-01', 'act-com-5i-explorador-18', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-19', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 19', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-19-01', 'act-com-5i-explorador-19', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-20', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 20', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-20-01', 'act-com-5i-explorador-20', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-21', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 21', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-21-01', 'act-com-5i-explorador-21', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-22', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 22', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-22-01', 'act-com-5i-explorador-22', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-23', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 23', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-23-01', 'act-com-5i-explorador-23', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-24', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 24', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-24-01', 'act-com-5i-explorador-24', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-25', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 25', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-25-01', 'act-com-5i-explorador-25', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-26', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 26', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-26-01', 'act-com-5i-explorador-26', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-27', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 27', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-27-01', 'act-com-5i-explorador-27', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-28', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 28', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-28-01', 'act-com-5i-explorador-28', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-29', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 29', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-29-01', 'act-com-5i-explorador-29', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-30', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 30', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-30-01', 'act-com-5i-explorador-30', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-31', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 31', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-31-01', 'act-com-5i-explorador-31', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-32', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 32', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-32-01', 'act-com-5i-explorador-32', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-33', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 33', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-33-01', 'act-com-5i-explorador-33', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-34', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 34', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-34-01', 'act-com-5i-explorador-34', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-35', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 35', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-35-01', 'act-com-5i-explorador-35', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-36', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 36', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-36-01', 'act-com-5i-explorador-36', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-37', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 37', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-37-01', 'act-com-5i-explorador-37', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-38', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 38', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-38-01', 'act-com-5i-explorador-38', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-39', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 39', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-39-01', 'act-com-5i-explorador-39', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-40', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 40', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-40-01', 'act-com-5i-explorador-40', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-41', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 41', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-41-01', 'act-com-5i-explorador-41', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-42', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 42', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-42-01', 'act-com-5i-explorador-42', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-43', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 43', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-43-01', 'act-com-5i-explorador-43', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-44', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 44', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-44-01', 'act-com-5i-explorador-44', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-45', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 45', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-45-01', 'act-com-5i-explorador-45', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-46', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 46', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-46-01', 'act-com-5i-explorador-46', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-47', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 47', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-47-01', 'act-com-5i-explorador-47', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-48', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 48', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-48-01', 'act-com-5i-explorador-48', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-49', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 49', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-49-01', 'act-com-5i-explorador-49', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-explorador-50', 'les-com-5i-explorador', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 50', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-explorador-50-01', 'act-com-5i-explorador-50', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-com-5i-aventurero', 'com-inicial', '5-anios', 'aventurero', '🧭 Aventurero Ágil - Comunicación Inicial 5 años', 'secuencia inicio-nudo-final', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-01', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 01', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-01-01', 'act-com-5i-aventurero-01', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-02', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 02', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-02-01', 'act-com-5i-aventurero-02', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-03', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 03', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-03-01', 'act-com-5i-aventurero-03', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-04', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 04', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-04-01', 'act-com-5i-aventurero-04', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-05', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 05', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-05-01', 'act-com-5i-aventurero-05', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-06', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 06', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-06-01', 'act-com-5i-aventurero-06', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-07', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 07', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-07-01', 'act-com-5i-aventurero-07', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-08', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 08', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-08-01', 'act-com-5i-aventurero-08', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-09', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 09', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-09-01', 'act-com-5i-aventurero-09', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-10', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 10', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-10-01', 'act-com-5i-aventurero-10', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-11', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 11', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-11-01', 'act-com-5i-aventurero-11', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-12', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 12', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-12-01', 'act-com-5i-aventurero-12', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-13', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 13', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-13-01', 'act-com-5i-aventurero-13', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-14', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 14', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-14-01', 'act-com-5i-aventurero-14', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-15', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 15', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-15-01', 'act-com-5i-aventurero-15', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-16', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 16', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-16-01', 'act-com-5i-aventurero-16', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-17', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 17', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-17-01', 'act-com-5i-aventurero-17', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-18', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 18', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-18-01', 'act-com-5i-aventurero-18', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-19', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 19', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-19-01', 'act-com-5i-aventurero-19', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-20', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 20', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-20-01', 'act-com-5i-aventurero-20', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-21', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 21', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-21-01', 'act-com-5i-aventurero-21', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-22', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 22', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-22-01', 'act-com-5i-aventurero-22', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-23', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 23', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-23-01', 'act-com-5i-aventurero-23', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-24', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 24', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-24-01', 'act-com-5i-aventurero-24', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-25', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 25', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-25-01', 'act-com-5i-aventurero-25', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-26', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 26', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-26-01', 'act-com-5i-aventurero-26', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-27', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 27', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-27-01', 'act-com-5i-aventurero-27', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-28', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 28', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-28-01', 'act-com-5i-aventurero-28', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-29', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 29', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-29-01', 'act-com-5i-aventurero-29', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-30', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 30', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-30-01', 'act-com-5i-aventurero-30', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-31', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 31', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-31-01', 'act-com-5i-aventurero-31', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-32', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 32', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-32-01', 'act-com-5i-aventurero-32', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-33', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 33', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-33-01', 'act-com-5i-aventurero-33', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-34', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 34', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-34-01', 'act-com-5i-aventurero-34', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-35', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 35', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-35-01', 'act-com-5i-aventurero-35', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-36', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 36', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-36-01', 'act-com-5i-aventurero-36', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-37', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 37', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-37-01', 'act-com-5i-aventurero-37', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-38', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 38', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-38-01', 'act-com-5i-aventurero-38', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-39', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 39', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-39-01', 'act-com-5i-aventurero-39', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-40', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 40', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-40-01', 'act-com-5i-aventurero-40', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-41', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 41', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-41-01', 'act-com-5i-aventurero-41', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-42', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 42', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-42-01', 'act-com-5i-aventurero-42', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-43', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 43', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-43-01', 'act-com-5i-aventurero-43', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-44', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 44', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-44-01', 'act-com-5i-aventurero-44', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-45', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 45', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-45-01', 'act-com-5i-aventurero-45', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-46', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 46', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-46-01', 'act-com-5i-aventurero-46', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-47', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 47', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-47-01', 'act-com-5i-aventurero-47', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-48', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 48', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-48-01', 'act-com-5i-aventurero-48', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-49', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 49', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-49-01', 'act-com-5i-aventurero-49', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-aventurero-50', 'les-com-5i-aventurero', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 50', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-aventurero-50-01', 'act-com-5i-aventurero-50', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-com-5i-estrella', 'com-inicial', '5-anios', 'estrella', '⭐ Estrella Brillante - Comunicación Inicial 5 años', 'nombre propio y carteles', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-01', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 01', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-01-01', 'act-com-5i-estrella-01', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-02', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 02', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-02-01', 'act-com-5i-estrella-02', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-03', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 03', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-03-01', 'act-com-5i-estrella-03', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-04', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 04', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-04-01', 'act-com-5i-estrella-04', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-05', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 05', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-05-01', 'act-com-5i-estrella-05', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-06', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 06', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-06-01', 'act-com-5i-estrella-06', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-07', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 07', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-07-01', 'act-com-5i-estrella-07', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-08', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 08', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-08-01', 'act-com-5i-estrella-08', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-09', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 09', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-09-01', 'act-com-5i-estrella-09', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-10', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 10', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-10-01', 'act-com-5i-estrella-10', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-11', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 11', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-11-01', 'act-com-5i-estrella-11', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-12', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 12', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-12-01', 'act-com-5i-estrella-12', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-13', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 13', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-13-01', 'act-com-5i-estrella-13', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-14', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 14', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-14-01', 'act-com-5i-estrella-14', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-15', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 15', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-15-01', 'act-com-5i-estrella-15', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-16', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 16', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-16-01', 'act-com-5i-estrella-16', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-17', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 17', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-17-01', 'act-com-5i-estrella-17', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-18', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 18', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-18-01', 'act-com-5i-estrella-18', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-19', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 19', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-19-01', 'act-com-5i-estrella-19', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-20', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 20', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-20-01', 'act-com-5i-estrella-20', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-21', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 21', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-21-01', 'act-com-5i-estrella-21', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-22', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 22', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-22-01', 'act-com-5i-estrella-22', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-23', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 23', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-23-01', 'act-com-5i-estrella-23', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-24', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 24', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-24-01', 'act-com-5i-estrella-24', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-25', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 25', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-25-01', 'act-com-5i-estrella-25', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-26', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 26', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-26-01', 'act-com-5i-estrella-26', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-27', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 27', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-27-01', 'act-com-5i-estrella-27', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-28', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 28', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-28-01', 'act-com-5i-estrella-28', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-29', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 29', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-29-01', 'act-com-5i-estrella-29', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-30', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 30', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-30-01', 'act-com-5i-estrella-30', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-31', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 31', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-31-01', 'act-com-5i-estrella-31', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-32', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 32', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-32-01', 'act-com-5i-estrella-32', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-33', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 33', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-33-01', 'act-com-5i-estrella-33', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-34', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 34', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-34-01', 'act-com-5i-estrella-34', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-35', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 35', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-35-01', 'act-com-5i-estrella-35', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-36', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 36', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-36-01', 'act-com-5i-estrella-36', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-37', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 37', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-37-01', 'act-com-5i-estrella-37', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-38', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 38', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-38-01', 'act-com-5i-estrella-38', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-39', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 39', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-39-01', 'act-com-5i-estrella-39', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-40', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 40', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-40-01', 'act-com-5i-estrella-40', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-41', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 41', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-41-01', 'act-com-5i-estrella-41', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-42', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 42', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-42-01', 'act-com-5i-estrella-42', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-43', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 43', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-43-01', 'act-com-5i-estrella-43', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-44', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 44', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-44-01', 'act-com-5i-estrella-44', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-45', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 45', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-45-01', 'act-com-5i-estrella-45', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-46', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 46', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-46-01', 'act-com-5i-estrella-46', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-47', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 47', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-47-01', 'act-com-5i-estrella-47', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-48', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 48', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-48-01', 'act-com-5i-estrella-48', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-49', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 49', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-49-01', 'act-com-5i-estrella-49', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-estrella-50', 'les-com-5i-estrella', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 50', 'Actividad lúdica de Comunicación para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-estrella-50-01', 'act-com-5i-estrella-50', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-com-5i-maestro', 'com-inicial', '5-anios', 'maestro', '🏆 Maestro Genio - Comunicación Inicial 5 años', 'explicar ideas con orden', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-01', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 01', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-01-01', 'act-com-5i-maestro-01', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-02', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 02', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-02-01', 'act-com-5i-maestro-02', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-03', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 03', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-03-01', 'act-com-5i-maestro-03', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-04', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 04', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-04-01', 'act-com-5i-maestro-04', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-05', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 05', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-05-01', 'act-com-5i-maestro-05', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-06', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 06', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-06-01', 'act-com-5i-maestro-06', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-07', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 07', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-07-01', 'act-com-5i-maestro-07', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-08', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 08', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-08-01', 'act-com-5i-maestro-08', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-09', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 09', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-09-01', 'act-com-5i-maestro-09', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-10', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 10', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-10-01', 'act-com-5i-maestro-10', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-11', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 11', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-11-01', 'act-com-5i-maestro-11', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-12', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 12', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-12-01', 'act-com-5i-maestro-12', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-13', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 13', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-13-01', 'act-com-5i-maestro-13', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-14', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 14', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-14-01', 'act-com-5i-maestro-14', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-15', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 15', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-15-01', 'act-com-5i-maestro-15', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-16', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 16', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-16-01', 'act-com-5i-maestro-16', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-17', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 17', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-17-01', 'act-com-5i-maestro-17', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-18', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 18', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-18-01', 'act-com-5i-maestro-18', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-19', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 19', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-19-01', 'act-com-5i-maestro-19', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-20', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 20', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-20-01', 'act-com-5i-maestro-20', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-21', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 21', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-21-01', 'act-com-5i-maestro-21', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-22', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 22', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-22-01', 'act-com-5i-maestro-22', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-23', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 23', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-23-01', 'act-com-5i-maestro-23', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-24', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 24', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-24-01', 'act-com-5i-maestro-24', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-25', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 25', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-25-01', 'act-com-5i-maestro-25', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-26', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 26', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-26-01', 'act-com-5i-maestro-26', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-27', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 27', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-27-01', 'act-com-5i-maestro-27', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-28', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 28', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-28-01', 'act-com-5i-maestro-28', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-29', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 29', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-29-01', 'act-com-5i-maestro-29', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-30', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 30', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-30-01', 'act-com-5i-maestro-30', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-31', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 31', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-31-01', 'act-com-5i-maestro-31', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-32', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 32', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-32-01', 'act-com-5i-maestro-32', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-33', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 33', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-33-01', 'act-com-5i-maestro-33', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-34', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 34', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-34-01', 'act-com-5i-maestro-34', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-35', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 35', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-35-01', 'act-com-5i-maestro-35', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-36', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 36', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-36-01', 'act-com-5i-maestro-36', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "qué hora es", "value": "qué hora es"}, {"id": "b", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "c", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-37', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 37', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-37-01', 'act-com-5i-maestro-37', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "b", "label": "la regaron", "value": "la regaron"}, {"id": "c", "label": "la vendieron", "value": "la vendieron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-38', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 38', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-38-01', 'act-com-5i-maestro-38', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para contar perros", "value": "para contar perros"}, {"id": "b", "label": "para pintar", "value": "para pintar"}, {"id": "c", "label": "para ubicar el baño", "value": "para ubicar el baño"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-39', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 39', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-39-01', 'act-com-5i-maestro-39', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "gritar", "value": "gritar"}, {"id": "b", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "c", "label": "interrumpir", "value": "interrumpir"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-40', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 40', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-40-01', 'act-com-5i-maestro-40', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "b", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "c", "label": "pintó una flor", "value": "pintó una flor"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-41', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 41', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-41-01', 'act-com-5i-maestro-41', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "b", "label": "qué hora es", "value": "qué hora es"}, {"id": "c", "label": "de qué tratará", "value": "de qué tratará"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-42', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 42', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-42-01', 'act-com-5i-maestro-42', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la vendieron", "value": "la vendieron"}, {"id": "b", "label": "sembraron la semilla", "value": "sembraron la semilla"}, {"id": "c", "label": "la regaron", "value": "la regaron"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-43', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 43', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-43-01', 'act-com-5i-maestro-43', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "b", "label": "para contar perros", "value": "para contar perros"}, {"id": "c", "label": "para pintar", "value": "para pintar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-44', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 44', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-44-01', 'act-com-5i-maestro-44', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "interrumpir", "value": "interrumpir"}, {"id": "b", "label": "gritar", "value": "gritar"}, {"id": "c", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-45', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 45', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-45-01', 'act-com-5i-maestro-45', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "b", "label": "perdió su pelota", "value": "perdió su pelota"}, {"id": "c", "label": "comió lonchera", "value": "comió lonchera"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-46', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 46', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-46-01', 'act-com-5i-maestro-46', 'Antes de leer la portada de un cuento, ¿qué puedes imaginar?', 'Observa el título o la imagen.', 'single-choice', 'de qué tratará', '[{"id": "a", "label": "de qué tratará", "value": "de qué tratará"}, {"id": "b", "label": "cuántas sillas hay", "value": "cuántas sillas hay"}, {"id": "c", "label": "qué hora es", "value": "qué hora es"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-47', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 47', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-47-01', 'act-com-5i-maestro-47', 'Ordena la historia: primero sembraron una semilla, después la regaron. ¿Qué pasó primero?', 'Reconoce la primera acción.', 'single-choice', 'sembraron la semilla', '[{"id": "a", "label": "la regaron", "value": "la regaron"}, {"id": "b", "label": "la vendieron", "value": "la vendieron"}, {"id": "c", "label": "sembraron la semilla", "value": "sembraron la semilla"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-48', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 48', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-48-01', 'act-com-5i-maestro-48', '¿Para qué sirve un cartel que dice ''baño''?', 'Piensa en los textos que encuentras en la escuela.', 'single-choice', 'para ubicar el baño', '[{"id": "a", "label": "para pintar", "value": "para pintar"}, {"id": "b", "label": "para ubicar el baño", "value": "para ubicar el baño"}, {"id": "c", "label": "para contar perros", "value": "para contar perros"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-49', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 49', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-49-01', 'act-com-5i-maestro-49', 'Cuando explicas una idea a tus compañeros, ¿qué conviene hacer?', 'Comunica con orden y respeto.', 'single-choice', 'hablar claro y escuchar', '[{"id": "a", "label": "hablar claro y escuchar", "value": "hablar claro y escuchar"}, {"id": "b", "label": "interrumpir", "value": "interrumpir"}, {"id": "c", "label": "gritar", "value": "gritar"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-com-5i-maestro-50', 'les-com-5i-maestro', 'com-inicial', '5-anios', 'Comunicación Inicial 5 años - Misión 50', 'Actividad lúdica de Comunicación para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-com-5i-maestro-50-01', 'act-com-5i-maestro-50', 'En un cuento, el personaje perdió su pelota y luego la buscó. ¿Cuál fue el problema?', 'Identifica lo que ocurrió en la historia.', 'single-choice', 'perdió su pelota', '[{"id": "a", "label": "comió lonchera", "value": "comió lonchera"}, {"id": "b", "label": "pintó una flor", "value": "pintó una flor"}, {"id": "c", "label": "perdió su pelota", "value": "perdió su pelota"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
