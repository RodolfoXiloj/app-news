import 'package:flutter/material.dart';
import 'package:myapp/core/models/news.dart';
import 'package:myapp/features/news/screens/news_detail_screen.dart';

class RecommendedNewsList extends StatelessWidget {
  final List<News> recommendedNews;

  const RecommendedNewsList({Key? key, required this.recommendedNews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended News',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // ListView.builder dentro de un Container con una altura específica
        Container(
          height: 300, // Ajusta la altura según sea necesario
          child: ListView.builder(
            itemCount: recommendedNews.length,
            itemBuilder: (context, index) {
              final article = recommendedNews[index];
              return ListTile(
                leading: article.urlToImage!.isNotEmpty
                    ? Image.network(
                        article.urlToImage!,
                        fit: BoxFit.cover,
                        width: 100,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported),
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
          ),
        ),
      ],
    );
  }
}
