import 'package:flutter/material.dart';

AppBar buildAppBar(String title,
    {bool showSearch = false,
    bool showSettings = false,
    bool showBack = false,
    bool showLogOut = false,
    VoidCallback? onLogOut}) {
  return AppBar(
    backgroundColor: Colors.blueAccent, // Cambia el color de fondo
    elevation: 4, // Añade sombra
    title: Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Color del texto
      ),
    ),
    actions: [
      if (showSearch)
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            // Acciones del ícono de búsqueda
          },
        ),
      if (showSettings) // Renderiza el ícono de configuración solo si el parámetro es verdadero
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Acciones del ícono de configuración
          },
        ),
      if (showLogOut)
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: onLogOut, // Llama a la función proporcionada
        ),
    ],
  );
}
