import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/constants/app_constants.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/features/auth/screens/register_screen.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchar el estado del authProvider para manejar errores
    ref.listen<AsyncValue<User?>>(authProvider, (previous, next) {
      if (next.isLoading) {
        // Si es necesario, puedes mostrar un indicador de carga.
      } else if (next.hasError) {
        // Mostrar SnackBar con el error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${next.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.getResponsiveWidth(16),
          vertical: AppConstants.getResponsiveHeight(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: AppConstants.getResponsiveHeight(20)),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).signIn(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
              },
              child: Text('Iniciar Sesión'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).signInWithGoogle();
              },
              icon: Icon(Icons.login),
              label: Text('Iniciar con Google'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
