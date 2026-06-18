-- =============================================================
-- GenioKids - Fix regla de desbloqueo por 75% del nivel anterior
-- Ejecutar en Supabase SQL Editor sobre una base ya creada.
-- Objetivo: impedir que un estudiante registre intentos en un nivel
-- superior si no completó al menos el 75% del nivel anterior.
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

  -- Evita manipulación desde el frontend: se guardan los datos reales de la actividad.
  new.subject_id := v_activity.subject_id;
  new.difficulty_level_id := v_activity.difficulty_level_id;
  new.score := greatest(0, least(100, coalesce(new.score, 0)));
  new.total_questions := greatest(0, coalesce(new.total_questions, 0));
  new.correct_answers := greatest(0, coalesce(new.correct_answers, 0));
  new.stars := greatest(0, least(3, coalesce(new.stars, 0)));

  -- El primer nivel siempre está habilitado.
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

  -- Si no hay actividades configuradas en el nivel anterior, no bloqueamos para evitar deadlock curricular.
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
    and a.is_active = true;

  v_required_completed := ceiling(v_previous_total * 0.75)::int;

  if v_previous_completed < v_required_completed then
    raise exception 'Nivel bloqueado: debes completar al menos el 75%% del nivel anterior (% de % misiones).',
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

-- Opcional, pero recomendado: el RPC también registra usando los datos reales de la actividad.
create or replace function public.submit_child_attempt(
  p_session_token uuid,
  p_activity_id text,
  p_subject_id text,
  p_difficulty_level_id text,
  p_score int,
  p_total_questions int,
  p_correct_answers int,
  p_stars int
)
returns uuid
language plpgsql
security definer set search_path = public
as $$
declare
  v_student_id uuid;
  v_attempt_id uuid;
begin
  select cs.student_id into v_student_id
  from public.child_sessions cs
  where cs.session_token = p_session_token and cs.expires_at > now();

  if v_student_id is null then
    raise exception 'Sesión de hijo vencida o inválida.';
  end if;

  insert into public.activity_attempts (
    student_id,
    activity_id,
    subject_id,
    difficulty_level_id,
    score,
    total_questions,
    correct_answers,
    stars
  )
  values (
    v_student_id,
    p_activity_id,
    coalesce(p_subject_id, ''),
    coalesce(p_difficulty_level_id, ''),
    p_score,
    p_total_questions,
    p_correct_answers,
    p_stars
  )
  returning id into v_attempt_id;

  return v_attempt_id;
end;
$$;

grant execute on function public.submit_child_attempt(uuid, text, text, text, int, int, int, int) to anon, authenticated;
