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

-- GenioKids - Matemática Inicial 5 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-5i-semilla', 'mat-inicial', '5-anios', 'semilla', '🌱 Semilla Genial - Matemática Inicial 5 años', 'conteo hasta 10 y 20', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-01', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 01', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-01-01', 'act-mat-5i-semilla-01', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-02', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 02', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-02-01', 'act-mat-5i-semilla-02', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-03', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 03', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-03-01', 'act-mat-5i-semilla-03', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-04', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 04', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-04-01', 'act-mat-5i-semilla-04', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-05', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 05', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-05-01', 'act-mat-5i-semilla-05', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-06', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 06', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-06-01', 'act-mat-5i-semilla-06', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-07', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 07', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-07-01', 'act-mat-5i-semilla-07', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-08', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 08', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-08-01', 'act-mat-5i-semilla-08', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-09', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 09', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-09-01', 'act-mat-5i-semilla-09', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-10', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 10', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-10-01', 'act-mat-5i-semilla-10', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-11', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 11', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-11-01', 'act-mat-5i-semilla-11', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-12', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 12', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-12-01', 'act-mat-5i-semilla-12', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-13', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 13', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-13-01', 'act-mat-5i-semilla-13', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-14', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 14', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-14-01', 'act-mat-5i-semilla-14', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-15', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 15', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-15-01', 'act-mat-5i-semilla-15', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-16', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 16', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-16-01', 'act-mat-5i-semilla-16', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-17', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 17', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-17-01', 'act-mat-5i-semilla-17', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-18', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 18', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-18-01', 'act-mat-5i-semilla-18', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-19', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 19', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-19-01', 'act-mat-5i-semilla-19', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-20', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 20', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-20-01', 'act-mat-5i-semilla-20', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-21', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 21', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-21-01', 'act-mat-5i-semilla-21', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-22', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 22', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-22-01', 'act-mat-5i-semilla-22', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-23', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 23', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-23-01', 'act-mat-5i-semilla-23', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-24', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 24', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-24-01', 'act-mat-5i-semilla-24', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-25', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 25', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-25-01', 'act-mat-5i-semilla-25', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-26', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 26', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-26-01', 'act-mat-5i-semilla-26', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-27', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 27', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-27-01', 'act-mat-5i-semilla-27', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-28', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 28', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-28-01', 'act-mat-5i-semilla-28', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-29', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 29', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-29-01', 'act-mat-5i-semilla-29', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-30', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 30', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-30-01', 'act-mat-5i-semilla-30', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-31', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 31', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-31-01', 'act-mat-5i-semilla-31', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-32', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 32', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-32-01', 'act-mat-5i-semilla-32', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-33', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 33', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-33-01', 'act-mat-5i-semilla-33', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-34', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 34', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-34-01', 'act-mat-5i-semilla-34', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-35', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 35', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-35-01', 'act-mat-5i-semilla-35', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-36', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 36', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-36-01', 'act-mat-5i-semilla-36', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-37', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 37', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-37-01', 'act-mat-5i-semilla-37', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-38', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 38', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-38-01', 'act-mat-5i-semilla-38', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-39', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 39', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-39-01', 'act-mat-5i-semilla-39', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-40', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 40', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-40-01', 'act-mat-5i-semilla-40', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-41', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 41', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-41-01', 'act-mat-5i-semilla-41', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-42', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 42', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-42-01', 'act-mat-5i-semilla-42', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-43', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 43', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-43-01', 'act-mat-5i-semilla-43', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-44', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 44', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-44-01', 'act-mat-5i-semilla-44', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-45', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 45', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-45-01', 'act-mat-5i-semilla-45', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-46', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 46', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-46-01', 'act-mat-5i-semilla-46', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-47', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 47', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-47-01', 'act-mat-5i-semilla-47', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-48', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 48', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-48-01', 'act-mat-5i-semilla-48', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-49', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 49', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-49-01', 'act-mat-5i-semilla-49', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-semilla-50', 'les-mat-5i-semilla', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 50', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-semilla-50-01', 'act-mat-5i-semilla-50', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-5i-explorador', 'mat-inicial', '5-anios', 'explorador', '🔎 Explorador Curioso - Matemática Inicial 5 años', 'agregar y quitar', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-01', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 01', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-01-01', 'act-mat-5i-explorador-01', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-02', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 02', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-02-01', 'act-mat-5i-explorador-02', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-03', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 03', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-03-01', 'act-mat-5i-explorador-03', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-04', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 04', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-04-01', 'act-mat-5i-explorador-04', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-05', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 05', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-05-01', 'act-mat-5i-explorador-05', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-06', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 06', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-06-01', 'act-mat-5i-explorador-06', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-07', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 07', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-07-01', 'act-mat-5i-explorador-07', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-08', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 08', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-08-01', 'act-mat-5i-explorador-08', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-09', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 09', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-09-01', 'act-mat-5i-explorador-09', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-10', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 10', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-10-01', 'act-mat-5i-explorador-10', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-11', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 11', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-11-01', 'act-mat-5i-explorador-11', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-12', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 12', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-12-01', 'act-mat-5i-explorador-12', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-13', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 13', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-13-01', 'act-mat-5i-explorador-13', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-14', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 14', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-14-01', 'act-mat-5i-explorador-14', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-15', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 15', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-15-01', 'act-mat-5i-explorador-15', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-16', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 16', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-16-01', 'act-mat-5i-explorador-16', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-17', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 17', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-17-01', 'act-mat-5i-explorador-17', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-18', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 18', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-18-01', 'act-mat-5i-explorador-18', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-19', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 19', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-19-01', 'act-mat-5i-explorador-19', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-20', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 20', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-20-01', 'act-mat-5i-explorador-20', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-21', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 21', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-21-01', 'act-mat-5i-explorador-21', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-22', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 22', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-22-01', 'act-mat-5i-explorador-22', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-23', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 23', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-23-01', 'act-mat-5i-explorador-23', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-24', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 24', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-24-01', 'act-mat-5i-explorador-24', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-25', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 25', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-25-01', 'act-mat-5i-explorador-25', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-26', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 26', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-26-01', 'act-mat-5i-explorador-26', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-27', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 27', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-27-01', 'act-mat-5i-explorador-27', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-28', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 28', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-28-01', 'act-mat-5i-explorador-28', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-29', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 29', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-29-01', 'act-mat-5i-explorador-29', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-30', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 30', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-30-01', 'act-mat-5i-explorador-30', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-31', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 31', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-31-01', 'act-mat-5i-explorador-31', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-32', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 32', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-32-01', 'act-mat-5i-explorador-32', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-33', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 33', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-33-01', 'act-mat-5i-explorador-33', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-34', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 34', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-34-01', 'act-mat-5i-explorador-34', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-35', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 35', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-35-01', 'act-mat-5i-explorador-35', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-36', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 36', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-36-01', 'act-mat-5i-explorador-36', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-37', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 37', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-37-01', 'act-mat-5i-explorador-37', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-38', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 38', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-38-01', 'act-mat-5i-explorador-38', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-39', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 39', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-39-01', 'act-mat-5i-explorador-39', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-40', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 40', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-40-01', 'act-mat-5i-explorador-40', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-41', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 41', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-41-01', 'act-mat-5i-explorador-41', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-42', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 42', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-42-01', 'act-mat-5i-explorador-42', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-43', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 43', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-43-01', 'act-mat-5i-explorador-43', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-44', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 44', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-44-01', 'act-mat-5i-explorador-44', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-45', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 45', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-45-01', 'act-mat-5i-explorador-45', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-46', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 46', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-46-01', 'act-mat-5i-explorador-46', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-47', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 47', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-47-01', 'act-mat-5i-explorador-47', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-48', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 48', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-48-01', 'act-mat-5i-explorador-48', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-49', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 49', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-49-01', 'act-mat-5i-explorador-49', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-explorador-50', 'les-mat-5i-explorador', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 50', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-explorador-50-01', 'act-mat-5i-explorador-50', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'aventurero', '🧭 Aventurero Ágil - Matemática Inicial 5 años', 'comparar cantidades', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-01', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 01', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-01-01', 'act-mat-5i-aventurero-01', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-02', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 02', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-02-01', 'act-mat-5i-aventurero-02', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-03', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 03', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-03-01', 'act-mat-5i-aventurero-03', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-04', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 04', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-04-01', 'act-mat-5i-aventurero-04', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-05', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 05', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-05-01', 'act-mat-5i-aventurero-05', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-06', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 06', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-06-01', 'act-mat-5i-aventurero-06', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-07', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 07', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-07-01', 'act-mat-5i-aventurero-07', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-08', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 08', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-08-01', 'act-mat-5i-aventurero-08', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-09', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 09', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-09-01', 'act-mat-5i-aventurero-09', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-10', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 10', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-10-01', 'act-mat-5i-aventurero-10', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-11', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 11', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-11-01', 'act-mat-5i-aventurero-11', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-12', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 12', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-12-01', 'act-mat-5i-aventurero-12', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-13', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 13', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-13-01', 'act-mat-5i-aventurero-13', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-14', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 14', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-14-01', 'act-mat-5i-aventurero-14', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-15', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 15', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-15-01', 'act-mat-5i-aventurero-15', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-16', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 16', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-16-01', 'act-mat-5i-aventurero-16', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-17', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 17', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-17-01', 'act-mat-5i-aventurero-17', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-18', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 18', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-18-01', 'act-mat-5i-aventurero-18', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-19', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 19', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-19-01', 'act-mat-5i-aventurero-19', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-20', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 20', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-20-01', 'act-mat-5i-aventurero-20', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-21', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 21', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-21-01', 'act-mat-5i-aventurero-21', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-22', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 22', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-22-01', 'act-mat-5i-aventurero-22', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-23', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 23', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-23-01', 'act-mat-5i-aventurero-23', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-24', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 24', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-24-01', 'act-mat-5i-aventurero-24', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-25', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 25', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-25-01', 'act-mat-5i-aventurero-25', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-26', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 26', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-26-01', 'act-mat-5i-aventurero-26', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-27', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 27', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-27-01', 'act-mat-5i-aventurero-27', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-28', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 28', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-28-01', 'act-mat-5i-aventurero-28', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-29', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 29', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-29-01', 'act-mat-5i-aventurero-29', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-30', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 30', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-30-01', 'act-mat-5i-aventurero-30', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-31', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 31', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-31-01', 'act-mat-5i-aventurero-31', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-32', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 32', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-32-01', 'act-mat-5i-aventurero-32', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-33', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 33', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-33-01', 'act-mat-5i-aventurero-33', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-34', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 34', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-34-01', 'act-mat-5i-aventurero-34', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-35', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 35', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-35-01', 'act-mat-5i-aventurero-35', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-36', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 36', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-36-01', 'act-mat-5i-aventurero-36', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-37', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 37', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-37-01', 'act-mat-5i-aventurero-37', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-38', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 38', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-38-01', 'act-mat-5i-aventurero-38', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-39', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 39', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-39-01', 'act-mat-5i-aventurero-39', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-40', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 40', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-40-01', 'act-mat-5i-aventurero-40', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-41', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 41', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-41-01', 'act-mat-5i-aventurero-41', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-42', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 42', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-42-01', 'act-mat-5i-aventurero-42', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-43', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 43', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-43-01', 'act-mat-5i-aventurero-43', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-44', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 44', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-44-01', 'act-mat-5i-aventurero-44', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-45', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 45', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-45-01', 'act-mat-5i-aventurero-45', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-46', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 46', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-46-01', 'act-mat-5i-aventurero-46', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-47', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 47', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-47-01', 'act-mat-5i-aventurero-47', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-48', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 48', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-48-01', 'act-mat-5i-aventurero-48', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-49', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 49', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-49-01', 'act-mat-5i-aventurero-49', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-aventurero-50', 'les-mat-5i-aventurero', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 50', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-aventurero-50-01', 'act-mat-5i-aventurero-50', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-5i-estrella', 'mat-inicial', '5-anios', 'estrella', '⭐ Estrella Brillante - Matemática Inicial 5 años', 'seriación y patrones', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-01', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 01', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-01-01', 'act-mat-5i-estrella-01', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-02', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 02', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-02-01', 'act-mat-5i-estrella-02', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-03', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 03', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-03-01', 'act-mat-5i-estrella-03', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-04', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 04', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-04-01', 'act-mat-5i-estrella-04', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-05', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 05', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-05-01', 'act-mat-5i-estrella-05', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-06', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 06', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-06-01', 'act-mat-5i-estrella-06', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-07', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 07', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-07-01', 'act-mat-5i-estrella-07', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-08', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 08', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-08-01', 'act-mat-5i-estrella-08', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-09', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 09', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-09-01', 'act-mat-5i-estrella-09', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-10', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 10', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-10-01', 'act-mat-5i-estrella-10', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-11', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 11', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-11-01', 'act-mat-5i-estrella-11', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-12', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 12', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-12-01', 'act-mat-5i-estrella-12', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-13', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 13', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-13-01', 'act-mat-5i-estrella-13', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-14', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 14', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-14-01', 'act-mat-5i-estrella-14', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-15', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 15', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-15-01', 'act-mat-5i-estrella-15', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-16', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 16', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-16-01', 'act-mat-5i-estrella-16', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-17', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 17', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-17-01', 'act-mat-5i-estrella-17', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-18', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 18', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-18-01', 'act-mat-5i-estrella-18', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-19', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 19', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-19-01', 'act-mat-5i-estrella-19', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-20', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 20', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-20-01', 'act-mat-5i-estrella-20', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-21', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 21', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-21-01', 'act-mat-5i-estrella-21', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-22', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 22', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-22-01', 'act-mat-5i-estrella-22', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-23', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 23', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-23-01', 'act-mat-5i-estrella-23', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-24', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 24', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-24-01', 'act-mat-5i-estrella-24', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-25', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 25', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-25-01', 'act-mat-5i-estrella-25', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-26', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 26', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-26-01', 'act-mat-5i-estrella-26', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-27', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 27', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-27-01', 'act-mat-5i-estrella-27', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-28', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 28', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-28-01', 'act-mat-5i-estrella-28', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-29', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 29', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-29-01', 'act-mat-5i-estrella-29', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-30', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 30', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-30-01', 'act-mat-5i-estrella-30', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-31', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 31', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-31-01', 'act-mat-5i-estrella-31', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-32', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 32', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-32-01', 'act-mat-5i-estrella-32', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-33', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 33', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-33-01', 'act-mat-5i-estrella-33', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-34', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 34', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-34-01', 'act-mat-5i-estrella-34', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-35', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 35', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-35-01', 'act-mat-5i-estrella-35', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-36', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 36', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-36-01', 'act-mat-5i-estrella-36', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-37', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 37', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-37-01', 'act-mat-5i-estrella-37', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-38', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 38', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-38-01', 'act-mat-5i-estrella-38', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-39', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 39', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-39-01', 'act-mat-5i-estrella-39', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-40', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 40', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-40-01', 'act-mat-5i-estrella-40', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-41', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 41', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-41-01', 'act-mat-5i-estrella-41', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-42', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 42', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-42-01', 'act-mat-5i-estrella-42', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-43', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 43', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-43-01', 'act-mat-5i-estrella-43', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-44', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 44', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-44-01', 'act-mat-5i-estrella-44', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-45', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 45', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-45-01', 'act-mat-5i-estrella-45', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-46', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 46', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-46-01', 'act-mat-5i-estrella-46', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-47', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 47', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-47-01', 'act-mat-5i-estrella-47', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-48', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 48', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-48-01', 'act-mat-5i-estrella-48', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-49', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 49', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-49-01', 'act-mat-5i-estrella-49', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-estrella-50', 'les-mat-5i-estrella', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 50', 'Actividad lúdica de Matemática para inicial 5 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-estrella-50-01', 'act-mat-5i-estrella-50', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-5i-maestro', 'mat-inicial', '5-anios', 'maestro', '🏆 Maestro Genio - Matemática Inicial 5 años', 'medición no convencional', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-01', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 01', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-01-01', 'act-mat-5i-maestro-01', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-02', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 02', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-02-01', 'act-mat-5i-maestro-02', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-03', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 03', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-03-01', 'act-mat-5i-maestro-03', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-04', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 04', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-04-01', 'act-mat-5i-maestro-04', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-05', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 05', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-05-01', 'act-mat-5i-maestro-05', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-06', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 06', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-06-01', 'act-mat-5i-maestro-06', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-07', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 07', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-07-01', 'act-mat-5i-maestro-07', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-08', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 08', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-08-01', 'act-mat-5i-maestro-08', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-09', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 09', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-09-01', 'act-mat-5i-maestro-09', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-10', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 10', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-10-01', 'act-mat-5i-maestro-10', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-11', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 11', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-11-01', 'act-mat-5i-maestro-11', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-12', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 12', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-12-01', 'act-mat-5i-maestro-12', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-13', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 13', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-13-01', 'act-mat-5i-maestro-13', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-14', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 14', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-14-01', 'act-mat-5i-maestro-14', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-15', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 15', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-15-01', 'act-mat-5i-maestro-15', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-16', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 16', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-16-01', 'act-mat-5i-maestro-16', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-17', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 17', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-17-01', 'act-mat-5i-maestro-17', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-18', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 18', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-18-01', 'act-mat-5i-maestro-18', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-19', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 19', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-19-01', 'act-mat-5i-maestro-19', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-20', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 20', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-20-01', 'act-mat-5i-maestro-20', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-21', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 21', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-21-01', 'act-mat-5i-maestro-21', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-22', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 22', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-22-01', 'act-mat-5i-maestro-22', 'Hay 15 semillas en un plato y 5 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-23', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 23', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-23-01', 'act-mat-5i-maestro-23', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-24', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 24', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-24-01', 'act-mat-5i-maestro-24', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-25', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 25', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-25-01', 'act-mat-5i-maestro-25', 'En el sector de construcción hay 3 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '4', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-26', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 26', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-26-01', 'act-mat-5i-maestro-26', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "7", "value": "7"}, {"id": "b", "label": "4", "value": "4"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-27', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 27', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-27-01', 'act-mat-5i-maestro-27', 'Hay 10 semillas en un plato y 4 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-28', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 28', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-28-01', 'act-mat-5i-maestro-28', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-29', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 29', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-29-01', 'act-mat-5i-maestro-29', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-30', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 30', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-30-01', 'act-mat-5i-maestro-30', 'En el sector de construcción hay 8 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '11', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "11", "value": "11"}, {"id": "c", "label": "12", "value": "12"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-31', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 31', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-31-01', 'act-mat-5i-maestro-31', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "10", "value": "10"}, {"id": "b", "label": "12", "value": "12"}, {"id": "c", "label": "9", "value": "9"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-32', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 32', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-32-01', 'act-mat-5i-maestro-32', 'Hay 15 semillas en un plato y 3 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-33', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 33', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-33-01', 'act-mat-5i-maestro-33', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-34', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 34', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-34-01', 'act-mat-5i-maestro-34', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-35', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 35', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-35-01', 'act-mat-5i-maestro-35', 'En el sector de construcción hay 3 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '5', '[{"id": "a", "label": "6", "value": "6"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "5", "value": "5"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-36', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 36', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-36-01', 'act-mat-5i-maestro-36', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "5", "value": "5"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-37', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 37', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-37-01', 'act-mat-5i-maestro-37', 'Hay 10 semillas en un plato y 2 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "más", "value": "más"}, {"id": "b", "label": "igual", "value": "igual"}, {"id": "c", "label": "nada", "value": "nada"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-38', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 38', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-38-01', 'act-mat-5i-maestro-38', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-39', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 39', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-39-01', 'act-mat-5i-maestro-39', 'La alfombra mide 8 manos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'manos', '[{"id": "a", "label": "sonidos", "value": "sonidos"}, {"id": "b", "label": "manos", "value": "manos"}, {"id": "c", "label": "letras", "value": "letras"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-40', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 40', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-40-01', 'act-mat-5i-maestro-40', 'En el sector de construcción hay 8 bloques y llegan 1 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '9', '[{"id": "a", "label": "9", "value": "9"}, {"id": "b", "label": "10", "value": "10"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-41', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 41', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-41-01', 'act-mat-5i-maestro-41', 'Había 12 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '10', '[{"id": "a", "label": "12", "value": "12"}, {"id": "b", "label": "9", "value": "9"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-42', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 42', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-42-01', 'act-mat-5i-maestro-42', 'Hay 15 semillas en un plato y 7 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "nada", "value": "nada"}, {"id": "b", "label": "más", "value": "más"}, {"id": "c", "label": "igual", "value": "igual"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-43', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 43', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-43-01', 'act-mat-5i-maestro-43', 'Sigue el patrón: amarillo, verde, amarillo, verde, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'amarillo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-44', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 44', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-44-01', 'act-mat-5i-maestro-44', 'La alfombra mide 8 pasos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'pasos', '[{"id": "a", "label": "letras", "value": "letras"}, {"id": "b", "label": "sonidos", "value": "sonidos"}, {"id": "c", "label": "pasos", "value": "pasos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-45', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 45', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-45-01', 'act-mat-5i-maestro-45', 'En el sector de construcción hay 3 bloques y llegan 3 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '6', '[{"id": "a", "label": "4", "value": "4"}, {"id": "b", "label": "6", "value": "6"}, {"id": "c", "label": "7", "value": "7"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-46', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 46', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-46-01', 'act-mat-5i-maestro-46', 'Había 7 tapitas y se guardaron 2. ¿Cuántas tapitas quedan?', 'Quita la cantidad indicada y cuenta lo que queda.', 'single-choice', '5', '[{"id": "a", "label": "5", "value": "5"}, {"id": "b", "label": "7", "value": "7"}, {"id": "c", "label": "4", "value": "4"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-47', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 47', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-47-01', 'act-mat-5i-maestro-47', 'Hay 10 semillas en un plato y 6 en otro. ¿En el primer plato hay más o menos?', 'Compara las dos cantidades.', 'single-choice', 'más', '[{"id": "a", "label": "igual", "value": "igual"}, {"id": "b", "label": "nada", "value": "nada"}, {"id": "c", "label": "más", "value": "más"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-48', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 48', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-48-01', 'act-mat-5i-maestro-48', 'Sigue el patrón: verde, amarillo, verde, amarillo, ¿qué color continúa?', 'Identifica la repetición.', 'single-choice', 'verde', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-49', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 49', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-49-01', 'act-mat-5i-maestro-49', 'La alfombra mide 8 palitos. ¿Con qué se midió la alfombra?', 'Recuerda la unidad usada para medir.', 'single-choice', 'palitos', '[{"id": "a", "label": "palitos", "value": "palitos"}, {"id": "b", "label": "letras", "value": "letras"}, {"id": "c", "label": "sonidos", "value": "sonidos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-5i-maestro-50', 'les-mat-5i-maestro', 'mat-inicial', '5-anios', 'Matemática Inicial 5 años - Misión 50', 'Actividad lúdica de Matemática para inicial 5 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-5i-maestro-50-01', 'act-mat-5i-maestro-50', 'En el sector de construcción hay 8 bloques y llegan 2 más. ¿Cuántos bloques hay en total?', 'Cuenta todos los bloques juntos.', 'single-choice', '10', '[{"id": "a", "label": "11", "value": "11"}, {"id": "b", "label": "8", "value": "8"}, {"id": "c", "label": "10", "value": "10"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
