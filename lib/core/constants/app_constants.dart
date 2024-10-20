import 'package:flutter/material.dart';

class AppConstants {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static double getResponsiveWidth(double width) {
    return (width / 375) * screenWidth; // Basado en el ancho de diseño
  }

  static double getResponsiveHeight(double height) {
    return (height / 812) * screenHeight; // Basado en la altura de diseño
  }

  static void initialize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
