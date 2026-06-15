# README_GITHUB.md

Guía para subir **GenioKids** a GitHub desde cero.

---

## 1. Requisitos

Necesitas tener instalado:

```txt
Git
Node.js
Cuenta de GitHub
```

Verifica Git:

```bash
git --version
```

Verifica Node:

```bash
node -v
npm -v
```

---

## 2. Crear repositorio en GitHub

1. Entra a GitHub.
2. Presiona **New repository**.
3. Nombre sugerido:

```txt
geniokids
```

4. Puedes elegir público o privado.
5. No marques README, `.gitignore` ni license, porque el proyecto ya trae archivos.
6. Presiona **Create repository**.

GitHub te mostrará una URL similar a:

```txt
https://github.com/TU_USUARIO/geniokids.git
```

---

## 3. Inicializar Git dentro del proyecto

Entra a la carpeta del proyecto:

```bash
cd geniokids
```

Inicializa Git:

```bash
git init
```

Agrega todos los archivos:

```bash
git add .
```

Crea el primer commit:

```bash
git commit -m "Primera version de GenioKids"
```

---

## 4. Conectar con GitHub

Cambia la URL por la de tu repositorio:

```bash
git remote add origin https://github.com/TU_USUARIO/geniokids.git
```

Renombra la rama principal:

```bash
git branch -M main
```

Sube el proyecto:

```bash
git push -u origin main
```

---

## 5. Si GitHub pide usuario y contraseña

GitHub ya no usa contraseña normal para Git por HTTPS.

Debes usar:

```txt
Personal Access Token
```

o puedes trabajar con GitHub Desktop si prefieres algo visual.

---

## 6. Proteger variables de entorno

No subas estos archivos:

```txt
.env
.env.local
.env.production
```

Ya están incluidos en `.gitignore`.

Solo debes subir:

```txt
.env.example
```

Este archivo sirve como plantilla sin credenciales reales.

---

## 7. Flujo diario de trabajo

Cada vez que avances:

```bash
git status
git add .
git commit -m "Descripcion corta del cambio"
git push
```

Ejemplo:

```bash
git commit -m "Agregar modulo de reportes educativos"
```

---

## 8. Conectar GitHub con Vercel

1. Entra a Vercel.
2. Presiona **Add New Project**.
3. Importa el repositorio `geniokids` desde GitHub.
4. Framework: Vite.
5. Build command:

```bash
npm run build
```

6. Output directory:

```txt
dist
```

7. Agrega variables de entorno:

```env
VITE_SUPABASE_URL=https://TU_PROYECTO.supabase.co
VITE_SUPABASE_ANON_KEY=TU_ANON_KEY
VITE_APP_MODE=supabase
```

8. Presiona **Deploy**.

---

## 9. Comandos útiles

Ver repositorio remoto:

```bash
git remote -v
```

Ver estado:

```bash
git status
```

Ver historial:

```bash
git log --oneline
```

Crear nueva rama:

```bash
git checkout -b nueva-funcionalidad
```

Volver a main:

```bash
git checkout main
```

---

## 10. Recomendación profesional

Usa commits pequeños y claros.

Mal commit:

```txt
cambios
```

Buen commit:

```txt
Agregar actividades de inicial 3 años
```

El repositorio es la memoria técnica del proyecto. Si lo cuidas desde el día uno, después Vercel, APK y mantenimiento serán mucho más simples.
