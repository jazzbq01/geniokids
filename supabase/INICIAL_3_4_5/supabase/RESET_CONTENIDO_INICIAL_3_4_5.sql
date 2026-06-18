-- Reset de contenido GenioKids Inicial 3, 4 y 5 años
-- No borra padres, hijos, credenciales ni sesiones.

delete from public.questions q
using public.activities a
where q.activity_id = a.id
  and a.grade in ('3-anios','4-anios','5-anios');

delete from public.activities
where grade in ('3-anios','4-anios','5-anios');

delete from public.lessons
where grade in ('3-anios','4-anios','5-anios');

delete from public.badges
where id like 'badge-3i-%' or id like 'badge-4i-%' or id like 'badge-5i-%';
