-- =============================================================
-- GenioKids - Fix reintentos y estado real de actividad
-- Ejecutar en Supabase SQL Editor sobre una base ya creada.
--
-- Objetivo:
-- 1) Permitir registrar intentos fallidos para que la actividad pueda mostrarse con ❌.
-- 2) Contar para el desbloqueo del 75% solo actividades completadas correctamente.
-- =============================================================

create or replace function public.enforce_level_75_unlock()
returns trigger
language plpgsql
security definer set search_path = public
as $$
declare
  v_activity record;
  v_student_grade text;
  v_previous_level_id text;
  v_previous_total int := 0;
  v_previous_completed int := 0;
  v_required_completed int := 0;
begin
  select
    a.id,
    a.subject_id,
    a.grade,
    a.difficulty_level_id,
    dl.order_number as level_order
  into v_activity
  from public.activities a
  join public.difficulty_levels dl on dl.id = a.difficulty_level_id
  where a.id = new.activity_id
    and a.is_active = true
    and dl.is_active = true
  limit 1;

  if v_activity.id is null then
    raise exception 'Actividad inválida o inactiva.';
  end if;

  select s.grade into v_student_grade
  from public.students s
  where s.id = new.student_id
    and s.is_active = true;

  if v_student_grade is null then
    raise exception 'Estudiante inválido o inactivo.';
  end if;

  if v_student_grade <> v_activity.grade then
    raise exception 'La actividad no corresponde al grado del estudiante.';
  end if;

  new.subject_id := v_activity.subject_id;
  new.difficulty_level_id := v_activity.difficulty_level_id;
  new.score := greatest(0, least(100, coalesce(new.score, 0)));
  new.total_questions := greatest(0, coalesce(new.total_questions, 0));
  new.correct_answers := greatest(0, coalesce(new.correct_answers, 0));
  new.stars := greatest(0, least(3, coalesce(new.stars, 0)));

  if v_activity.level_order <= 1 then
    return new;
  end if;

  select dl.id into v_previous_level_id
  from public.difficulty_levels dl
  where dl.order_number = v_activity.level_order - 1
    and dl.is_active = true
  limit 1;

  if v_previous_level_id is null then
    return new;
  end if;

  select count(*) into v_previous_total
  from public.activities a
  where a.subject_id = v_activity.subject_id
    and a.grade = v_activity.grade
    and a.difficulty_level_id = v_previous_level_id
    and a.is_active = true;

  if coalesce(v_previous_total, 0) = 0 then
    return new;
  end if;

  select count(distinct aa.activity_id) into v_previous_completed
  from public.activity_attempts aa
  join public.activities a on a.id = aa.activity_id
  where aa.student_id = new.student_id
    and a.subject_id = v_activity.subject_id
    and a.grade = v_activity.grade
    and a.difficulty_level_id = v_previous_level_id
    and a.is_active = true
    and (
      (coalesce(aa.total_questions, 0) > 0 and coalesce(aa.correct_answers, 0) >= coalesce(aa.total_questions, 0))
      or coalesce(aa.score, 0) >= 100
    );

  v_required_completed := ceiling(v_previous_total * 0.75)::int;

  if v_previous_completed < v_required_completed then
    raise exception 'Nivel bloqueado: debes completar correctamente al menos el 75%% del nivel anterior (% de % misiones).',
      v_required_completed,
      v_previous_total;
  end if;

  return new;
end;
$$;

drop trigger if exists trg_enforce_level_75_unlock on public.activity_attempts;

create trigger trg_enforce_level_75_unlock
before insert on public.activity_attempts
for each row
execute function public.enforce_level_75_unlock();

-- Nota operativa:
-- Los intentos fallidos pueden existir en activity_attempts, pero no cuentan como progreso.
-- El frontend los usa solo para mostrar ❌ y pedir reintento.
