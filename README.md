# 🎬 CRUD de Películas y Series con Flutter, MongoDB y TVMaze API

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![MongoDB](https://img.shields.io/badge/MongoDB-Atlas-green?logo=mongodb)
![TVMaze](https://img.shields.io/badge/API-TVMaze-orange)
![License](https://img.shields.io/badge/License-MIT-yellow)

---
# Video
https://drive.google.com/file/d/1xegVKCzvjJdvtvSkcpAefXnJ3yYJHK5Q/view?usp=sharing
## 📖 Descripción

Aplicación desarrollada en **Flutter** que permite gestionar un catálogo series mediante un sistema **CRUD (Crear, Leer, Actualizar y Eliminar)** conectado a **MongoDB Atlas**.

La aplicación integra la **API pública TVMaze**, permitiendo buscar series de televisión, visualizar sus detalles y guardarlas en la base de datos como favoritas.

---

## ✨ Funcionalidades

### 🎬 Gestión de Series (CRUD)
- ✅ Crear series.
- ✅ Consultar series registradas.
- ✅ Editar series.
- ✅ Eliminar series.
- ✅ Ver detalles de cada series.

### 📺 Integración con TVMaze API
- ✅ Buscar series por nombre.
- ✅ Mostrar series ordenadas alfabéticamente.
- ✅ Scroll infinito.
- ✅ Visualizar información detallada de cada serie.
- ✅ Guardar series favoritas en MongoDB.

### ⭐ Favoritos
- ✅ Guardar series desde TVMaze.
- ✅ Evitar registros duplicados.
- ✅ Mostrar las series guardadas en la pantalla principal.

---

## 🏗️ Arquitectura del Proyecto

```text
lib/
│
├── db/
│   └── mongo_database.dart
│
├── models/
│   └── peliculas.dart
│
├── pages/
│   ├── menu_page.dart
│   ├── home_page.dart
│   ├── form_page.dart
│   ├── detail_page.dart
│   ├── api_page.dart
│   ├── detail_api_page.dart
│   └── about_page.dart
│
├── services/
│   └── services.dart
│
└── main.dart
```

---

## 🛠️ Tecnologías Utilizadas

| Tecnología | Descripción |
|------------|-------------|
| Flutter | Framework de desarrollo multiplataforma |
| Dart | Lenguaje de programación |
| MongoDB Atlas | Base de datos NoSQL en la nube |
| TVMaze API | API pública de series de televisión |
| HTTP | Consumo de servicios REST |
| UUID | Generación de identificadores únicos |
| Material Design 3 | Diseño de interfaz |

---

## 🌐 API Utilizada

### TVMaze API

Obtener series:

```http
https://api.tvmaze.com/shows?page=0
```

Buscar series:

```http
https://api.tvmaze.com/search/shows?q=nombre
```

Documentación oficial:

https://www.tvmaze.com/api

---

## 🗄️ Modelo de Datos

```json
{
  "id": "uuid",
  "titulo": "Breaking Bad",
  "genero": "Drama, Crime",
  "director": "No disponible",
  "anio": 2008,
  "calificacion": 9.5,
  "poster": "url_imagen",
  "descripcion": "Serie de televisión...",
  "fuente": "TVMaze"
}
```

---

## 📱 Pantallas del Sistema

### 🏠 HomePage
- Listado de series favoritas.
- Editar series.
- Eliminar series.
- Ver detalles.

### 📺 ApiPage
- Consulta de series desde TVMaze.
- Búsqueda de series.
- Scroll infinito.

### 🔍 DetailApiPage
- Información detallada de la serie.
- Guardar en favoritos.

### ➕ FormPage
- Registro manual de series.

### ℹ️ AboutPage
- Integrantes.
- API utilizada.
- Explicación técnica.
- Capturas del proyecto.

---

## 📸 Capturas de Pantalla

### HomePage
![Home](assets/images/home.png)

### ApiPage
![Api](assets/images/api.png)

### DetailApiPage
![Detalle](assets/images/detail.png)

### AboutPage
![About](assets/images/about.png)

---

## 🚀 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/tu-repositorio.git
```

### 2. Entrar al proyecto

```bash
cd tu-repositorio
```

### 3. Instalar dependencias

```bash
flutter pub get
```

### 4. Ejecutar la aplicación

```bash
flutter run
```

---

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  http:
  mongo_dart:
  uuid:
```

---

## 👨‍💻 Integrantes

- Roger Grefa

**Carrera:** Desarrollo de Software

---

## 📚 Objetivos de Aprendizaje

- Desarrollo de aplicaciones móviles con Flutter.
- Consumo de APIs REST.
- Integración con bases de datos NoSQL.
- Programación orientada a objetos.
- Diseño de interfaces con Material Design.
- Implementación de operaciones CRUD.

---

## 📄 Licencia

Este proyecto se distribuye bajo la licencia MIT.

**MIT License © 2026 Roger Greff**
