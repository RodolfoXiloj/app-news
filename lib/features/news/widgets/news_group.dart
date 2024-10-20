import 'package:flutter/material.dart';
import 'package:myapp/core/models/news.dart';
import 'package:myapp/features/news/screens/news_detail_screen.dart';

class NewsGroup extends StatelessWidget {
  final List<News> newsGroup;
  final bool
      isInitiallyExpanded; // Propiedad para controlar la expansión inicial

  const NewsGroup(
      {Key? key, required this.newsGroup, this.isInitiallyExpanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(isInitiallyExpanded ? 'Últimas Noticias' : 'Más Noticias'),
      initiallyExpanded: isInitiallyExpanded, // Usar la propiedad aquí
      children: newsGroup.map((news) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            onTap: () {
              // Navegar a la pantalla de detalles
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(news: news),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mostrar la imagen de la noticia
                news.urlToImage != null && news.urlToImage!.isNotEmpty
                    ? Image.network(
                        news.urlToImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
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
                        news.title ?? 'Sin título',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Mostrar la descripción de la noticia
                      Text(
                        news.description ?? 'Sin descripción',
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
      }).toList(),
    );
  }
}
