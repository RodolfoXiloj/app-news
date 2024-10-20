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

// Proveedor para buscar noticias por categoría
final searchNewsProvider =
    StateNotifierProvider<NewsSearchNotifier, AsyncValue<List<News>>>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return NewsSearchNotifier(apiClient);
});


final recommendedNewsProvider =
    FutureProvider.family<List<News>, String>((ref, category) async {
  final apiClient = ref.read(apiClientProvider);
  final newsApi = NewsApi(apiClient);
  return newsApi.fetchRecommendedNews(category);
});

class NewsSearchNotifier extends StateNotifier<AsyncValue<List<News>>> {
  final ApiClient _apiClient;

  NewsSearchNotifier(this._apiClient) : super(AsyncValue.loading());

  Future<void> searchNews(String query) async {
    state = AsyncValue.loading();
    try {
      final newsApi = NewsApi(_apiClient);
      final newsList = await newsApi.fetchNewsByCategory(search: query);
      state = AsyncValue.data(newsList);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}