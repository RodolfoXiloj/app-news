import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  const BigText({
    Key? key,
    required this.text,
    this.size = 20.0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
    );
  }
}
