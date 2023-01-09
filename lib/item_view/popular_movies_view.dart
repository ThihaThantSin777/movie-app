import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widget/rating_level_view.dart';

class PopularMovies extends StatelessWidget {
  final MovieVO? movieVO;
  PopularMovies({required this.movieVO});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: POPULAR_MARGIN_LEFT),
      margin: const EdgeInsets.only(right: POPULAR_MARGIN_RIGHT),
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopularMovieImageView('$BASE_IMAGE_URL${movieVO?.posterPath??""}'),
          const SizedBox(
            height: 10,
          ),
           PopularMovieTextView(
             movieVO?.title??""
           ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              RationPoint(),
              SizedBox(
                width: 10,
              ),
              RatingLevel(),
            ],
          ),
        ],
      ),
    );
  }
}

class RationPoint extends StatelessWidget {
  const RationPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '8.90',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: RATION_POINT_FONT_SIZE),
    );
  }
}

class PopularMovieTextView extends StatelessWidget {
  final String movieName;
  PopularMovieTextView(this.movieName);

  @override
  Widget build(BuildContext context) {
    return  Text(
      movieName,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: TEXT_REGULAR),
    );
  }
}

class PopularMovieImageView extends StatelessWidget {
 final String posterPath;

 PopularMovieImageView(this.posterPath);

  @override
  Widget build(BuildContext context) {
    return Image.network(
     posterPath,
      height: MediaQuery.of(context).size.height / 4,
      fit: BoxFit.cover,
    );
  }
}
