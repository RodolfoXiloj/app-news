import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/constants/app_constants.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/core/widgets/app_text_field.dart';
import 'package:myapp/core/widgets/big_text.dart';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.getResponsiveWidth(16),
          vertical: AppConstants.getResponsiveHeight(40),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.1), // Espacio superior
              Text(
                "¡Bienvenido de nuevo!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Inicia sesión en tu cuenta",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40), // Espacio para los campos de entrada
              AppTestField(
                textController: _emailController,
                hintText: "Email",
                icon: Icons.email,
              ),
              SizedBox(height: AppConstants.getResponsiveHeight(20)),
              AppTestField(
                textController: _passwordController,
                hintText: "Contraseña",
                icon: Icons.lock,
                isObscure: true,
              ),
              SizedBox(height: AppConstants.getResponsiveHeight(20)),
              ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).signIn(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Color del botón
                  padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 40), // Espaciado interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: BigText(
                  text: 'Iniciar Sesión',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppConstants.getResponsiveHeight(10)),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(authProvider.notifier).signInWithGoogle();
                },
                icon: Icon(Icons.login),
                label: BigText(text: 'Iniciar con Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200], // Color del botón
                  padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 40), // Espaciado interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: AppConstants.getResponsiveHeight(10)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate aquí',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
