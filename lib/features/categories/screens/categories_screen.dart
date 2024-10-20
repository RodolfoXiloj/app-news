import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/providers/category_provider.dart';
import 'package:myapp/core/widgets/buil_app_bar.dart';
import 'package:myapp/features/categories/screens/category_news_screen.dart';

class CategorySelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsyncValue = ref.watch(categoryProvider);

    return Scaffold(
      appBar: buildAppBar('Seleccionar Categoría'),
      body: categoryAsyncValue.when(
        data: (categories) => Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              childAspectRatio: 2, // Proporción de aspecto de cada celda
              crossAxisSpacing: 10, // Espaciado horizontal
              mainAxisSpacing: 10, // Espaciado vertical
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  // Navega a la pantalla de noticias de la categoría seleccionada
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryNewsScreen(category: category.name),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length]
                        .withOpacity(0.7), // Color de fondo
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 2), // Desplazamiento de la sombra
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    capitalize(category.name),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Color del texto
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}
