-- =============================================================
-- GenioKids - Seed full curriculum gamificado
-- Genera:
-- - Inicial 3, 4 y 5 años
-- - Primaria 1.º a 6.º grado
-- - 6 cursos por ruta
-- - 5 niveles de dificultad
-- - 20 actividades por curso, grado y nivel
-- Total aproximado: 5,400 actividades + 5,400 preguntas.
-- Ejecutar después de schema.sql.
-- =============================================================

insert into public.difficulty_levels (id, name, short_name, stage_label, description, icon, color, order_number) values
('semilla','Semilla Genial','Básico','Nivel 1','Primer contacto: ejercicios simples, visuales y seguros para ganar confianza.','🌱','#55efc4',1),
('explorador','Explorador Curioso','Fácil','Nivel 2','Retos cortos para reconocer patrones, vocabulario y operaciones esenciales.','🔎','#74b9ff',2),
('aventurero','Aventurero Ágil','Medio','Nivel 3','Actividades con más análisis, comprensión y toma de decisiones.','🧭','#a29bfe',3),
('estrella','Estrella Brillante','Avanzado','Nivel 4','Desafíos para consolidar el aprendizaje y subir el estándar.','⭐','#fdcb6e',4),
('maestro','Maestro Genio','Experto','Nivel 5','Misiones de alto rendimiento para dominar el curso con seguridad.','🏆','#ff7675',5)
on conflict (id) do update set
  name = excluded.name,
  short_name = excluded.short_name,
  stage_label = excluded.stage_label,
  description = excluded.description,
  icon = excluded.icon,
  color = excluded.color,
  order_number = excluded.order_number,
  is_active = true;

