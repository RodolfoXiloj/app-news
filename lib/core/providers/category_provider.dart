import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/models/category.dart';
import 'package:myapp/data/api/api_client.dart';
import 'package:myapp/data/api/repositories/source_repo.dart';
import 'package:myapp/features/categories/repository/category_repo.dart';

// Proveedor del cliente API
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient('https://newsapi.org/v2');
});

// Proveedor del repositorio SourceApi
final sourceApiProvider = Provider<SourceApi>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return SourceApi(apiClient);
});

// Proveedor del repositorio CategoryRepository
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final sourceApi = ref.read(sourceApiProvider);
  return CategoryRepository(sourceApi);
});

// Proveedor que obtiene las categorías
final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final categoryRepository = ref.read(categoryRepositoryProvider);
  return categoryRepository.fetchCategories();
});
