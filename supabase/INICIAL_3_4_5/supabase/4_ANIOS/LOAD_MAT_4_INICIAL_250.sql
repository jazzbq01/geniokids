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

-- GenioKids - Matemática Inicial 4 años - 250 actividades

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-4i-semilla', 'mat-inicial', '4-anios', 'semilla', '🌱 Semilla Genial - Matemática Inicial 4 años', 'conteo hasta 5', 1, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-01', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 01', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-01-01', 'act-mat-4i-semilla-01', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-02', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 02', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-02-01', 'act-mat-4i-semilla-02', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-03', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 03', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-03-01', 'act-mat-4i-semilla-03', 'Luis tiene 1 pelotas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-04', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 04', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-04-01', 'act-mat-4i-semilla-04', 'Para ordenar, debes juntar los cuentos de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-05', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 05', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-05-01', 'act-mat-4i-semilla-05', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-06', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 06', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-06-01', 'act-mat-4i-semilla-06', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-07', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 07', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-07-01', 'act-mat-4i-semilla-07', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-08', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 08', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-08-01', 'act-mat-4i-semilla-08', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-09', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 09', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-09-01', 'act-mat-4i-semilla-09', 'Para ordenar, debes juntar los bloques de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-10', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 10', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-10-01', 'act-mat-4i-semilla-10', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-11', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 11', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-11-01', 'act-mat-4i-semilla-11', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-12', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 12', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-12-01', 'act-mat-4i-semilla-12', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-13', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 13', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-13-01', 'act-mat-4i-semilla-13', 'Luis tiene 1 semillas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-14', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 14', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-14-01', 'act-mat-4i-semilla-14', 'Para ordenar, debes juntar los tapitas de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-15', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 15', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-15-01', 'act-mat-4i-semilla-15', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-16', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 16', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-16-01', 'act-mat-4i-semilla-16', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-17', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 17', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-17-01', 'act-mat-4i-semilla-17', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-18', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 18', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-18-01', 'act-mat-4i-semilla-18', 'Luis tiene 1 crayones y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-19', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 19', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-19-01', 'act-mat-4i-semilla-19', 'Para ordenar, debes juntar los pelotas de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-20', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 20', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-20-01', 'act-mat-4i-semilla-20', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-21', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 21', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-21-01', 'act-mat-4i-semilla-21', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-22', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 22', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-22-01', 'act-mat-4i-semilla-22', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-23', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 23', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-23-01', 'act-mat-4i-semilla-23', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-24', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 24', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-24-01', 'act-mat-4i-semilla-24', 'Para ordenar, debes juntar los hojas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-25', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 25', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-25-01', 'act-mat-4i-semilla-25', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-26', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 26', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-26-01', 'act-mat-4i-semilla-26', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-27', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 27', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-27-01', 'act-mat-4i-semilla-27', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-28', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 28', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-28-01', 'act-mat-4i-semilla-28', 'Luis tiene 1 cuentos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-29', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 29', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-29-01', 'act-mat-4i-semilla-29', 'Para ordenar, debes juntar los semillas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-30', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 30', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-30-01', 'act-mat-4i-semilla-30', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-31', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 31', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-31-01', 'act-mat-4i-semilla-31', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-32', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 32', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-32-01', 'act-mat-4i-semilla-32', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-33', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 33', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-33-01', 'act-mat-4i-semilla-33', 'Luis tiene 1 bloques y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-34', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 34', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-34-01', 'act-mat-4i-semilla-34', 'Para ordenar, debes juntar los crayones de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-35', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 35', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-35-01', 'act-mat-4i-semilla-35', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-36', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 36', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-36-01', 'act-mat-4i-semilla-36', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-37', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 37', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-37-01', 'act-mat-4i-semilla-37', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-38', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 38', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-38-01', 'act-mat-4i-semilla-38', 'Luis tiene 1 tapitas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-39', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 39', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-39-01', 'act-mat-4i-semilla-39', 'Para ordenar, debes juntar los muñecos de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-40', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 40', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-40-01', 'act-mat-4i-semilla-40', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-41', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 41', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-41-01', 'act-mat-4i-semilla-41', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-42', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 42', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-42-01', 'act-mat-4i-semilla-42', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-43', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 43', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-43-01', 'act-mat-4i-semilla-43', 'Luis tiene 1 pelotas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-44', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 44', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-44-01', 'act-mat-4i-semilla-44', 'Para ordenar, debes juntar los cuentos de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-45', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 45', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-45-01', 'act-mat-4i-semilla-45', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-46', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 46', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-46-01', 'act-mat-4i-semilla-46', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-47', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 47', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-47-01', 'act-mat-4i-semilla-47', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-48', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 48', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-48-01', 'act-mat-4i-semilla-48', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-49', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 49', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-49-01', 'act-mat-4i-semilla-49', 'Para ordenar, debes juntar los bloques de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-semilla-50', 'les-mat-4i-semilla', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 50', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🌱 Semilla Genial. Vale 1 punto.', 'quiz', 'semilla', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-semilla-50-01', 'act-mat-4i-semilla-50', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-4i-explorador', 'mat-inicial', '4-anios', 'explorador', '🔎 Explorador Curioso - Matemática Inicial 4 años', 'clasificación por color', 2, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-01', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 01', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-01-01', 'act-mat-4i-explorador-01', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-02', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 02', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-02-01', 'act-mat-4i-explorador-02', 'Para ordenar, debes juntar los bloques de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-03', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 03', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-03-01', 'act-mat-4i-explorador-03', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-04', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 04', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-04-01', 'act-mat-4i-explorador-04', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-05', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 05', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-05-01', 'act-mat-4i-explorador-05', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-06', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 06', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-06-01', 'act-mat-4i-explorador-06', 'Luis tiene 1 semillas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-07', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 07', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-07-01', 'act-mat-4i-explorador-07', 'Para ordenar, debes juntar los tapitas de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-08', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 08', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-08-01', 'act-mat-4i-explorador-08', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-09', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 09', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-09-01', 'act-mat-4i-explorador-09', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-10', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 10', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-10-01', 'act-mat-4i-explorador-10', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-11', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 11', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-11-01', 'act-mat-4i-explorador-11', 'Luis tiene 1 crayones y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-12', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 12', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-12-01', 'act-mat-4i-explorador-12', 'Para ordenar, debes juntar los pelotas de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-13', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 13', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-13-01', 'act-mat-4i-explorador-13', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-14', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 14', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-14-01', 'act-mat-4i-explorador-14', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-15', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 15', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-15-01', 'act-mat-4i-explorador-15', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-16', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 16', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-16-01', 'act-mat-4i-explorador-16', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-17', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 17', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-17-01', 'act-mat-4i-explorador-17', 'Para ordenar, debes juntar los hojas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-18', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 18', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-18-01', 'act-mat-4i-explorador-18', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-19', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 19', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-19-01', 'act-mat-4i-explorador-19', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-20', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 20', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-20-01', 'act-mat-4i-explorador-20', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-21', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 21', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-21-01', 'act-mat-4i-explorador-21', 'Luis tiene 1 cuentos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-22', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 22', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-22-01', 'act-mat-4i-explorador-22', 'Para ordenar, debes juntar los semillas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-23', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 23', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-23-01', 'act-mat-4i-explorador-23', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-24', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 24', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-24-01', 'act-mat-4i-explorador-24', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-25', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 25', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-25-01', 'act-mat-4i-explorador-25', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-26', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 26', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-26-01', 'act-mat-4i-explorador-26', 'Luis tiene 1 bloques y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-27', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 27', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-27-01', 'act-mat-4i-explorador-27', 'Para ordenar, debes juntar los crayones de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-28', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 28', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-28-01', 'act-mat-4i-explorador-28', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-29', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 29', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-29-01', 'act-mat-4i-explorador-29', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-30', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 30', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-30-01', 'act-mat-4i-explorador-30', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-31', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 31', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-31-01', 'act-mat-4i-explorador-31', 'Luis tiene 1 tapitas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-32', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 32', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-32-01', 'act-mat-4i-explorador-32', 'Para ordenar, debes juntar los muñecos de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-33', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 33', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-33-01', 'act-mat-4i-explorador-33', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-34', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 34', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-34-01', 'act-mat-4i-explorador-34', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-35', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 35', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-35-01', 'act-mat-4i-explorador-35', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-36', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 36', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-36-01', 'act-mat-4i-explorador-36', 'Luis tiene 1 pelotas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-37', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 37', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-37-01', 'act-mat-4i-explorador-37', 'Para ordenar, debes juntar los cuentos de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-38', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 38', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-38-01', 'act-mat-4i-explorador-38', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-39', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 39', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-39-01', 'act-mat-4i-explorador-39', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-40', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 40', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-40-01', 'act-mat-4i-explorador-40', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-41', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 41', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-41-01', 'act-mat-4i-explorador-41', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-42', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 42', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-42-01', 'act-mat-4i-explorador-42', 'Para ordenar, debes juntar los bloques de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-43', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 43', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-43-01', 'act-mat-4i-explorador-43', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-44', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 44', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-44-01', 'act-mat-4i-explorador-44', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-45', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 45', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-45-01', 'act-mat-4i-explorador-45', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-46', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 46', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-46-01', 'act-mat-4i-explorador-46', 'Luis tiene 1 semillas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-47', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 47', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-47-01', 'act-mat-4i-explorador-47', 'Para ordenar, debes juntar los tapitas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-48', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 48', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-48-01', 'act-mat-4i-explorador-48', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-49', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 49', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-49-01', 'act-mat-4i-explorador-49', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-explorador-50', 'les-mat-4i-explorador', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 50', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🔎 Explorador Curioso. Vale 1 punto.', 'quiz', 'explorador', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-explorador-50-01', 'act-mat-4i-explorador-50', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'aventurero', '🧭 Aventurero Ágil - Matemática Inicial 4 años', 'patrones simples', 3, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-01', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 01', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-01-01', 'act-mat-4i-aventurero-01', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-02', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 02', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-02-01', 'act-mat-4i-aventurero-02', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-03', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 03', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-03-01', 'act-mat-4i-aventurero-03', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-04', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 04', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-04-01', 'act-mat-4i-aventurero-04', 'Luis tiene 1 crayones y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-05', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 05', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-05-01', 'act-mat-4i-aventurero-05', 'Para ordenar, debes juntar los pelotas de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-06', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 06', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-06-01', 'act-mat-4i-aventurero-06', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-07', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 07', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-07-01', 'act-mat-4i-aventurero-07', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-08', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 08', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-08-01', 'act-mat-4i-aventurero-08', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-09', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 09', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-09-01', 'act-mat-4i-aventurero-09', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-10', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 10', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-10-01', 'act-mat-4i-aventurero-10', 'Para ordenar, debes juntar los hojas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-11', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 11', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-11-01', 'act-mat-4i-aventurero-11', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-12', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 12', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-12-01', 'act-mat-4i-aventurero-12', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-13', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 13', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-13-01', 'act-mat-4i-aventurero-13', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-14', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 14', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-14-01', 'act-mat-4i-aventurero-14', 'Luis tiene 1 cuentos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-15', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 15', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-15-01', 'act-mat-4i-aventurero-15', 'Para ordenar, debes juntar los semillas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-16', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 16', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-16-01', 'act-mat-4i-aventurero-16', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-17', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 17', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-17-01', 'act-mat-4i-aventurero-17', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-18', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 18', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-18-01', 'act-mat-4i-aventurero-18', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-19', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 19', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-19-01', 'act-mat-4i-aventurero-19', 'Luis tiene 1 bloques y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-20', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 20', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-20-01', 'act-mat-4i-aventurero-20', 'Para ordenar, debes juntar los crayones de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-21', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 21', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-21-01', 'act-mat-4i-aventurero-21', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-22', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 22', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-22-01', 'act-mat-4i-aventurero-22', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-23', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 23', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-23-01', 'act-mat-4i-aventurero-23', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-24', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 24', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-24-01', 'act-mat-4i-aventurero-24', 'Luis tiene 1 tapitas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-25', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 25', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-25-01', 'act-mat-4i-aventurero-25', 'Para ordenar, debes juntar los muñecos de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-26', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 26', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-26-01', 'act-mat-4i-aventurero-26', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-27', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 27', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-27-01', 'act-mat-4i-aventurero-27', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-28', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 28', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-28-01', 'act-mat-4i-aventurero-28', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-29', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 29', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-29-01', 'act-mat-4i-aventurero-29', 'Luis tiene 1 pelotas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-30', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 30', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-30-01', 'act-mat-4i-aventurero-30', 'Para ordenar, debes juntar los cuentos de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-31', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 31', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-31-01', 'act-mat-4i-aventurero-31', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-32', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 32', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-32-01', 'act-mat-4i-aventurero-32', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-33', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 33', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-33-01', 'act-mat-4i-aventurero-33', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-34', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 34', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-34-01', 'act-mat-4i-aventurero-34', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-35', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 35', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-35-01', 'act-mat-4i-aventurero-35', 'Para ordenar, debes juntar los bloques de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-36', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 36', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-36-01', 'act-mat-4i-aventurero-36', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-37', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 37', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-37-01', 'act-mat-4i-aventurero-37', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-38', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 38', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-38-01', 'act-mat-4i-aventurero-38', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-39', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 39', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-39-01', 'act-mat-4i-aventurero-39', 'Luis tiene 1 semillas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-40', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 40', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-40-01', 'act-mat-4i-aventurero-40', 'Para ordenar, debes juntar los tapitas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-41', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 41', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-41-01', 'act-mat-4i-aventurero-41', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-42', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 42', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-42-01', 'act-mat-4i-aventurero-42', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-43', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 43', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-43-01', 'act-mat-4i-aventurero-43', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-44', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 44', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-44-01', 'act-mat-4i-aventurero-44', 'Luis tiene 1 crayones y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-45', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 45', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-45-01', 'act-mat-4i-aventurero-45', 'Para ordenar, debes juntar los pelotas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-46', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 46', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-46-01', 'act-mat-4i-aventurero-46', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-47', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 47', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-47-01', 'act-mat-4i-aventurero-47', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-48', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 48', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-48-01', 'act-mat-4i-aventurero-48', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-49', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 49', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-49-01', 'act-mat-4i-aventurero-49', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-aventurero-50', 'les-mat-4i-aventurero', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 50', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🧭 Aventurero Ágil. Vale 1 punto.', 'quiz', 'aventurero', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-aventurero-50-01', 'act-mat-4i-aventurero-50', 'Para ordenar, debes juntar los hojas de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-4i-estrella', 'mat-inicial', '4-anios', 'estrella', '⭐ Estrella Brillante - Matemática Inicial 4 años', 'formas básicas', 4, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-01', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 01', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-01-01', 'act-mat-4i-estrella-01', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-02', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 02', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-02-01', 'act-mat-4i-estrella-02', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-03', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 03', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-03-01', 'act-mat-4i-estrella-03', 'Para ordenar, debes juntar los hojas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-04', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 04', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-04-01', 'act-mat-4i-estrella-04', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-05', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 05', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-05-01', 'act-mat-4i-estrella-05', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-06', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 06', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-06-01', 'act-mat-4i-estrella-06', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-07', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 07', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-07-01', 'act-mat-4i-estrella-07', 'Luis tiene 1 cuentos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-08', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 08', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-08-01', 'act-mat-4i-estrella-08', 'Para ordenar, debes juntar los semillas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-09', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 09', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-09-01', 'act-mat-4i-estrella-09', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-10', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 10', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-10-01', 'act-mat-4i-estrella-10', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-11', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 11', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-11-01', 'act-mat-4i-estrella-11', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-12', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 12', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-12-01', 'act-mat-4i-estrella-12', 'Luis tiene 1 bloques y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-13', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 13', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-13-01', 'act-mat-4i-estrella-13', 'Para ordenar, debes juntar los crayones de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-14', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 14', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-14-01', 'act-mat-4i-estrella-14', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-15', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 15', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-15-01', 'act-mat-4i-estrella-15', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-16', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 16', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-16-01', 'act-mat-4i-estrella-16', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-17', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 17', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-17-01', 'act-mat-4i-estrella-17', 'Luis tiene 1 tapitas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-18', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 18', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-18-01', 'act-mat-4i-estrella-18', 'Para ordenar, debes juntar los muñecos de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-19', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 19', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-19-01', 'act-mat-4i-estrella-19', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-20', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 20', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-20-01', 'act-mat-4i-estrella-20', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-21', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 21', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-21-01', 'act-mat-4i-estrella-21', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-22', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 22', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-22-01', 'act-mat-4i-estrella-22', 'Luis tiene 1 pelotas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-23', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 23', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-23-01', 'act-mat-4i-estrella-23', 'Para ordenar, debes juntar los cuentos de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-24', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 24', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-24-01', 'act-mat-4i-estrella-24', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-25', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 25', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-25-01', 'act-mat-4i-estrella-25', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-26', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 26', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-26-01', 'act-mat-4i-estrella-26', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-27', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 27', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-27-01', 'act-mat-4i-estrella-27', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-28', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 28', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-28-01', 'act-mat-4i-estrella-28', 'Para ordenar, debes juntar los bloques de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-29', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 29', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-29-01', 'act-mat-4i-estrella-29', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-30', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 30', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-30-01', 'act-mat-4i-estrella-30', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-31', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 31', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-31-01', 'act-mat-4i-estrella-31', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-32', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 32', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-32-01', 'act-mat-4i-estrella-32', 'Luis tiene 1 semillas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-33', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 33', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-33-01', 'act-mat-4i-estrella-33', 'Para ordenar, debes juntar los tapitas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-34', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 34', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-34-01', 'act-mat-4i-estrella-34', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-35', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 35', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-35-01', 'act-mat-4i-estrella-35', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-36', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 36', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-36-01', 'act-mat-4i-estrella-36', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-37', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 37', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-37-01', 'act-mat-4i-estrella-37', 'Luis tiene 1 crayones y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-38', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 38', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-38-01', 'act-mat-4i-estrella-38', 'Para ordenar, debes juntar los pelotas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-39', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 39', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-39-01', 'act-mat-4i-estrella-39', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-40', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 40', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-40-01', 'act-mat-4i-estrella-40', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-41', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 41', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-41-01', 'act-mat-4i-estrella-41', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-42', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 42', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-42-01', 'act-mat-4i-estrella-42', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-43', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 43', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-43-01', 'act-mat-4i-estrella-43', 'Para ordenar, debes juntar los hojas de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-44', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 44', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-44-01', 'act-mat-4i-estrella-44', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-45', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 45', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-45-01', 'act-mat-4i-estrella-45', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-46', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 46', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-46-01', 'act-mat-4i-estrella-46', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-47', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 47', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-47-01', 'act-mat-4i-estrella-47', 'Luis tiene 1 cuentos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-48', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 48', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-48-01', 'act-mat-4i-estrella-48', 'Para ordenar, debes juntar los semillas de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-49', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 49', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-49-01', 'act-mat-4i-estrella-49', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-estrella-50', 'les-mat-4i-estrella', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 50', 'Actividad lúdica de Matemática para inicial 4 años, nivel ⭐ Estrella Brillante. Vale 1 punto.', 'quiz', 'estrella', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-estrella-50-01', 'act-mat-4i-estrella-50', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number, is_active) values
('les-mat-4i-maestro', 'mat-inicial', '4-anios', 'maestro', '🏆 Maestro Genio - Matemática Inicial 4 años', 'cerca y lejos', 5, true)
on conflict (id) do update set subject_id=excluded.subject_id, grade=excluded.grade, difficulty_level_id=excluded.difficulty_level_id, title=excluded.title, description=excluded.description, order_number=excluded.order_number, is_active=true;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-01', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 01', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 1, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-01-01', 'act-mat-4i-maestro-01', 'Para ordenar, debes juntar los semillas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-02', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 02', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 2, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-02-01', 'act-mat-4i-maestro-02', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-03', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 03', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 3, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-03-01', 'act-mat-4i-maestro-03', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "triángulo", "value": "triángulo"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-04', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 04', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 4, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-04-01', 'act-mat-4i-maestro-04', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-05', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 05', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 5, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-05-01', 'act-mat-4i-maestro-05', 'Luis tiene 1 bloques y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-06', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 06', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 6, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-06-01', 'act-mat-4i-maestro-06', 'Para ordenar, debes juntar los crayones de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-07', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 07', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 7, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-07-01', 'act-mat-4i-maestro-07', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-08', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 08', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 8, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-08-01', 'act-mat-4i-maestro-08', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "rectángulo", "value": "rectángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-09', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 09', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 9, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-09-01', 'act-mat-4i-maestro-09', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-10', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 10', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 10, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-10-01', 'act-mat-4i-maestro-10', 'Luis tiene 1 tapitas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-11', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 11', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 11, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-11-01', 'act-mat-4i-maestro-11', 'Para ordenar, debes juntar los muñecos de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-12', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 12', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 12, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-12-01', 'act-mat-4i-maestro-12', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-13', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 13', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 13, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-13-01', 'act-mat-4i-maestro-13', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "círculo", "value": "círculo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-14', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 14', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 14, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-14-01', 'act-mat-4i-maestro-14', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-15', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 15', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 15, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-15-01', 'act-mat-4i-maestro-15', 'Luis tiene 1 pelotas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-16', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 16', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 16, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-16-01', 'act-mat-4i-maestro-16', 'Para ordenar, debes juntar los cuentos de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-17', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 17', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 17, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-17-01', 'act-mat-4i-maestro-17', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-18', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 18', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 18, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-18-01', 'act-mat-4i-maestro-18', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "cuadrado", "value": "cuadrado"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-19', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 19', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 19, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-19-01', 'act-mat-4i-maestro-19', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-20', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 20', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 20, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-20-01', 'act-mat-4i-maestro-20', 'Luis tiene 1 hojas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-21', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 21', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 21, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-21-01', 'act-mat-4i-maestro-21', 'Para ordenar, debes juntar los bloques de color amarillo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'amarillo', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-22', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 22', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 22, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-22-01', 'act-mat-4i-maestro-22', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-23', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 23', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 23, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-23-01', 'act-mat-4i-maestro-23', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "triángulo", "value": "triángulo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-24', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 24', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 24, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-24-01', 'act-mat-4i-maestro-24', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "cerca", "value": "cerca"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-25', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 25', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 25, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-25-01', 'act-mat-4i-maestro-25', 'Luis tiene 1 semillas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-26', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 26', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 26, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-26-01', 'act-mat-4i-maestro-26', 'Para ordenar, debes juntar los tapitas de color azul. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-27', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 27', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 27, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-27-01', 'act-mat-4i-maestro-27', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "azul", "value": "azul"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-28', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 28', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 28, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-28-01', 'act-mat-4i-maestro-28', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "rectángulo", "value": "rectángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-29', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 29', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 29, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-29-01', 'act-mat-4i-maestro-29', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "lejos", "value": "lejos"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-30', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 30', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 30, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-30-01', 'act-mat-4i-maestro-30', 'Luis tiene 1 crayones y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-31', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 31', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 31, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-31-01', 'act-mat-4i-maestro-31', 'Para ordenar, debes juntar los pelotas de color rojo. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'rojo', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-32', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 32', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 32, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-32-01', 'act-mat-4i-maestro-32', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "rojo", "value": "rojo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-33', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 33', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 33, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-33-01', 'act-mat-4i-maestro-33', 'El cartel del aula tiene forma de círculo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'círculo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "círculo", "value": "círculo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-34', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 34', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 34, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-34-01', 'act-mat-4i-maestro-34', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "cerca", "value": "cerca"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-35', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 35', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 35, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-35-01', 'act-mat-4i-maestro-35', 'Luis tiene 1 muñecos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-36', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 36', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 36, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-36-01', 'act-mat-4i-maestro-36', 'Para ordenar, debes juntar los hojas de color morado. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'morado', '[{"id": "a", "label": "grande", "value": "grande"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-37', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 37', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 37, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-37-01', 'act-mat-4i-maestro-37', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "azul", "value": "azul"}, {"id": "b", "label": "verde", "value": "verde"}, {"id": "c", "label": "amarillo", "value": "amarillo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-38', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 38', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 38, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-38-01', 'act-mat-4i-maestro-38', 'El cartel del aula tiene forma de cuadrado. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'cuadrado', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "cuadrado", "value": "cuadrado"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-39', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 39', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 39, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-39-01', 'act-mat-4i-maestro-39', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "debajo", "value": "debajo"}, {"id": "b", "label": "lejos", "value": "lejos"}, {"id": "c", "label": "arriba", "value": "arriba"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-40', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 40', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 40, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-40-01', 'act-mat-4i-maestro-40', 'Luis tiene 1 cuentos y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "2", "value": "2"}, {"id": "b", "label": "1", "value": "1"}, {"id": "c", "label": "3", "value": "3"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-41', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 41', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 41, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-41-01', 'act-mat-4i-maestro-41', 'Para ordenar, debes juntar los semillas de color naranja. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'naranja', '[{"id": "a", "label": "rojo", "value": "rojo"}, {"id": "b", "label": "grande", "value": "grande"}, {"id": "c", "label": "naranja", "value": "naranja"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-42', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 42', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 42, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-42-01', 'act-mat-4i-maestro-42', 'Completa el patrón: rojo, azul, rojo, azul, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'rojo', '[{"id": "a", "label": "amarillo", "value": "amarillo"}, {"id": "b", "label": "rojo", "value": "rojo"}, {"id": "c", "label": "verde", "value": "verde"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-43', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 43', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 43, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-43-01', 'act-mat-4i-maestro-43', 'El cartel del aula tiene forma de triángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'triángulo', '[{"id": "a", "label": "triángulo", "value": "triángulo"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-44', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 44', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 44, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-44-01', 'act-mat-4i-maestro-44', 'La lonchera está cerca de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'cerca', '[{"id": "a", "label": "arriba", "value": "arriba"}, {"id": "b", "label": "debajo", "value": "debajo"}, {"id": "c", "label": "cerca", "value": "cerca"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-45', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 45', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 45, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-45-01', 'act-mat-4i-maestro-45', 'Luis tiene 1 bloques y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "3", "value": "3"}, {"id": "b", "label": "2", "value": "2"}, {"id": "c", "label": "1", "value": "1"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-46', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 46', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 46, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-46-01', 'act-mat-4i-maestro-46', 'Para ordenar, debes juntar los crayones de color verde. ¿Qué debes buscar?', 'Clasifica por color.', 'single-choice', 'verde', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "morado", "value": "morado"}, {"id": "c", "label": "grande", "value": "grande"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-47', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 47', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 47, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-47-01', 'act-mat-4i-maestro-47', 'Completa el patrón: azul, rojo, azul, rojo, ¿qué color sigue?', 'Mira cómo se repite la secuencia.', 'single-choice', 'azul', '[{"id": "a", "label": "verde", "value": "verde"}, {"id": "b", "label": "amarillo", "value": "amarillo"}, {"id": "c", "label": "azul", "value": "azul"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-48', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 48', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 48, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-48-01', 'act-mat-4i-maestro-48', 'El cartel del aula tiene forma de rectángulo. ¿Qué forma reconoces?', 'Nombra la figura.', 'single-choice', 'rectángulo', '[{"id": "a", "label": "cuadrado", "value": "cuadrado"}, {"id": "b", "label": "rectángulo", "value": "rectángulo"}, {"id": "c", "label": "círculo", "value": "círculo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-49', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 49', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 49, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-49-01', 'act-mat-4i-maestro-49', 'La lonchera está lejos de la mochila. ¿Dónde está la lonchera?', 'Observa la distancia.', 'single-choice', 'lejos', '[{"id": "a", "label": "lejos", "value": "lejos"}, {"id": "b", "label": "arriba", "value": "arriba"}, {"id": "c", "label": "debajo", "value": "debajo"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;

insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points, is_active) values
('act-mat-4i-maestro-50', 'les-mat-4i-maestro', 'mat-inicial', '4-anios', 'Matemática Inicial 4 años - Misión 50', 'Actividad lúdica de Matemática para inicial 4 años, nivel 🏆 Maestro Genio. Vale 1 punto.', 'quiz', 'maestro', 50, 1, true)
on conflict (id) do update set lesson_id=excluded.lesson_id, subject_id=excluded.subject_id, grade=excluded.grade, title=excluded.title, description=excluded.description, activity_type=excluded.activity_type, difficulty_level_id=excluded.difficulty_level_id, order_number=excluded.order_number, points=excluded.points, is_active=true;

insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number) values
('q-mat-4i-maestro-50-01', 'act-mat-4i-maestro-50', 'Luis tiene 1 tapitas y recibe 1 más. ¿Cuántos tiene ahora?', 'Agrega uno y vuelve a contar.', 'single-choice', '2', '[{"id": "a", "label": "1", "value": "1"}, {"id": "b", "label": "3", "value": "3"}, {"id": "c", "label": "2", "value": "2"}]'::jsonb, '[]'::jsonb, 1)
on conflict (id) do update set activity_id=excluded.activity_id, prompt=excluded.prompt, helper=excluded.helper, question_type=excluded.question_type, correct_answer=excluded.correct_answer, options=excluded.options, pairs=excluded.pairs, order_number=excluded.order_number;
