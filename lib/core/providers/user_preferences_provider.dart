import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class UserPreferencesNotifier extends StateNotifier<List<String>> {
  UserPreferencesNotifier() : super([]);

  Future<void> loadPreferences() async {
    // Cargar categorías de interés del almacenamiento seguro
    final savedPreferences = await storage.read(key: 'user_preferences');
    if (savedPreferences != null) {
      state = savedPreferences.split(','); // Convertir a lista
    }
  }

  void addPreference(String category) {
    if (!state.contains(category)) {
      state = [...state, category]; // Añadir categoría a las preferencias
      savePreferences();
    }
  }

  void removePreference(String category) {
    state = state.where((item) => item != category).toList(); // Eliminar categoría
    savePreferences();
  }

  Future<void> savePreferences() async {
    await storage.write(key: 'user_preferences', value: state.join(','));
  }
}

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, List<String>>((ref) {
  return UserPreferencesNotifier();
});
