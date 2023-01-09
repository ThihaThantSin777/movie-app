import 'package:flutter/material.dart';
import 'package:movie_app/resources/color_attribute.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, HOME_SCREEN_COLOR])),
    );
  }
}
