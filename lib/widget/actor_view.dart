import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';
import 'package:movie_app/resources/color_attribute.dart';
import 'package:movie_app/resources/dimens.dart';

class ActorView extends StatelessWidget {
final ActorVO? actorVO;
final String unKnownUrl='https://cdn4.iconfinder.com/data/icons/political-elections/50/48-1024.png';
ActorView({required this.actorVO});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: MOVIE_LIST_WIDTH,
      child: Stack(
        children:  [
          Positioned.fill(child: ActorImageView(
            actorVO?.profilePath==null?unKnownUrl:
            '$BASE_IMAGE_URL${actorVO?.profilePath??""}',
          )),
        const  Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavoriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(
              actorVO?.name??""
            ),
          ),
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String imageUrl;

  ActorImageView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}

class FavoriteButtonView extends StatelessWidget {
  const FavoriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_outline,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String name;

  ActorNameAndLikeView(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
           Text(name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: TEXT_REGULAR)),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
              Text(
                "You liked 13 movies",
                style: TextStyle(
                    color: ACTOR_COLOR,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
