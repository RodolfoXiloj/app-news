import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash_image.png', width: 200, height: 200),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Indicador de carga
          ],
        ),
      ),
    );
  }
}
