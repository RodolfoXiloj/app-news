# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Detalle del Requerimiento: 
Objetivo: Desarrollar una aplicación intuitiva y atractiva que permita a los usuarios explorar noticias de diversas fuentes.

## Descripción de la aplicación: 

Aplicación de Noticias. Tu empresa está desarrollando una nueva aplicación web de noticias. La aplicación debe proporcionar a los usuarios una experiencia de lectura intuitiva y atractiva. 
La aplicación como tal es un repositorio que trae noticias de diferentes fuentes por consumos.

## Funcionalidades Clave:
--Registro e Inicio de Sesión: Permitir a los usuarios registrarse y autenticarse mediante correo electrónico y contraseña.
--Perfil de Usuario: Permitir a los usuarios personalizar su perfil seleccionando categorías de interés y fuentes preferidas.
--Detalles de la Noticia: Mostrar la noticia completa, incluyendo título, imagen, descripción, fecha de publicación y fuente.
--Búsqueda: Permitir a los usuarios buscar por categorías 
--Noticias Recomendadas: dentro de la página interna de la noticia, debe tener una sección que muestre noticias recomendadas, asociadas directamente a la categoría que esta pertenece. 

## Detalle de la funcionalidad: 
--Pantalla Principal: Mostrar un listado de noticias (título, imagen, descripción) obtenidas de un endpoint del backend.
--Detalles de Noticia: Mostrar la información completa de una noticia al hacer clic en ella (título, imagen, cuerpo, fecha) y un botón para regresar a la lista.
--Noticias Recomendadas: En la página de detalles, mostrar al menos 3 noticias relacionadas.
--Navegación: Implementar una barra de navegación simple con enlaces a "Inicio" y "Categorías".
--Autenticación: Implementar autenticación basada en JWT para proteger los endpoints del backend.
--Pantalla Principal: 
• Al acceder a la aplicación, se debe mostrar una página principal con un componente que contraiga una lista de al menos 5 noticias. 
--• Cada noticia debe mostrar el título, una imagen y una breve descripción.
--• La información de las noticias debe provenir del backend a través de una llamada a la API. 

--Detalles de Noticia: Al hacer clic en una noticia de la lista, el usuario debe ser redirigido a una nueva página que muestre los detalles completos de esa noticia.

--La página de detalles debe mostrar el titulo, la imagen, el cuerpo de la noticia y la fecha de publicación; Incluye un botón de “Volver” para regresar a la lista de noticias. 

--Sección de Noticias Recomendadas
--En la página de detalles, muestra una sección con al menos 3 noticias recomendadas. Cada noticia recomendada debe tener un enlace que lleve a sus detalles al hacer clic. 

--Barra de Navegación: Diseña una barra de navegación que incluya enlaces a “Inicio” y “Categorias”. Asegúrate de que la barra de navegación sea visible en todas las páginas. 
--Al iniciar sesión, el usuario debe recibir un token JWT que se utilizará para autorizar las solicitudes a la API del Backend Asegúrate de manejar correctamente la expiración del token y de almacenar el token de manera segura en el lado del cliente 

--APIS  de Noticias: 
• Implementa un endpoint REST que devuelva al menos 5 noticias con la estructura necesaria para la pantalla principal del frontend.
 • Cada noticia debe tener un ID, título, imagen y descripción. 
• Asegúrate de que este endpoint esté protegido y requiera un token JWT válido para acceder. 

--Detalles de noticia: 
• Crea un endpoint que reciba el ID de una noticia y devuelva todos los detalles necesarios para la página de detalles del frontend.
 • Protege este endpoint para que solo sea accesible con un token JWT válido. 
--Noticias recomendadas 
• Implementa un endpoint que devuelva al menos 3 noticias recomendadas para una noticia dada.
 • Este endpoint también debe estar protegido por autenticación JWT.
 Categorías: implementa un endpoint para obtener la lista de categorías. 
• Protege este endpoint de la misma manera que los demás
Arquitectura Propuesta:
Frontend (Flutter):
Widgets: Utilizar widgets de Flutter para construir una interfaz de usuario nativa y adaptable.
State Management: Implementar un sistema de gestión de estado como Provider o Riverpod para manejar el estado de la aplicación.
API: Consumir una API REST desarrollada en un backend (Node.js, Python, o cualquier otro lenguaje preferido) para obtener las noticias y gestionar la autenticación.
Backend:
API REST: Exponer endpoints para gestionar usuarios, noticias, categorías y preferencias.
Base de Datos: Utilizar una base de datos NoSQL (MongoDB) para almacenar datos de usuarios y noticias.
Autenticación: Implementar un sistema de autenticación basado en JWT para proteger los endpoints.
Personalización: Utilizar algoritmos de recomendación para personalizar el feed de noticias de cada usuario.
Diagrama de Componentes:
[Incluir un diagrama que muestre la interacción entre la aplicación Flutter, la API REST y la base de datos]

## Detalles de la arquitectura: 

Frontend: Flutter
Lenguaje: Dart.
Framework: Flutter.
State Management: Riverpod (para el manejo del estado de la aplicación).
Autenticación: Autenticación basada en JWT para gestionar el inicio de sesión y registro.
Consumo de APIs: Utilización del paquete http para consumir la API REST del backend.
Navegación: Sistema de navegación por rutas utilizando el paquete estándar de Flutter.
Almacenamiento del JWT: flutter_secure_storage para almacenar el token JWT de manera segura.
Responsividad: Uso de widgets y estrategias para hacer la interfaz responsiva (media queries, layouts adaptables).
Manejo de dependencias: pubspec.yaml para gestionar las dependencias.

google_sign_in: Para implementar el inicio de sesión con Google.
flutter_secure_storage: Para almacenar el Google ID Token de forma segura.
http: Para consumir las APIs de noticias.
flutter_dotenv: Para manejar las claves de la API del proveedor externo de noticias.

credencial del api
fogilot726@abaot.com
Apirest12**