import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/models/category.dart';
import 'package:myapp/core/models/source.dart';
import 'package:myapp/core/providers/category_provider.dart';
import 'package:myapp/core/providers/source_provider.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  List<Category> selectedCategories = [];
  List<Source> selectedSources = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Cargar preferencias al iniciar
  }

  @override
  Widget build(BuildContext context) {
    final categoryAsyncValue = ref.watch(categoryProvider);
    final sourceAsyncValue = ref.watch(sourceProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authNotifier.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona tus categorías de interés:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            categoryAsyncValue.when(
              data: (categories) {
                return Wrap(
                  spacing: 10.0,
                  children: categories.map((category) {
                    final isSelected = selectedCategories.contains(category);
                    return FilterChip(
                      label: Text(category.name),
                      selected: isSelected,
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            selectedCategories.add(category);
                          } else {
                            selectedCategories.remove(category);
                          }
                        });
                      },
                    );
                  }).toList(),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            SizedBox(height: 24),
            Text(
              'Selecciona tus fuentes preferidas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            sourceAsyncValue.when(
              data: (sources) {
                return Wrap(
                  spacing: 10.0,
                  children: sources.map((source) {
                    final isSelected = selectedSources.contains(source);
                    return FilterChip(
                      label: Text(source.name ?? 'Sin nombre'),
                      selected: isSelected,
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            selectedSources.add(source);
                          } else {
                            selectedSources.remove(source);
                          }
                        });
                      },
                    );
                  }).toList(),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  savePreferences(selectedCategories, selectedSources);
                },
                child: Text('Guardar Preferencias'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> savePreferences(
      List<Category> categories, List<Source> sources) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Guardar categorías
    List<String> categoryNames = categories.map((c) => c.name).toList();
    await prefs.setStringList('selected_categories', categoryNames);

    // Guardar fuentes
    List<String> sourceNames = sources
        .map((s) =>
            s.name ??
            'Sin nombre') // Asegúrate de manejar posibles valores nulos
        .toList();

    await prefs.setStringList('selected_sources', sourceNames);

    print('Categorías seleccionadas: $categoryNames');
    print('Fuentes seleccionadas: $sourceNames');
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Cargar categorías
    List<String>? categoryNames = prefs.getStringList('selected_categories');
    if (categoryNames != null) {
      selectedCategories =
          categoryNames.map((name) => Category(name: name)).toList();
    }

    // Cargar fuentes
    List<String>? sourceNames = prefs.getStringList('selected_sources');
    if (sourceNames != null) {
      selectedSources = sourceNames.map((name) => Source(name: name)).toList();
    }

    setState(() {}); // Actualiza la UI
  }
}
