import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/resources/color_attribute.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widget/actor_view.dart';
import 'package:movie_app/widget/title_text_see_more_view.dart';

class BestActorAndCreatorSessionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool visibility;
  final List<ActorVO>?actors;

  BestActorAndCreatorSessionView(this.titleText, this.seeMoreText,
      {this.visibility = true,required this.actors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding:
          const EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGINN_XX_LARGE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextSeeMoreView(
              titleText,
              seeMoreText,
              seeMoreVisibility: visibility,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Container(
            height: BEST_ACTORS_HEIGHT,
            child: ListView(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              children: actors?.map((actor) => ActorView(actorVO: actor)).toList()??[]
            ),
          ),
        ],
      ),
    );
  }
}
