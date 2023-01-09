import 'package:flutter/material.dart';
import 'package:movie_app/item_view/title_text_view.dart';
import 'package:movie_app/widget/see_more_text.dart';

class TitleTextSeeMoreView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreVisibility;
  TitleTextSeeMoreView(this.titleText, this.seeMoreText,
      {this.seeMoreVisibility = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(titleText),
        const Spacer(),
        Visibility(visible: seeMoreVisibility, child: SeeMoreText(seeMoreText)),
      ],
    );
  }
}
