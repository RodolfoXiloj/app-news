import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/providers/news_providers.dart';
import 'package:myapp/features/news/widgets/news_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsAsyncValue = _searchQuery.isEmpty
        ? ref.watch(newsProvider)
        : ref.watch(searchNewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar por tu interés...',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
            ),
          ),
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
              if (query.isNotEmpty) {
                ref.read(searchNewsProvider.notifier).searchNews(query);
              }
            });
          },
        ),
      ),
      body: newsAsyncValue.when(
        data: (news) => NewsList(news: news, isMainScreen: true),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

/*   @override
  Widget build(BuildContext context) {
    // Si hay una búsqueda activa, usar el `searchNewsProvider`, de lo contrario usar el `newsProvider`
    final newsAsyncValue = _searchQuery.isEmpty
        ? ref.watch(
            newsProvider) // Mostrar noticias generales si no hay búsqueda
        : ref.watch(searchNewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar por categoría...',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery =
                      ''; // Limpiar el query y volver a mostrar las noticias generales
                });
              },
            ),
          ),
          onChanged: (query) {
            setState(() {
              _searchQuery = query; // Actualizar la query de búsqueda
              if (query.isNotEmpty) {
                ref.read(searchNewsProvider.notifier).searchNews(query);
              }
            });
          },
        ),
      ),
      body: newsAsyncValue.when(
        data: (news) => NewsList(news: news),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
 */
}
