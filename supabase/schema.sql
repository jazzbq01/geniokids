-- =============================================================
-- GenioKids - Schema base con roles Padre/Hijo, niveles bloqueados y Supabase Auth
-- Ejecutar en Supabase SQL Editor.
-- ADVERTENCIA: elimina y recrea las tablas del proyecto GenioKids.
-- =============================================================

create extension if not exists pgcrypto with schema extensions;

-- -----------------------------
-- 0. Limpieza total
-- -----------------------------
drop view if exists public.student_progress_report cascade;
do $$
begin
  if to_regclass('public.activity_attempts') is not null then
    drop trigger if exists trg_enforce_level_75_unlock on public.activity_attempts;
  end if;
end;
$$;
drop function if exists public.enforce_level_75_unlock() cascade;
drop view if exists public.student_level_progress_report cascade;
drop trigger if exists on_auth_user_created on auth.users;
drop function if exists public.handle_new_user() cascade;
drop function if exists public.create_child_student(text, int, text, text, text, text, text) cascade;
drop function if exists public.update_child_student(uuid, text, int, text, text, text, text, text) cascade;
drop function if exists public.login_child(text, text) cascade;
drop function if exists public.get_child_attempts(uuid) cascade;
drop function if exists public.get_child_attempts() cascade;
drop function if exists public.submit_child_attempt(uuid, text, text, text, int, int, int, int) cascade;
drop function if exists public.submit_child_attempt(text, int, text, int, int, text, int) cascade;

drop table if exists public.parent_notes cascade;
drop table if exists public.daily_sessions cascade;
drop table if exists public.student_badges cascade;
drop table if exists public.badges cascade;
drop table if exists public.activity_attempts cascade;
drop table if exists public.questions cascade;
drop table if exists public.activities cascade;
drop table if exists public.lessons cascade;
drop table if exists public.subjects cascade;
drop table if exists public.difficulty_levels cascade;
drop table if exists public.child_sessions cascade;
drop table if exists public.child_credentials cascade;
drop table if exists public.students cascade;
drop table if exists public.profiles cascade;

-- -----------------------------
-- 1. Perfil del padre/madre
-- -----------------------------
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  phone text,
  role text not null default 'parent' check (role = 'parent'),
  created_at timestamptz not null default now()
);

