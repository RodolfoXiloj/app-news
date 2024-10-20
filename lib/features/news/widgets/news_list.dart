import 'package:flutter/material.dart';
import 'package:myapp/core/models/news.dart';
import 'package:myapp/features/news/screens/news_detail_screen.dart';

class NewsList extends StatelessWidget {
  final List<News> news;

  const NewsList({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final article = news[index];
        return ListTile(
          leading: article.urlToImage!.isNotEmpty
              ? Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
                )
              : Icon(Icons.image),
          title: Text(article.title ?? 'No title'),
          subtitle: Text(
            article.description ?? 'No description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            // Navegar a la pantalla de detalles
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailScreen(news: article),
              ),
            );
          },
        );
      },
    );
  }
}
