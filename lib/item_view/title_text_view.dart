import 'package:flutter/material.dart';
import 'package:movie_app/resources/color_attribute.dart';
import 'package:movie_app/resources/dimens.dart';

class TitleText extends StatelessWidget {
  final String title;

  TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: POPULAR_FLIME_FONT_SIZE,
          fontWeight: FontWeight.bold,
          color: FONT_COLOR),
    );
  }
}
