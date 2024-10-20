import 'package:myapp/core/models/category.dart';
import 'package:myapp/core/models/source.dart';
import 'package:myapp/data/api/repositories/source_repo.dart';

class CategoryRepository {
  final SourceApi sourceApi;

  CategoryRepository(this.sourceApi);

  // Método para obtener las categorías únicas a partir de las fuentes
  Future<List<Category>> fetchCategories() async {
    List<Source> sources = await sourceApi.fetchSources();
    
    // Utilizar un conjunto para almacenar categorías únicas
    Set<Category> uniqueCategories = {};

    // Iterar sobre las fuentes y agregar categorías únicas al conjunto
    for (Source source in sources) {
      if(source.category != null ){
        uniqueCategories.add(Category.fromJson(source.category ?? ''));
      }
    }

    // Convertir el conjunto a lista y devolver
    return uniqueCategories.toList();
  }
}

