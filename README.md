# GenioKids - Plataforma educativa gamificada

GenioKids es una plataforma educativa construida con:

- React
- Vite
- TypeScript
- Supabase
- Vercel
- Capacitor para APK Android

## Qué incluye esta versión

- Inicial: 3, 4 y 5 años.
- Primaria completa: 1.º a 6.º grado.
- Roles: padre/madre e hijo.
- Usuario hijo con sexo, grado, usuario y clave.
- Edición de usuario hijo desde el panel padre.
- Iconos automáticos según sexo y etapa.
- Panel familiar para el padre.
- Reportes solo para padres.
- Vista de aprendizaje solo para hijos.
- Niveles bloqueados y desbloqueo por mérito.
- Acordeón por nivel comprimido por defecto.
- 5 niveles por curso.
- 20 actividades por nivel.
- 1 punto por actividad.
- Medallas mejoradas.
- Flujo de actividad con botón **Terminar por ahora**.
- Botón para continuar a la siguiente misión.

## Instalación

```bash
npm install
npm run dev
```

## Variables de entorno

Copia `.env.example` como `.env.local`:

```env
VITE_SUPABASE_URL="https://TU-PROYECTO.supabase.co"
VITE_SUPABASE_ANON_KEY="TU_ANON_KEY"
VITE_APP_MODE=supabase
```

## Base de datos

Lee primero:

```txt
README_SUPABASE.md
```

Luego ejecuta en Supabase:

```txt
supabase/RESET_TOTAL.sql
```

## GitHub

Lee:

```txt
README_GITHUB.md
```

## Build

```bash
npm run build
```


## Matemática 1.º primaria ampliada a 250 actividades

Esta versión incluye una carga curricular de **Matemática 1.º primaria** basada en el PDF de referencia del cuaderno de trabajo. El contenido se carga desde Supabase y queda distribuido en:

- 5 niveles gamificados.
- 50 actividades por nivel.
- 250 actividades en total.
- 1 punto por actividad.
<<<<<<< HEAD
- Desbloqueo por completar mínimo el **75% de actividades** del nivel anterior.
=======
- Desbloqueo por promedio mínimo **15/20** o por completar el nivel anterior.
>>>>>>> 676f2e59bc23dde938b9ec0b6df86099c6e75694

Archivo recomendado para cargar solo este curso sin borrar usuarios:

```txt
supabase/LOAD_MATEMATICA_1_PRIMER_GRADO_250.sql
```

Archivo para reiniciar toda la base desde cero:

```txt
supabase/RESET_TOTAL.sql
```


## Reportes Excel para padres

Esta versión incluye exportación mejorada de reportes en formato Excel compatible `.xls`. El archivo contiene una hoja de resumen y una hoja por curso, con detalle por nivel, actividad, nota, avance, estado y recomendación. No requiere cambios en la base de datos. Ver `README_REPORTES_EXCEL.md`.
