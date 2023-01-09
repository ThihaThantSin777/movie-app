import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/item_view/play_button_view.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widget/gradient_widget.dart';

class BannerView extends StatelessWidget {
  MovieVO ?movieVO;
  BannerView({required this.movieVO});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children:  [
          Positioned.fill(child: BannerImageView('$BASE_IMAGE_URL${movieVO?.posterPath??""}')),
      const    Positioned.fill(child: GradientWidget()),
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTextView(movieVO?.title??" Un Known "),
          ),
       const   Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
        ],
      ),
    );
  }
}

class BannerTextView extends StatelessWidget {
  final String? movieTitle;
  BannerTextView(this.movieTitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:  [
          Text(movieTitle.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: BANNER_TITLE_TEXT_FONT_SIZE)),
         const Text('Official Review',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: BANNER_TITLE_TEXT_FONT_SIZE))
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
 final String imageUrl;
 BannerImageView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
