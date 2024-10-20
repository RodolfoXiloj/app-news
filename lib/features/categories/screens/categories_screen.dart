import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/providers/category_provider.dart';

class CategorySelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsyncValue = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Categoría'),
      ),
      body: categoryAsyncValue.when(
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category.name),
              onTap: () {
                // Acción al seleccionar una categoría
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryNewsScreen(category: category.name),
                  ),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class CategoryNewsScreen extends StatelessWidget {
  final String category;

  const CategoryNewsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias en $category'),
      ),
      body: Center(
        child:
            Text('Aquí mostrarías las noticias para la categoría: $category'),
      ),
    );
  }
}
