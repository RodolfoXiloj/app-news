import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/constants/app_constants.dart';
import 'package:myapp/core/providers/auth_provider.dart';

class RegisterScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
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
                ref.read(authProvider.notifier).register(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              },
              child: Text('Registrarse'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Regresa a la pantalla de login
              },
              child: Text('¿Ya tienes cuenta? Inicia sesión aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
