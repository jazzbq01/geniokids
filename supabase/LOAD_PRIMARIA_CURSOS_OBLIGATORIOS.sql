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
