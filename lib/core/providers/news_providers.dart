import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/data/api/api_client.dart';
import 'package:myapp/features/news/repository/news_repo.dart';
import 'package:myapp/core/models/news.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient('https://newsapi.org/v2');
});

final newsProvider = FutureProvider<List<News>>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  final newsApi = NewsApi(apiClient);
  return newsApi.fetchNews();
});

final recommendedNewsProvider = FutureProvider.family<List<News>, String>((ref, category) async {
  final apiClient = ref.read(apiClientProvider);
  final newsApi = NewsApi(apiClient);
  return newsApi.fetchRecommendedNews(category);
});

