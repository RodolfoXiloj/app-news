class Category {
  final String name;

  Category({required this.name});

  // Convertir desde JSON
  factory Category.fromJson(String categoryName) {
    return Category(name: categoryName);
  }

  // Comparar categorías por nombre
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
