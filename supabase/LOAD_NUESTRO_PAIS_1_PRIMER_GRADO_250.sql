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
