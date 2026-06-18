# GenioKids - Carga Inicial 3, 4 y 5 años

Paquete SQL listo para Supabase, construido con la misma lógica del paquete de 5.º primaria, pero adaptado a Educación Inicial.

## Estructura

- 3 edades: Inicial 3 años, Inicial 4 años e Inicial 5 años.
- 6 rutas por edad: Matemática, Comunicación, Personal Social, Psicomotriz, Ciencia y Tecnología, Arte y creatividad.
- 5 niveles por ruta: Semilla Genial, Explorador Curioso, Aventurero Ágil, Estrella Brillante y Maestro Genio.
- 50 actividades por nivel.
- 250 actividades por ruta.
- 1,500 actividades por edad.
- 4,500 actividades totales.
- 126 medallas totales.

## Recomendado en Supabase Web

Si quieres cargar todo de frente:

1. `supabase/LOAD_INICIAL_3_4_5_COMPLETO_CON_LIMPIEZA.sql`

Si el archivo completo pesa demasiado para el editor de Supabase, ejecuta por edad:

1. `supabase/3_ANIOS/LOAD_3_INICIAL_COMPLETO_CON_LIMPIEZA.sql`
2. `supabase/4_ANIOS/LOAD_4_INICIAL_COMPLETO_CON_LIMPIEZA.sql`
3. `supabase/5_ANIOS/LOAD_5_INICIAL_COMPLETO_CON_LIMPIEZA.sql`

O por partes:

1. Ejecuta el reset de la edad.
2. Ejecuta cada archivo `LOAD_*_INICIAL_250.sql`.
3. Ejecuta `99_LOAD_MEDALLAS_*_INICIAL.sql`.

## Nota curricular

El contenido está formulado con enfoque lúdico y progresivo para el Ciclo II de Educación Inicial. Las actividades toman como referencia el Programa Curricular de Educación Inicial del MINEDU y la línea de cuadernos/materiales “Aprendemos jugando”. No copia páginas ni textos del material oficial; genera actividades originales alineadas de forma referencial.

## Seguridad de carga

Los archivos de limpieza solo eliminan contenido educativo de estas edades: actividades, preguntas, lecciones y medallas del paquete. No eliminan padres, niños, credenciales ni sesiones.