-- -----------------------------
-- 2. Estudiantes / usuarios hijos
-- -----------------------------
create table public.students (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  age int not null check (age between 3 and 13),
  grade text not null check (grade in ('3-anios','4-anios','5-anios','1-primaria','2-primaria','3-primaria','4-primaria','5-primaria','6-primaria')),
  level text not null check (level in ('inicial','primaria')),
  gender text not null default 'other' check (gender in ('female','male','other')),
  avatar text not null default '🧒🏻',
  child_username text not null unique,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.child_credentials (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null unique references public.students(id) on delete cascade,
  parent_id uuid not null references auth.users(id) on delete cascade,
  child_username text not null unique,
  pin_hash text not null,
  is_active boolean not null default true,
  last_login_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Sesiones temporales del usuario hijo.
create table public.child_sessions (
  session_token uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  parent_id uuid not null references auth.users(id) on delete cascade,
  expires_at timestamptz not null default now() + interval '12 hours',
  created_at timestamptz not null default now()
);

-- -----------------------------
-- 3. Niveles de dificultad gamificados
-- -----------------------------
create table public.difficulty_levels (
  id text primary key check (id in ('semilla','explorador','aventurero','estrella','maestro')),
  name text not null,
  short_name text not null,
  stage_label text not null,
  description text,
  icon text not null,
  color text not null,
  order_number int not null unique,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

-- -----------------------------
-- 4. Cursos
-- -----------------------------
create table public.subjects (
  id text primary key,
  name text not null,
  area text not null check (area in ('matematica','comunicacion','ingles','ciencia','ciencia_tecnologia','razonamiento','juegos','nuestro_pais','educacion_financiera','tutoria','personal_social','psicomotriz','arte_creatividad')),
  level text not null check (level in ('inicial','primaria')),
  grades text[] not null,
  icon text not null,
  color text not null,
  description text,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

-- -----------------------------
-- 5. Lecciones por curso, grado y nivel
-- -----------------------------
create table public.lessons (
  id text primary key,
  subject_id text not null references public.subjects(id) on delete cascade,
  grade text not null,
  difficulty_level_id text not null references public.difficulty_levels(id),
  title text not null,
  description text,
  order_number int not null default 1,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique(subject_id, grade, difficulty_level_id)
);

-- -----------------------------
-- 6. Actividades / misiones
-- -----------------------------
create table public.activities (
  id text primary key,
  lesson_id text not null references public.lessons(id) on delete cascade,
  subject_id text not null references public.subjects(id) on delete cascade,
  grade text not null,
  title text not null,
  description text,
  activity_type text not null check (activity_type in ('quiz','matching','memory','trace','story','drag-drop')),
  difficulty_level_id text not null references public.difficulty_levels(id),
  order_number int not null check (order_number between 1 and 50),
  points int not null default 1 check (points >= 1),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique(lesson_id, order_number)
);

-- -----------------------------
-- 7. Preguntas
-- -----------------------------
create table public.questions (
  id text primary key,
  activity_id text not null references public.activities(id) on delete cascade,
  prompt text not null,
  helper text,
  question_type text not null check (question_type in ('single-choice','match','visual-choice','text')),
  image_url text,
  audio_url text,
  correct_answer text,
  options jsonb not null default '[]'::jsonb,
  pairs jsonb not null default '[]'::jsonb,
  order_number int not null default 1,
  created_at timestamptz not null default now()
);

-- -----------------------------
-- 8. Intentos / calificaciones
-- -----------------------------
create table public.activity_attempts (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  activity_id text not null references public.activities(id) on delete cascade,
  subject_id text not null references public.subjects(id) on delete cascade,
  difficulty_level_id text not null references public.difficulty_levels(id),
  score int not null check (score between 0 and 100),
  total_questions int not null default 0,
  correct_answers int not null default 0,
  stars int not null default 0 check (stars between 0 and 3),
  completed_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);


-- -----------------------------
-- 8.1 Regla de desbloqueo de niveles
-- -----------------------------
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
    and a.is_active = true
    and (
      (coalesce(aa.total_questions, 0) > 0 and coalesce(aa.correct_answers, 0) >= coalesce(aa.total_questions, 0))
      or coalesce(aa.score, 0) >= 100
    );

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
    and a.is_active = true
    and (
      (coalesce(aa.total_questions, 0) > 0 and coalesce(aa.correct_answers, 0) >= coalesce(aa.total_questions, 0))
      or coalesce(aa.score, 0) >= 100
    );

  v_required_completed := ceiling(v_previous_total * 0.75)::int;

  if v_previous_completed < v_required_completed then
    raise exception 'Nivel bloqueado: debes completar al menos el 75%% del nivel anterior (% de % misiones).',
      v_required_completed,
      v_previous_total;
  end if;

  return new;
end;
$$;

create trigger trg_enforce_level_75_unlock
before insert on public.activity_attempts
for each row
execute function public.enforce_level_75_unlock();

-- -----------------------------
-- 9. Medallas
-- -----------------------------
create table public.badges (
  id text primary key,
  name text not null,
  description text,
  icon text not null,
  requirement text,
  color text,
  category text check (category in ('avance','curso','nivel','constancia','excelencia')),
  order_number int not null default 1,
  created_at timestamptz not null default now()
);

create table public.student_badges (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  badge_id text not null references public.badges(id) on delete cascade,
  unlocked_at timestamptz not null default now(),
  unique(student_id, badge_id)
);

-- -----------------------------
-- 10. Sesiones diarias y notas de padres
-- -----------------------------
create table public.daily_sessions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  started_at timestamptz not null default now(),
  ended_at timestamptz,
  minutes int default 0,
  notes text
);

create table public.parent_notes (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid not null references auth.users(id) on delete cascade,
  student_id uuid references public.students(id) on delete cascade,
  note text not null,
  created_at timestamptz not null default now()
);

-- -----------------------------
-- Índices
-- -----------------------------
create index idx_students_parent on public.students(parent_id);
create index idx_students_username on public.students(child_username);
create index idx_child_credentials_student on public.child_credentials(student_id);
create index idx_child_credentials_parent on public.child_credentials(parent_id);
create index idx_child_credentials_username on public.child_credentials(child_username);
create index idx_child_sessions_student on public.child_sessions(student_id);
create index idx_child_sessions_expires on public.child_sessions(expires_at);
create index idx_subjects_grades on public.subjects using gin(grades);
create index idx_lessons_subject_grade_level on public.lessons(subject_id, grade, difficulty_level_id);
create index idx_activities_subject_grade_level on public.activities(subject_id, grade, difficulty_level_id);
create index idx_activities_lesson_order on public.activities(lesson_id, order_number);
create index idx_questions_activity on public.questions(activity_id);
create index idx_attempts_student on public.activity_attempts(student_id);
create index idx_attempts_subject on public.activity_attempts(subject_id);
create index idx_attempts_level on public.activity_attempts(difficulty_level_id);
create index idx_attempts_completed_at on public.activity_attempts(completed_at desc);

-- -----------------------------
-- Reportes para padres
-- -----------------------------
create view public.student_progress_report as
select
  s.parent_id,
  s.id as student_id,
  s.name as student_name,
  s.grade,
  sub.name as subject_name,
  a.subject_id,
  count(a.id) as completed_activities,
  round(avg(a.score))::int as average_score,
  sum(a.stars)::int as total_stars,
  sum(act.points)::int as total_points,
  max(a.completed_at) as last_activity_at
from public.students s
left join public.activity_attempts a on a.student_id = s.id
left join public.subjects sub on sub.id = a.subject_id
left join public.activities act on act.id = a.activity_id
group by s.parent_id, s.id, s.name, s.grade, sub.name, a.subject_id;

create view public.student_level_progress_report as
select
  s.parent_id,
  s.id as student_id,
  s.name as student_name,
  a.subject_id,
  sub.name as subject_name,
  a.difficulty_level_id,
  dl.name as difficulty_name,
  count(a.id) as completed_activities,
  round(avg(a.score))::int as average_score,
  sum(a.stars)::int as total_stars,
  max(a.completed_at) as last_activity_at
from public.students s
left join public.activity_attempts a on a.student_id = s.id
left join public.subjects sub on sub.id = a.subject_id
left join public.difficulty_levels dl on dl.id = a.difficulty_level_id
group by s.parent_id, s.id, s.name, a.subject_id, sub.name, a.difficulty_level_id, dl.name;

-- -----------------------------
-- Funciones Auth y usuario hijo
-- -----------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, role)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', 'Familia GenioKids'), 'parent')
  on conflict (id) do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

create or replace function public.avatar_for_child(p_gender text, p_level text)
returns text
language sql
immutable
as $$
  select case
    when p_gender = 'female' and p_level = 'inicial' then '👧🏻'
    when p_gender = 'female' then '👩🏻‍🎓'
    when p_gender = 'male' and p_level = 'inicial' then '👦🏻'
    when p_gender = 'male' then '👨🏻‍🎓'
    else '🧒🏻'
  end;
$$;

create or replace function public.create_child_student(
  p_name text,
  p_age int,
  p_grade text,
  p_level text,
  p_gender text,
  p_child_username text,
  p_pin text
)
returns table (
  id uuid,
  parent_id uuid,
  name text,
  age int,
  grade text,
  level text,
  avatar text,
  gender text,
  child_username text
)
language plpgsql
security definer set search_path = public, extensions
as $$
declare
  v_parent uuid;
  v_username text;
  v_student_id uuid;
begin
  v_parent := auth.uid();
  if v_parent is null then
    raise exception 'Debes iniciar sesión como padre/madre.';
  end if;

  v_username := lower(trim(p_child_username));
  if v_username is null or length(v_username) < 3 then
    raise exception 'El usuario del hijo debe tener mínimo 3 caracteres.';
  end if;

  if p_pin is null or length(p_pin) < 4 then
    raise exception 'La clave del hijo debe tener mínimo 4 caracteres.';
  end if;

  if exists (select 1 from public.child_credentials cc where cc.child_username = v_username) then
    raise exception 'El usuario del hijo ya existe.';
  end if;

  insert into public.students (parent_id, name, age, grade, level, gender, avatar, child_username)
  values (v_parent, trim(p_name), p_age, p_grade, p_level, p_gender, public.avatar_for_child(p_gender, p_level), v_username)
  returning students.id into v_student_id;

  insert into public.child_credentials (student_id, parent_id, child_username, pin_hash)
  values (v_student_id, v_parent, v_username, extensions.crypt(p_pin, extensions.gen_salt('bf')));

  return query
  select s.id, s.parent_id, s.name, s.age, s.grade, s.level, s.avatar, s.gender, s.child_username
  from public.students s
  where s.id = v_student_id;
end;
$$;

create or replace function public.update_child_student(
  p_student_id uuid,
  p_name text,
  p_age int,
  p_grade text,
  p_level text,
  p_gender text,
  p_child_username text,
  p_new_pin text default null
)
returns table (
  id uuid,
  parent_id uuid,
  name text,
  age int,
  grade text,
  level text,
  avatar text,
  gender text,
  child_username text
)
language plpgsql
security definer set search_path = public, extensions
as $$
declare
  v_parent uuid;
  v_username text;
begin
  v_parent := auth.uid();
  if v_parent is null then
    raise exception 'Debes iniciar sesión como padre/madre.';
  end if;

  if not exists (select 1 from public.students s where s.id = p_student_id and s.parent_id = v_parent) then
    raise exception 'No puedes editar este usuario hijo.';
  end if;

  v_username := lower(trim(p_child_username));
  if v_username is null or length(v_username) < 3 then
    raise exception 'El usuario del hijo debe tener mínimo 3 caracteres.';
  end if;

  if exists (
    select 1
    from public.child_credentials cc
    where cc.child_username = v_username
      and cc.student_id <> p_student_id
  ) then
    raise exception 'El usuario del hijo ya está en uso.';
  end if;

  update public.students s
  set
    name = trim(p_name),
    age = p_age,
    grade = p_grade,
    level = p_level,
    gender = p_gender,
    avatar = public.avatar_for_child(p_gender, p_level),
    child_username = v_username,
    updated_at = now()
  where s.id = p_student_id and s.parent_id = v_parent;

  update public.child_credentials cc
  set
    child_username = v_username,
    pin_hash = case when p_new_pin is not null and length(trim(p_new_pin)) >= 4 then extensions.crypt(p_new_pin, extensions.gen_salt('bf')) else cc.pin_hash end,
    updated_at = now()
  where cc.student_id = p_student_id and cc.parent_id = v_parent;

  return query
  select s.id, s.parent_id, s.name, s.age, s.grade, s.level, s.avatar, s.gender, s.child_username
  from public.students s
  where s.id = p_student_id;
end;
$$;

create or replace function public.login_child(p_child_username text, p_pin text)
returns table (
  session_token uuid,
  student_id uuid,
  parent_id uuid,
  name text,
  age int,
  grade text,
  level text,
  avatar text,
  gender text,
  child_username text,
  expires_at timestamptz
)
language plpgsql
security definer set search_path = public, extensions
as $$
declare
  v_student public.students%rowtype;
  v_token uuid;
  v_expires timestamptz;
begin
  select s.* into v_student
  from public.child_credentials cc
  join public.students s on s.id = cc.student_id
  where cc.child_username = lower(trim(p_child_username))
    and cc.is_active = true
    and s.is_active = true
    and extensions.crypt(p_pin, cc.pin_hash) = cc.pin_hash
  limit 1;

  if not found then
    return;
  end if;

  delete from public.child_sessions where expires_at < now();

  update public.child_credentials
  set last_login_at = now(), updated_at = now()
  where student_id = v_student.id;

  insert into public.child_sessions (student_id, parent_id)
  values (v_student.id, v_student.parent_id)
  returning child_sessions.session_token, child_sessions.expires_at into v_token, v_expires;

  return query
  select v_token, v_student.id, v_student.parent_id, v_student.name, v_student.age, v_student.grade,
         v_student.level, v_student.avatar, v_student.gender, v_student.child_username, v_expires;
end;
$$;

create or replace function public.get_child_attempts(p_session_token uuid)
returns table (
  id uuid,
  student_id uuid,
  activity_id text,
  subject_id text,
  difficulty_level_id text,
  score int,
  total_questions int,
  correct_answers int,
  stars int,
  completed_at timestamptz
)
language plpgsql
security definer set search_path = public
as $$
declare
  v_student_id uuid;
begin
  select cs.student_id into v_student_id
  from public.child_sessions cs
  where cs.session_token = p_session_token and cs.expires_at > now();

  if v_student_id is null then
    raise exception 'Sesión de hijo vencida o inválida.';
  end if;

  return query
  select aa.id, aa.student_id, aa.activity_id, aa.subject_id, aa.difficulty_level_id,
         aa.score, aa.total_questions, aa.correct_answers, aa.stars, aa.completed_at
  from public.activity_attempts aa
  where aa.student_id = v_student_id
  order by aa.completed_at desc;
end;
$$;

-- Compatibilidad: si una versión vieja del frontend llama sin parámetros, no rompe la pantalla.
create or replace function public.get_child_attempts()
returns table (
  id uuid,
  student_id uuid,
  activity_id text,
  subject_id text,
  difficulty_level_id text,
  score int,
  total_questions int,
  correct_answers int,
  stars int,
  completed_at timestamptz
)
language sql
security definer set search_path = public
as $$
  select aa.id, aa.student_id, aa.activity_id, aa.subject_id, aa.difficulty_level_id,
         aa.score, aa.total_questions, aa.correct_answers, aa.stars, aa.completed_at
  from public.activity_attempts aa
  order by aa.completed_at desc;
$$;

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
  v_score int;
begin
  select cs.student_id into v_student_id
  from public.child_sessions cs
  where cs.session_token = p_session_token and cs.expires_at > now();

  if v_student_id is null then
    raise exception 'Sesión de hijo vencida o inválida.';
  end if;

  v_score := greatest(0, least(100, coalesce(p_score, 0)));

  insert into public.activity_attempts (student_id, activity_id, subject_id, difficulty_level_id, score, total_questions, correct_answers, stars)
  values (v_student_id, p_activity_id, p_subject_id, p_difficulty_level_id, v_score, p_total_questions, p_correct_answers, p_stars)
  returning id into v_attempt_id;

  return v_attempt_id;
end;
$$;

-- Compatibilidad con llamada antigua sin token. Solo para desarrollo local.
create or replace function public.submit_child_attempt(
  p_activity_id text,
  p_correct_answers int,
  p_difficulty_level_id text,
  p_score int,
  p_stars int,
  p_subject_id text,
  p_total_questions int
)
returns uuid
language plpgsql
security definer set search_path = public
as $$
declare
  v_student_id uuid;
  v_attempt_id uuid;
  v_score int;
begin
  select cs.student_id into v_student_id
  from public.child_sessions cs
  where cs.expires_at > now()
  order by cs.created_at desc
  limit 1;

  if v_student_id is null then
    raise exception 'No hay una sesión de hijo activa. Inicia sesión como hijo.';
  end if;

  v_score := greatest(0, least(100, coalesce(p_score, 0)));

  insert into public.activity_attempts (student_id, activity_id, subject_id, difficulty_level_id, score, total_questions, correct_answers, stars)
  values (v_student_id, p_activity_id, p_subject_id, p_difficulty_level_id, v_score, p_total_questions, p_correct_answers, p_stars)
  returning id into v_attempt_id;

  return v_attempt_id;
end;
$$;

-- -----------------------------
-- Row Level Security
-- -----------------------------
alter table public.profiles enable row level security;
alter table public.students enable row level security;
alter table public.child_credentials enable row level security;
alter table public.child_sessions enable row level security;
alter table public.difficulty_levels enable row level security;
alter table public.subjects enable row level security;
alter table public.lessons enable row level security;
alter table public.activities enable row level security;
alter table public.questions enable row level security;
alter table public.activity_attempts enable row level security;
alter table public.badges enable row level security;
alter table public.student_badges enable row level security;
alter table public.daily_sessions enable row level security;
alter table public.parent_notes enable row level security;

-- Profiles
create policy "profiles_select_own" on public.profiles for select to authenticated using (auth.uid() = id);
create policy "profiles_update_own" on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

-- Students: solo padre dueño puede leer/escribir directo. Hijo accede por RPC.
create policy "students_select_own" on public.students for select to authenticated using (auth.uid() = parent_id);
create policy "students_insert_own" on public.students for insert to authenticated with check (auth.uid() = parent_id);
create policy "students_update_own" on public.students for update to authenticated using (auth.uid() = parent_id) with check (auth.uid() = parent_id);
create policy "students_delete_own" on public.students for delete to authenticated using (auth.uid() = parent_id);

create policy "child_credentials_select_own" on public.child_credentials
for select to authenticated using (auth.uid() = parent_id);

create policy "child_credentials_insert_own" on public.child_credentials
for insert to authenticated with check (auth.uid() = parent_id);

create policy "child_credentials_update_own" on public.child_credentials
for update to authenticated using (auth.uid() = parent_id) with check (auth.uid() = parent_id);

create policy "child_credentials_delete_own" on public.child_credentials
for delete to authenticated using (auth.uid() = parent_id);

-- Content: lectura para anon y authenticated porque el usuario hijo entra por sesión propia.
create policy "difficulty_levels_read_public" on public.difficulty_levels for select to anon, authenticated using (is_active = true);
create policy "subjects_read_public" on public.subjects for select to anon, authenticated using (is_active = true);
create policy "lessons_read_public" on public.lessons for select to anon, authenticated using (is_active = true);
create policy "activities_read_public" on public.activities for select to anon, authenticated using (is_active = true);
create policy "questions_read_public" on public.questions for select to anon, authenticated using (true);
create policy "badges_read_public" on public.badges for select to anon, authenticated using (true);

-- Attempts: padre dueño directo; hijo solo por RPC submit_child_attempt/get_child_attempts.
create policy "attempts_select_own_children" on public.activity_attempts
for select to authenticated
using (exists (select 1 from public.students s where s.id = activity_attempts.student_id and s.parent_id = auth.uid()));

create policy "attempts_insert_own_children" on public.activity_attempts
for insert to authenticated
with check (exists (select 1 from public.students s where s.id = activity_attempts.student_id and s.parent_id = auth.uid()));

-- Student badges
create policy "student_badges_select_own_children" on public.student_badges
for select to authenticated
using (exists (select 1 from public.students s where s.id = student_badges.student_id and s.parent_id = auth.uid()));

create policy "student_badges_insert_own_children" on public.student_badges
for insert to authenticated
with check (exists (select 1 from public.students s where s.id = student_badges.student_id and s.parent_id = auth.uid()));

-- Daily sessions
create policy "daily_sessions_select_own_children" on public.daily_sessions
for select to authenticated
using (exists (select 1 from public.students s where s.id = daily_sessions.student_id and s.parent_id = auth.uid()));

create policy "daily_sessions_insert_own_children" on public.daily_sessions
for insert to authenticated
with check (exists (select 1 from public.students s where s.id = daily_sessions.student_id and s.parent_id = auth.uid()));

create policy "daily_sessions_update_own_children" on public.daily_sessions
for update to authenticated
using (exists (select 1 from public.students s where s.id = daily_sessions.student_id and s.parent_id = auth.uid()))
with check (exists (select 1 from public.students s where s.id = daily_sessions.student_id and s.parent_id = auth.uid()));

-- Parent notes
create policy "parent_notes_select_own" on public.parent_notes for select to authenticated using (auth.uid() = parent_id);
create policy "parent_notes_insert_own" on public.parent_notes for insert to authenticated with check (auth.uid() = parent_id);
create policy "parent_notes_update_own" on public.parent_notes for update to authenticated using (auth.uid() = parent_id) with check (auth.uid() = parent_id);
create policy "parent_notes_delete_own" on public.parent_notes for delete to authenticated using (auth.uid() = parent_id);

-- Grants RPC
revoke all on function public.create_child_student(text, int, text, text, text, text, text) from public;
grant execute on function public.create_child_student(text, int, text, text, text, text, text) to authenticated;
grant execute on function public.update_child_student(uuid, text, int, text, text, text, text, text) to authenticated;
grant execute on function public.login_child(text, text) to anon, authenticated;
grant execute on function public.get_child_attempts(uuid) to anon, authenticated;
grant execute on function public.get_child_attempts() to anon, authenticated;
grant execute on function public.submit_child_attempt(uuid, text, text, text, int, int, int, int) to anon, authenticated;
grant execute on function public.submit_child_attempt(text, int, text, int, int, text, int) to anon, authenticated;


-- =============================================================
-- SEED DEMO / CURRÍCULO GAMIFICADO
-- =============================================================

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
