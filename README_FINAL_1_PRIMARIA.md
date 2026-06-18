# GenioKids - Proyecto final 1.º Primaria

Esta versión integra el proyecto estable con:

- Supabase real sin perfiles demo.
- Roles Padre/Hijo.
- Edición de hijos por el padre.
- Niveles bloqueados en acordeón.
- Reporte Excel para padres.
- Matemática 1.º primaria con 250 actividades.
- Nuestro País 1.º primaria con 250 actividades.
- Cursos obligatorios de Primaria de 1.º a 6.º.

## Cursos obligatorios de Primaria

Para cada grado de 1.º a 6.º se consideran estos cursos:

1. Matemática
2. Comunicación
3. Nuestro País
4. Educación Financiera
5. Tutoría
6. Razonamiento
7. Inglés
8. Ciencia y ambiente

## SQL recomendado

Si tu base ya está funcionando y quieres conservar usuarios e hijos, ejecuta:

```txt
supabase/LOAD_FINAL_1_PRIMARIA_MATEMATICA_NUESTRO_PAIS.sql
```

Si quieres borrar todo y crear desde cero, ejecuta:

```txt
supabase/RESET_TOTAL.sql
```

## Próximos libros

Cuando se agreguen más PDFs, normalmente solo se crearán archivos SQL nuevos:

```txt
LOAD_COMUNICACION_1_PRIMARIA.sql
LOAD_EDUCACION_FINANCIERA_1_PRIMARIA.sql
LOAD_TUTORIA_1_PRIMARIA.sql
LOAD_NUESTRO_PAIS_2_PRIMARIA.sql
```

No será necesario tocar el código mientras las actividades sigan usando las mecánicas actuales: preguntas, opciones, niveles, puntos, estrellas, medallas y reportes.
