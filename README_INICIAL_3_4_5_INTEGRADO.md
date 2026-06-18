# GenioKids - Inicial 3, 4 y 5 años integrado

Este paquete integra el bloque de Inicial al mismo proyecto donde Primaria ya funciona correctamente.

## Qué se corrigió

- Inicial usa los mismos valores de grado que la app: `3-anios`, `4-anios`, `5-anios`.
<<<<<<< HEAD
- Se mantiene la misma lógica de Primaria: niveles por acordeón, niveles bloqueados, mínimo 75% de actividades completadas, avance entre misiones, regreso al acordeón y regreso al inicio.
=======
- Se mantiene la misma lógica de Primaria: niveles por acordeón, niveles bloqueados, nota mínima 15/20 o 75%, avance entre misiones, regreso al acordeón y regreso al inicio.
>>>>>>> 676f2e59bc23dde938b9ec0b6df86099c6e75694
- Se agregaron las áreas de Inicial al esquema y a los tipos TypeScript: Matemática, Comunicación, Personal Social, Psicomotriz, Ciencia y Tecnología, Arte y creatividad.
- Se incorporaron medallas separadas por año: 3 años, 4 años y 5 años.
- Las medallas se filtran por grado activo igual que en Primaria.

## Archivo principal para cargar Inicial en Supabase

Ejecutar en Supabase SQL Editor:

```sql
supabase/LOAD_FINAL_INICIAL_3_4_5_CON_REGLAS_PRIMARIA.sql
```

También se dejó la carpeta completa:

```text
supabase/INICIAL_3_4_5/
```

## Regla operativa

Para que Inicial aparezca en la app, el estudiante debe estar creado con uno de estos grados:

- `3-anios`
- `4-anios`
- `5-anios`

No usar `3-inicial`, `4-inicial` ni `5-inicial`, porque la app y el esquema trabajan con `*-anios`.
