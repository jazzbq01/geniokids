# Reportes Excel para padres - GenioKids

Esta versión reemplaza el reporte CSV básico por un archivo Excel compatible (.xls).

## Qué contiene el archivo descargado

El padre o madre descarga un archivo con:

1. **Hoja Resumen**
   - Nombre del estudiante.
   - Grado o edad.
   - Fecha de exportación.
   - Resumen por curso.
   - Actividades disponibles, resueltas, aprobadas y pendientes.
   - Promedio sobre 20.
   - Nivel actual sugerido.
   - Recomendación general.

2. **Una hoja por curso**
   - Resumen del curso.
   - Resumen por nivel gamificado.
   - Detalle de cada actividad.
   - Estado: Pendiente, Aprobada o Por reforzar.
   - Nota sobre 20.
   - Porcentaje.
   - Correctas y total de preguntas.
   - Estrellas.
   - Fecha de resolución.
   - Recomendación para el padre.

## Regla de aprobación

El reporte usa el criterio del sistema:

- Aprobado: **15/20** o más.
- Equivalente: **75%** o más.

## Base de datos

No requiere reset de base de datos.

Este cambio es solo de frontend:

- `src/pages/ReportsPage.tsx`
- `src/pages/ReportsPage.css`
- `src/services/reportService.ts`
- `src/utils/excelReport.ts`

## Importante

El archivo generado es Excel XML 2003 con extensión `.xls`. Excel lo abre con hojas separadas. También puede abrirse con LibreOffice Calc.
