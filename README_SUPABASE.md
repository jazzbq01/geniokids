# GenioKids - Configuración Supabase desde cero

Esta versión reinicia la arquitectura para trabajar de forma limpia con:

- Roles separados: **padre/madre** y **hijo**.
- Padre con Supabase Auth: correo + contraseña.
- Hijo con usuario y clave propia creada por el padre.
- Edición de usuarios hijos desde el panel del padre.
- Sexo del hijo e icono automático según sexo y etapa.
- Medallas cargadas desde Supabase.
- Niveles en acordeón, comprimidos por defecto.
- Desbloqueo por mérito: completar mínimo el **75% de actividades** del nivel anterior.
- Botón **Terminar por ahora** para que el niño avance poco a poco.

---

## 1. Crear proyecto en Supabase

1. Entra a Supabase.
2. Crea un nuevo proyecto.
3. Guarda:
   - Project URL
   - anon public key

---

## 2. Resetear toda la base de datos

Abre Supabase:

```txt
SQL Editor > New query
```

Copia y ejecuta todo el contenido de:

```txt
supabase/RESET_TOTAL.sql
```

Ese archivo hace todo:

```txt
- Elimina tablas anteriores del proyecto.
- Crea perfiles de padres.
- Crea tabla students limpia.
- Crea child_credentials para guardar usuario y clave cifrada del hijo.
- Crea child_sessions para sesiones del usuario hijo.
- Crea niveles gamificados.
- Crea cursos, lecciones, actividades y preguntas.
- Crea 20 actividades por nivel.
- Crea 5 niveles por curso.
- Crea medallas mejoradas.
- Activa RLS.
- Crea RPC para crear, editar y loguear hijos.
- Crea RPC para guardar y consultar intentos del hijo.
```

> Advertencia: este reset borra datos anteriores de GenioKids. Úsalo cuando quieras empezar limpio.

---

## 3. Configurar Auth

En Supabase ve a:

```txt
Authentication > Providers > Email
```

Activa Email.

Para pruebas rápidas puedes desactivar confirmación de correo:

```txt
Authentication > Providers > Email > Confirm email = OFF
```

Si lo dejas activo, el padre deberá confirmar su correo antes de iniciar sesión.

---

## 4. Configurar `.env.local`

Copia `.env.example` como `.env.local`.

Debe quedar así:

```env
VITE_SUPABASE_URL="https://TU-PROYECTO.supabase.co"
VITE_SUPABASE_ANON_KEY="TU_ANON_KEY"
VITE_APP_MODE=supabase
```

Luego reinicia Vite:

```bash
npm run dev
```

Si ya estaba corriendo, presiona `Ctrl + C` y vuelve a ejecutar.

---

## 5. Flujo esperado

### Padre

1. Entra a `/login`.
2. Selecciona **Padre / Madre**.
3. Crea cuenta familiar.
4. Inicia sesión.
5. Crea usuario hijo con nombre, sexo, edad, grado, usuario y clave.
6. Puede editar el perfil creado: nombre, sexo, edad, grado, usuario y clave opcional.

### Hijo

1. Entra a `/login`.
2. Selecciona **Hijo**.
3. Ingresa usuario y clave.
4. Solo verá su mundo educativo: Inicial o Primaria según su grado.
5. Puede avanzar actividades y usar **Terminar por ahora** para volver al inicio.

---

## 6. Regla de desbloqueo de niveles

Cada curso tiene 5 niveles:

```txt
1. Semilla Genial
2. Explorador Curioso
3. Aventurero Ágil
4. Estrella Brillante
5. Maestro Genio
```

Regla:

```txt
El siguiente nivel se desbloquea si el nivel anterior está completado al 100%
cuando completa al menos el 75% de actividades del nivel anterior.
```

Los niveles aparecen como acordeón y todos inician comprimidos. Los niveles bloqueados no se despliegan.

---

## 7. Verificación rápida

En Supabase ejecuta:

```sql
select count(*) from public.activities;
select count(*) from public.questions;
select count(*) from public.difficulty_levels;
select count(*) from public.badges;
select count(*) from public.child_credentials;
```

Deberías ver actividades, preguntas, niveles y medallas cargadas.

---

## 8. Ver usuarios hijos creados

```sql
select
  s.id,
  s.parent_id,
  s.name,
  s.age,
  s.grade,
  s.level,
  s.avatar,
  s.gender,
  cc.child_username,
  cc.is_active,
  cc.created_at
from public.child_credentials cc
join public.students s on s.id = cc.student_id
order by cc.created_at desc;
```

La clave no se muestra porque se guarda cifrada.

---

## 9. Seguridad

- La `anon key` puede usarse en frontend.
- La `service_role key` nunca debe ir en `.env.local`.
- La clave del hijo se guarda cifrada en `child_credentials.pin_hash`.
- El padre solo puede ver y editar sus propios hijos por RLS.
- El hijo accede con RPC controladas y sesión temporal.


## Matemática 1.º primaria ampliada a 250 actividades

Esta versión incluye una carga curricular de **Matemática 1.º primaria** basada en el PDF de referencia del cuaderno de trabajo. El contenido se carga desde Supabase y queda distribuido en:

- 5 niveles gamificados.
- 50 actividades por nivel.
- 250 actividades en total.
- 1 punto por actividad.
- Desbloqueo por mínimo **75% de actividades completadas** en el nivel anterior.

Archivo recomendado para cargar solo este curso sin borrar usuarios:

```txt
supabase/LOAD_MATEMATICA_1_PRIMER_GRADO_250.sql
```

Archivo para reiniciar toda la base desde cero:

```txt
supabase/RESET_TOTAL.sql
```
