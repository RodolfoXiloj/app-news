import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/models/source.dart';
import 'package:myapp/data/api/api_client.dart';
import 'package:myapp/data/api/repositories/source_repo.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient('https://newsapi.org/v2');
});

final sourceProvider = FutureProvider<List<Source>>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  final sourceApi = SourceApi(apiClient);
  return sourceApi.fetchSources();
});


