import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/providers/news_providers.dart';
import 'package:myapp/features/news/widgets/news_list.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsyncValue = ref.watch(newsProvider); // Observa el estado del provider de noticias

    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
      ),
      body: newsAsyncValue.when(
        data: (news) => NewsList(news: news),  // Si las noticias se cargan correctamente, las muestra
        loading: () => Center(child: CircularProgressIndicator()),  // Muestra un loader mientras se carga
        error: (err, stack) => Center(child: Text('Error: $err')),  // Muestra el error si algo sale mal
      ),
    );
  }
}
