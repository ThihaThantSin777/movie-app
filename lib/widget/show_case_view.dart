import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/item_view/play_button_view.dart';
import 'package:movie_app/item_view/title_text_view.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';
import 'package:movie_app/resources/dimens.dart';

class ShowCaseView extends StatelessWidget {
  final MovieVO? moviesVO;

  ShowCaseView({required this.moviesVO});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              '$BASE_IMAGE_URL${moviesVO?.posterPath??""}',
              fit: BoxFit.cover,
            ),
          ),
          const Align(alignment: Alignment.center, child: PlayButtonView()),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2, bottom: MARGIN_MEDIUM),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                      moviesVO?.title??"Un Known",
                      style: const TextStyle(
                          fontSize: TEXT_REGULAR_3X,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    TitleText("Nov 4 2016")
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
