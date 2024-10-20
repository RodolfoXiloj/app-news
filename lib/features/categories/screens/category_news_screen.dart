import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/providers/news_providers.dart';
import 'package:myapp/core/widgets/buil_app_bar.dart';
import 'package:myapp/features/news/widgets/news_list.dart';

class CategoryNewsScreen extends ConsumerStatefulWidget {
  final String category;

  const CategoryNewsScreen({required this.category});

  @override
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends ConsumerState<CategoryNewsScreen> {
  @override
  void initState() {
    super.initState();
    // Realiza la búsqueda en `initState`
    Future.microtask(() {
      ref.read(searchNewsProvider.notifier).searchNews(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsAsyncValue = ref.watch(searchNewsProvider);

    return Scaffold(
      appBar: buildAppBar('Noticias en ${widget.category}'),
      body: newsAsyncValue.when(
        data: (news) =>
            NewsList(news: news), // Mostrar noticias si se cargan correctamente
        loading: () =>
            Center(child: CircularProgressIndicator()), // Muestra un loader
        error: (error, stackTrace) => Center(
            child: Text('Error: $error')), // Muestra el error si algo sale mal
      ),
    );
  }
}
