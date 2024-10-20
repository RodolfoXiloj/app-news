import 'package:flutter/material.dart';
import 'package:myapp/core/models/news.dart';
import 'package:myapp/features/news/screens/news_detail_screen.dart';
import 'news_group.dart';

class NewsList extends StatelessWidget {
  final List<News> news;
  final bool isMainScreen; // Añadir este parámetro

  const NewsList({Key? key, required this.news, this.isMainScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMainScreen) {
      List<Widget> newsGroups = [];

      // Divide las noticias en grupos de 5
      for (int i = 0; i < news.length; i += 5) {
        final end = (i + 5 < news.length) ? i + 5 : news.length;
        newsGroups.add(NewsGroup(
          newsGroup: news.sublist(i, end),
          isInitiallyExpanded: i == 0, // El primer grupo estará expandido
        ));
      }

      return ListView(
        children: newsGroups,
      );
    } else {
      // Si no es la pantalla principal, mostrar la lista normal
      return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          final article = news[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                // Navegar a la pantalla de detalles
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(news: article),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mostrar la imagen de la noticia
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
                      ? Image.network(
                          article.urlToImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 200, // Altura fija para la imagen
                            child: const Icon(Icons.image_not_supported),
                          ),
                        )
                      : Container(
                          height: 200, // Altura fija para la imagen
                          child: const Icon(Icons.image),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mostrar el título de la noticia
                        Text(
                          article.title ?? 'Sin título',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        // Mostrar la descripción de la noticia
                        Text(
                          article.description ?? 'Sin descripción',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
