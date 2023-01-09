import 'package:flutter/material.dart';
import 'package:movie_app/resources/color_attribute.dart';
import 'package:movie_app/resources/dimens.dart';

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_circle,
      size: ICON_PLAY_BUTTON_SIZE,
      color: GRADIENT_COLOR,
    );
  }
}
