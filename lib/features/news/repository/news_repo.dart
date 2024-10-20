import 'package:myapp/core/models/news.dart';
import 'package:myapp/core/models/source.dart';
import 'dart:convert';

import 'package:myapp/data/api/api_client.dart';
import 'package:myapp/data/api/repositories/source_repo.dart';

class NewsApi {
  final ApiClient apiClient;

  NewsApi(this.apiClient);

  Future<List<News>> fetchNews() async {
    final response = await apiClient.get(
        '/top-headlines?country=us&pageSize=10'); // Usa el cliente personalizado

    if (response.statusCode == 200) {
      /* final List<dynamic> newsJson = json.decode(response.body); */
      final Map<String, dynamic> newsMap =
          json.decode(response.body); // Decodifica el JSON a un mapa

      /* final List<News> newsList = newsJson.map((json) => News.fromJson(json)).toList(); */
      final List<dynamic> articlesJson =
          newsMap['articles']; // Obtiene la lista de artículos

      return articlesJson.map((article) {
        // Asegúrate de que cada artículo sea un mapa
        if (article is Map<String, dynamic>) {
          return News.fromJson(article);
        } else {
          throw Exception('El artículo no es un mapa');
        }
      }).toList(); // Mapea cada artículo a una instancia de News
    } else {
      throw Exception('Error al cargar noticias: ${response.statusCode}');
    }
  }

// Método para obtener noticias recomendadas basadas en una categoría
  Future<List<News>> fetchRecommendedNews(String source) async {
    List<Source> sources = await SourceApi(apiClient).fetchSources();
    //buscar la categoria
    String? category = '';
    for (Source s in sources) {
      if (s.id == source) {
        category = s.category;
        break;
      }
    }

    final response =
        await apiClient.get('/top-headlines?category=$category&pageSize=3');

    if (response.statusCode == 200) {
      final Map<String, dynamic> newsMap = json.decode(response.body);
      final List<dynamic> articlesJson = newsMap['articles'];
      return articlesJson.map((article) {
        if (article is Map<String, dynamic>) {
          return News.fromJson(article);
        } else {
          throw Exception('El artículo no es un mapa');
        }
      }).toList();
    } else {
      throw Exception(
          'Error al cargar noticias recomendadas: ${response.statusCode}');
    }
  }
}
