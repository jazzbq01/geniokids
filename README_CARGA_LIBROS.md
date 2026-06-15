# Cómo cargar nuevos libros en GenioKids

Flujo recomendado:

1. Subir un PDF por vez.
2. Extraer índice, unidades, fichas y temas.
3. Crear actividades originales por curso, grado y nivel.
4. Generar un archivo SQL tipo `LOAD_CURSO_GRADO.sql`.
5. Ejecutar el SQL en Supabase.

## ¿Se debe tocar el código?

Normalmente no. Si el libro se convierte a actividades de los tipos ya existentes, solo se toca la base de datos.

Sí habría que tocar código si se pide una mecánica nueva, por ejemplo:

- trazado real con dedo/lápiz,
- audio de pronunciación,
- arrastrar imágenes complejas,
- ejercicios con dibujo libre,
- reconocimiento de voz,
- OCR o corrección automática de escritura.

Para cursos estándar con preguntas, opciones, niveles, medallas y reportes, basta con nuevos archivos SQL.
