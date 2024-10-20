import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/features/auth/screens/login_screen.dart';
import 'package:myapp/main_screen.dart';
import 'core/constants/app_constants.dart';
import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppConstants.initialize(context); // Inicializar dimensiones

    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authState.hasValue && authState.value != null
          ? MainScreen() // Asegúrate de que MainScreen sea un Widget
          : LoginScreen(), // Asegúrate de que LoginScreen también sea un Widget
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
