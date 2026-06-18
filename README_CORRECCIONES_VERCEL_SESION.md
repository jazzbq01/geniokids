# Correcciones de sesión, rutas y medallas

Versión corregida sobre `geniokids_final_primaria_1.zip`.

## Cambios aplicados

1. **Medallas por grado**
   - La página de medallas filtra el catálogo según el grado del estudiante activo.
   - Ejemplo: si el hijo está en 6.º primaria, solo ve medallas genéricas y medallas propias de 6.º; no ve medallas de 1.º, 2.º, 3.º, 4.º o 5.º.

2. **Configuración eliminada del flujo visible**
   - Se retiró el enlace `Configuración` del menú lateral.
   - Se eliminó la ruta `/settings` del router principal.

3. **Sesión estable al hacer F5**
   - Se conserva el hijo seleccionado del padre en `localStorage` bajo la clave `gk_active_student_supabase`.
   - Si el padre refresca con F5 en Primaria, Curso, Actividad, Reportes o Medallas, la app ya no vuelve a un estado vacío innecesario.
   - La sesión del hijo continúa usando `gk_child_session` con expiración.

4. **Rutas protegidas**
   - Si no hay sesión, se redirige a `/login`.
   - El hijo no puede entrar a rutas de padre como `/students`, `/dashboard` o `/reports`.
   - El hijo de inicial no entra al mundo Primaria.
   - El hijo de primaria no entra al mundo Inicial.

5. **Vercel preparado para refresh**
   - `vercel.json` mantiene la regla de rewrite a `index.html`, necesaria para que las rutas SPA no fallen al refrescar o abrir enlaces directos.

## Validación

Se validó con:

```bash
npm ci
npm run build
```

El build fue exitoso. Vite solo mostró advertencia de tamaño de bundle, no error.

## Archivos modificados

- `src/app/App.tsx`
- `src/context/AuthContext.tsx`
- `src/context/StudentContext.tsx`
- `src/layout/AppLayout.tsx`
- `src/pages/RewardsPage.tsx`
- `README_CORRECCIONES_VERCEL_SESION.md`
