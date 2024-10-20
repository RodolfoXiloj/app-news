import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/constants/app_constants.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/core/widgets/app_text_field.dart';
import 'package:myapp/core/widgets/big_text.dart';

class RegisterScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Registrarse')),
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
                "Crea tu cuenta",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Regístrate para comenzar a disfrutar de nuestra app",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20), // Espacio para los campos de entrada
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
                  ref.read(authProvider.notifier).register(
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
                  text: 'Registrarse',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppConstants.getResponsiveHeight(10)),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Regresa a la pantalla de login
                },
                child: Text(
                  '¿Ya tienes cuenta? Inicia sesión aquí',
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
