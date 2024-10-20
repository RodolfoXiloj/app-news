import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/models/news.dart';
import 'package:myapp/core/providers/news_providers.dart';
import 'package:myapp/features/news/widgets/recommended_news_list.dart';

class NewsDetailScreen extends ConsumerWidget {
  final News news;

  const NewsDetailScreen({Key? key, required this.news}) : super(key: key);

@override
Widget build(BuildContext context, WidgetRef ref) {
  final recommendedNewsAsyncValue =
      ref.watch(recommendedNewsProvider(news.source?.id ?? ''));

  return Scaffold(
    appBar: AppBar(
      title: Text('News Details'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Imagen de la noticia
        if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
          Image.network(
            news.urlToImage!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image),
          ),
        SizedBox(height: 16),

        // Título
        Text(
          news.title ?? "No title",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),

        // Autor y fecha de publicación
        Text(
          'By ${news.author ?? 'Unknown'}',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 4),
        Text(
          'Published on: ${news.publishedAt ?? 'Unknown date'}',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: 16),

        // Descripción
        if (news.description != null && news.description!.isNotEmpty)
          Text(
            news.description!,
            style: TextStyle(fontSize: 16),
          ),
        SizedBox(height: 16),

        // Contenido
        if (news.content != null && news.content!.isNotEmpty)
          Text(
            news.content!,
            style: TextStyle(fontSize: 16),
          ),
        SizedBox(height: 16),

        // Fuente de la noticia (enlace)
        if (news.url != null && news.url!.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Read more at: ', style: TextStyle(fontSize: 16)),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    // Abrir el enlace externo (implementar con url_launcher)
                  },
                  child: Text(
                    news.url!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: 20),

        // Noticias recomendadas
        recommendedNewsAsyncValue.when(
          data: (recommendedNews) =>
              RecommendedNewsList(recommendedNews: recommendedNews),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
              child: Text('Error al cargar noticias recomendadas: $err')),
        ),
      ],
    ),
  );
}


}
