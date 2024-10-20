import 'package:myapp/core/models/source.dart';
import 'dart:convert';

import 'package:myapp/data/api/api_client.dart';

class SourceApi {
  final ApiClient apiClient;

  SourceApi(this.apiClient);

  Future<List<Source>> fetchSources() async {
    final response =
        await apiClient.get('/sources'); // Usa el cliente personalizado

    if (response.statusCode == 200) {
      /* final List<dynamic> newsJson = json.decode(response.body); */
      final Map<String, dynamic> sourcesMap =
          json.decode(response.body); // Decodifica el JSON a un mapa

      /* final List<News> newsList = newsJson.map((json) => News.fromJson(json)).toList(); */
      final List<dynamic> sourceJson =
          sourcesMap['sources']; // Obtiene la lista de artículos

      return sourceJson.map((source) {
        // Asegúrate de que cada artículo sea un mapa
        if (source is Map<String, dynamic>) {
          return Source.fromJson(source);
        } else {
          throw Exception('El artículo no es un mapa');
        }
      }).toList(); // Mapea cada artículo a una instancia de News
    } else {
      throw Exception('Error al cargar fuentes: ${response.statusCode}');
    }
  }
}
