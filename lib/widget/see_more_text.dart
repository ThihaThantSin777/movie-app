import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;
  final Color color;
  SeeMoreText(this.text, {this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            decoration: TextDecoration.underline));
  }
}