insert into public.subjects (id, name, area, level, grades, icon, color, description) values
('mat-inicial','Números divertidos','matematica','inicial',array['3-anios','4-anios','5-anios'],'🔢','#ff7675','Conteo, tamaños, formas, patrones y primeras sumas con juegos visuales.'),
('com-inicial','Vocales y cuentos','comunicacion','inicial',array['3-anios','4-anios','5-anios'],'📚','#fdcb6e','Vocales, sonidos, cuentos cortos, trazos y palabras con apoyo visual.'),
('eng-inicial','English Kids','ingles','inicial',array['3-anios','4-anios','5-anios'],'🌈','#74b9ff','Colores, animales, números, saludos y palabras básicas en inglés.'),
('sci-inicial','Mi mundo natural','ciencia','inicial',array['3-anios','4-anios','5-anios'],'🌿','#00cec9','Animales, plantas, cuerpo humano, clima y cuidado del ambiente con imágenes.'),
('logic-inicial','Juegos de lógica','razonamiento','inicial',array['3-anios','4-anios','5-anios'],'🧩','#fab1a0','Memoria visual, clasificación, secuencias simples y atención.'),
('games-inicial','Mini juegos','juegos','inicial',array['3-anios','4-anios','5-anios'],'🎮','#e17055','Juegos cortos para reforzar números, colores, vocales y concentración.'),
('mat-primaria','Matemática','matematica','primaria',array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'],'🧮','#6c5ce7','Operaciones, problemas, fracciones, geometría, porcentajes, proporcionalidad y estadística.'),
('com-primaria','Comunicación','comunicacion','primaria',array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'],'✍️','#00b894','Lectoescritura, comprensión lectora, gramática, ortografía y producción de textos.'),
('eng-primaria','Inglés','ingles','primaria',array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'],'🗣️','#0984e3','Vocabulario, frases simples, verb to be, present simple y práctica guiada.'),
('sci-primaria','Ciencia y ambiente','ciencia','primaria',array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'],'🔬','#00cec9','Seres vivos, sentidos, salud, ecosistemas, materia, energía y cuidado del ambiente.'),
('logic-primaria','Razonamiento','razonamiento','primaria',array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'],'🧠','#a29bfe','Patrones, series, memoria, clasificación, inferencias y pensamiento lógico.'),
('games-primaria','Juegos educativos','juegos','primaria',array['1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria'],'🎮','#e17055','Retos gamificados para reforzar cálculo, lectura, vocabulario y atención.')
on conflict (id) do update set
  name = excluded.name,
  area = excluded.area,
  level = excluded.level,
  grades = excluded.grades,
  icon = excluded.icon,
  color = excluded.color,
  description = excluded.description,
  is_active = true;

-- Generador curricular: crea 20 actividades por nivel.
do $$
declare
  subj record;
  lvl record;
  grade text;
  grade_suffix text;
  lesson_id text;
  activity_id text;
  question_id text;
  i int;
  base_num int;
  correct text;
  wrong_a text;
  wrong_b text;
  prompt_text text;
  helper_text text;
  question_type_value text;
  activity_type_value text;
  options_value jsonb;
  pairs_value jsonb;
begin
  for subj in select * from public.subjects order by level, id loop
    foreach grade in array subj.grades loop
      grade_suffix := replace(replace(grade, '-anios', 'a'), '-primaria', 'p');

      for lvl in select * from public.difficulty_levels order by order_number loop
        lesson_id := 'les-' || subj.id || '-' || grade_suffix || '-' || lvl.id;

        insert into public.lessons (id, subject_id, grade, difficulty_level_id, title, description, order_number)
        values (
          lesson_id,
          subj.id,
          grade,
          lvl.id,
          lvl.icon || ' ' || lvl.name,
          'Ruta ' || lower(lvl.short_name) || ' con 20 actividades progresivas para ' || subj.name || '.',
          lvl.order_number
        )
        on conflict (id) do update set
          subject_id = excluded.subject_id,
          grade = excluded.grade,
          difficulty_level_id = excluded.difficulty_level_id,
          title = excluded.title,
          description = excluded.description,
          order_number = excluded.order_number,
          is_active = true;

        for i in 1..20 loop
          activity_id := 'act-' || subj.id || '-' || grade_suffix || '-' || lvl.id || '-' || lpad(i::text, 2, '0');
          question_id := 'q-' || activity_id || '-1';
          base_num := i + lvl.order_number;
          pairs_value := '[]'::jsonb;
          options_value := '[]'::jsonb;
          question_type_value := 'single-choice';
          activity_type_value := 'quiz';

          if subj.area = 'matematica' then
            correct := (base_num + lvl.order_number + 1)::text;
            wrong_a := (base_num + lvl.order_number)::text;
            wrong_b := (base_num + lvl.order_number + 2)::text;
            prompt_text := 'Resuelve: ' || base_num || ' + ' || (lvl.order_number + 1) || ' = __';
            helper_text := 'Cuenta con calma y elige la respuesta correcta.';
            options_value := jsonb_build_array(
              jsonb_build_object('id','a','label',wrong_a,'value',wrong_a),
              jsonb_build_object('id','b','label',correct,'value',correct),
              jsonb_build_object('id','c','label',wrong_b,'value',wrong_b)
            );
          elsif subj.area = 'comunicacion' then
            correct := 'niña';
            prompt_text := 'Lee: “La niña canta en casa.” ¿Quién canta?';
            helper_text := 'Busca la persona que realiza la acción.';
            options_value := jsonb_build_array(
              jsonb_build_object('id','a','label','casa','value','casa'),
              jsonb_build_object('id','b','label','niña','value','niña'),
              jsonb_build_object('id','c','label','canta','value','canta')
            );
            if i % 6 = 0 then
              question_type_value := 'match';
              activity_type_value := 'matching';
              correct := 'completed';
              prompt_text := 'Relaciona cada palabra con su tipo.';
              helper_text := 'Une palabra con categoría.';
              options_value := '[]'::jsonb;
              pairs_value := jsonb_build_array(
                jsonb_build_object('left','niña','right','sustantivo'),
                jsonb_build_object('left','canta','right','verbo'),
                jsonb_build_object('left','alegre','right','adjetivo')
              );
            end if;
          elsif subj.area = 'ingles' then
            correct := 'azul';
            prompt_text := 'What does “blue” mean?';
            helper_text := 'Recuerda los colores en inglés.';
            options_value := jsonb_build_array(
              jsonb_build_object('id','a','label','Rojo','value','rojo'),
              jsonb_build_object('id','b','label','Azul','value','azul'),
              jsonb_build_object('id','c','label','Verde','value','verde')
            );
            if i % 5 = 0 then
              question_type_value := 'match';
              activity_type_value := 'matching';
              correct := 'completed';
              prompt_text := 'Relaciona las palabras en inglés con español.';
              helper_text := 'Une cada palabra con su significado.';
              options_value := '[]'::jsonb;
              pairs_value := jsonb_build_array(
                jsonb_build_object('left','Dog','right','Perro'),
                jsonb_build_object('left','Cat','right','Gato'),
                jsonb_build_object('left','Blue','right','Azul')
              );
            end if;
          elsif subj.area = 'ciencia' then
            correct := 'agua';
            prompt_text := '¿Qué necesita una planta para vivir?';
            helper_text := 'Piensa en lo que ayuda a crecer a las plantas.';
            options_value := jsonb_build_array(
              jsonb_build_object('id','a','label','Piedra','value','piedra'),
              jsonb_build_object('id','b','label','Agua','value','agua'),
              jsonb_build_object('id','c','label','Plástico','value','plastico')
            );
          elsif subj.area = 'razonamiento' then
            correct := (base_num + 2)::text;
            wrong_a := base_num::text;
            wrong_b := (base_num + 3)::text;
            prompt_text := 'Completa la serie: ' || base_num || ', ' || (base_num + 1) || ', __';
            helper_text := 'La serie aumenta de uno en uno.';
            options_value := jsonb_build_array(
              jsonb_build_object('id','a','label',wrong_a,'value',wrong_a),
              jsonb_build_object('id','b','label',correct,'value',correct),
              jsonb_build_object('id','c','label',wrong_b,'value',wrong_b)
            );
          else
            correct := 'estrella';
            question_type_value := 'visual-choice';
            activity_type_value := 'memory';
            prompt_text := 'Reto rápido: elige la estrella correcta.';
            helper_text := 'Observa las opciones y toca la estrella.';
            options_value := jsonb_build_array(
              jsonb_build_object('id','a','label','Luna','value','luna','image','🌙'),
              jsonb_build_object('id','b','label','Estrella','value','estrella','image','⭐'),
              jsonb_build_object('id','c','label','Sol','value','sol','image','☀️')
            );
          end if;

          insert into public.activities (id, lesson_id, subject_id, grade, title, description, activity_type, difficulty_level_id, order_number, points)
          values (
            activity_id,
            lesson_id,
            subj.id,
            grade,
            'Misión ' || lpad(i::text, 2, '0') || ': ' || lvl.name,
            'Actividad ' || i || ' de 20 del nivel ' || lvl.short_name || '. Cada misión vale 1 punto.',
            activity_type_value,
            lvl.id,
            i,
            1
          )
          on conflict (id) do update set
            lesson_id = excluded.lesson_id,
            subject_id = excluded.subject_id,
            grade = excluded.grade,
            title = excluded.title,
            description = excluded.description,
            activity_type = excluded.activity_type,
            difficulty_level_id = excluded.difficulty_level_id,
            order_number = excluded.order_number,
            points = excluded.points,
            is_active = true;

          insert into public.questions (id, activity_id, prompt, helper, question_type, correct_answer, options, pairs, order_number)
          values (
            question_id,
            activity_id,
            prompt_text,
            helper_text,
            question_type_value,
            correct,
            options_value,
            pairs_value,
            1
          )
          on conflict (id) do update set
            activity_id = excluded.activity_id,
            prompt = excluded.prompt,
            helper = excluded.helper,
            question_type = excluded.question_type,
            correct_answer = excluded.correct_answer,
            options = excluded.options,
            pairs = excluded.pairs,
            order_number = excluded.order_number;
        end loop;
      end loop;
    end loop;
  end loop;
end $$;

insert into public.badges (id, name, description, icon, requirement, color, category, order_number) values
('badge-first-mission','Primera Chispa','Completó su primera misión.','✨','Completar 1 actividad.','#55efc4','avance',1),
('badge-10-missions','Racha de 10','Terminó 10 actividades. Esto ya huele a hábito.','🔥','Completar 10 actividades.','#fab1a0','constancia',2),
('badge-20-level','Nivel Cerrado','Completó 20 actividades, equivalente a un nivel completo.','🎯','Completar 20 actividades.','#74b9ff','nivel',3),
('badge-50-missions','Máquina de Aprender','Superó 50 misiones educativas.','🚀','Completar 50 actividades.','#a29bfe','constancia',4),
('badge-star-collector','Coleccionista de Estrellas','Acumuló 30 estrellas en sus prácticas.','🌟','Ganar 30 estrellas.','#fdcb6e','constancia',5),
('badge-perfect-score','Respuesta Perfecta','Obtuvo 100% en una actividad.','🏆','Obtener 100% en una actividad.','#fdcb6e','excelencia',6),
('badge-semilla','Semilla Activada','Entró al primer nivel de aprendizaje.','🌱','Completar una misión Semilla Genial.','#55efc4','nivel',7),
('badge-explorador','Explorador en Ruta','Ya empezó a explorar nuevos retos.','🔎','Completar una misión Explorador Curioso.','#74b9ff','nivel',8),
('badge-aventurero','Aventurero Ágil','Se atrevió con retos de nivel medio.','🧭','Completar una misión Aventurero Ágil.','#a29bfe','nivel',9),
('badge-estrella','Estrella Brillante','Ingresó a retos avanzados.','⭐','Completar una misión Estrella Brillante.','#fdcb6e','nivel',10),
('badge-master-genius','Maestro Genio','Llegó a actividades del nivel experto.','👑','Completar una misión Maestro Genio.','#ff7675','nivel',11),
('badge-math-genius','Genio Numérico','Destaca en retos de matemática.','🧮','Completar matemática con 80% o más.','#6c5ce7','curso',12),
('badge-reader','Lector Curioso','Avanza en comunicación y comprensión.','📖','Completar una actividad de comunicación.','#00b894','curso',13),
('badge-english','Hello Champion','Practica inglés con éxito.','🗣️','Completar una actividad de inglés.','#0984e3','curso',14),
('badge-science','Mini Científico','Explora ciencia y ambiente.','🔬','Completar una actividad de ciencia.','#00cec9','curso',15)
on conflict (id) do update set
  name = excluded.name,
  description = excluded.description,
  icon = excluded.icon,
  requirement = excluded.requirement,
  color = excluded.color,
  category = excluded.category,
  order_number = excluded.order_number;
