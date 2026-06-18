-- Reset de contenido GenioKids Inicial 4 años
-- No borra padres, hijos, credenciales ni sesiones.

delete from public.questions q
using public.activities a
where q.activity_id = a.id
  and a.grade in ('4-anios');

delete from public.activities
where grade in ('4-anios');

delete from public.lessons
where grade in ('4-anios');

delete from public.badges
where id like 'badge-4i-%';
