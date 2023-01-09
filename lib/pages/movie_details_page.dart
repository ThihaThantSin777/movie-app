import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/data/model/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/item_view/title_text_view.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';
import 'package:movie_app/resources/color_attribute.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widget/actor_and_creators_session_view.dart';
import 'package:movie_app/widget/gradient_widget.dart';
import 'package:movie_app/widget/rating_level_view.dart';

class MovieDetailsPage extends StatefulWidget {

  final int movieID;

  MovieDetailsPage({required this.movieID});
  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieModel _movieModel=MovieModelImpl();
  MovieVO? movieDetails;
  List<ActorVO>?cast;
  List<ActorVO>?crew;

  @override
  void initState() {
   _movieModel.getMovieDetails(widget.movieID).then((movieDetails) {
     setState(() {
      this. movieDetails=movieDetails;
     });
   }).catchError((error)=>print(error.toString()));

   _movieModel.getMovieDetailsFromDatabase(widget.movieID).then((movie){
     setState(() {
       movieDetails=movie;
     });
   });

   _movieModel.getCreditsByMovie(widget.movieID).then((castAndCrew){
     setState(() {
       cast=castAndCrew?.first;
       crew=castAndCrew?[1];
     });



   }).catchError((error)=>print(error.toString()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(() => _back(context),movieVO: movieDetails,),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: TrailarSession(generalList: movieDetails?.getGenreListAsStringList()??[],storyLine: movieDetails?.overview??"",),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              BestActorAndCreatorSessionView(
                MOVIE_DETAILS_SCREEN_ACTOR,
                "",
                visibility: false,
                actors: cast,
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child:  AboutFlimSessionView(
                  movieVO: movieDetails,
                ),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              BestActorAndCreatorSessionView(
                MOVIE_DETAILS_SCREEN_CREATOR,
                MOVIE_DETAILS_SCREEN_SEE_MORE,
                actors: crew,
              )
            ]))
          ],
        ),
      ),
    );
  }

  void _back(context) {
    Navigator.pop(context);
  }
}

class AboutFlimSessionView extends StatelessWidget {
  final MovieVO ? movieVO;

  AboutFlimSessionView({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleText("ABOUT FLIM"),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFlimInfoView('Original Tital', movieVO?.title??""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFlimInfoView('Type', movieVO?.getGenreListAsCommaSepratedString()??""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFlimInfoView('Production', movieVO?.getProductionCountriesAsCommaSepratedString()??""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFlimInfoView('Premiere', movieVO?.releaseDate??""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFlimInfoView(
        'Description',
        movieVO?.overview??""
      ),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
    ]);
  }
}

class AboutFlimInfoView extends StatelessWidget {
  final String label;
  final String description;
  AboutFlimInfoView(this.label, this.description);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: const TextStyle(
                color: MOVIE_DETAILS_INFO_TEXT,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class TrailarSession extends StatelessWidget {
  final List<String> generalList;
  final String storyLine;
  TrailarSession({required this.generalList,required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGeneralView(generalList: generalList),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
         StoryLineView(
          storyLine: storyLine
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            MovieDetailsScreenButtonView('PLAY TRAILAR', PLAY_BUTTON_COLOR,
                const Icon(Icons.play_circle_fill)),
            const SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
              'RATE MOVIE',
              HOME_SCREEN_COLOR,
              const Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String titel;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.titel, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGINN_XM_LARGE,
      decoration: BoxDecoration(
          color: backgroundColor,
          border:
              isGhostButton ? Border.all(color: Colors.white, width: 2) : null,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(
              width: MARGIN_MEDIUMX,
            ),
            Text(
              titel,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String storyLine;

  StoryLineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORY_LINE_TITLE),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
         Text(
          storyLine,
          style: const TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
        ),
      ],
    );
  }
}

class MovieTimeAndGeneralView extends StatelessWidget {
  const MovieTimeAndGeneralView({
    Key? key,
    required this.generalList,
  }) : super(key: key);

  final List<String> generalList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        const Text(
          '2 hours 30 mins',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        ...generalList.map((genre) => GeneralChipView(genre)),
        const Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
        )
      ],
    );
  }
}

class GeneralChipView extends StatelessWidget {
  final String generalText;
  GeneralChipView(this.generalText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
            backgroundColor: MOVIE_DETAILS_SCREEN_CHIP,
            label: Text(
              generalText,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          width: MARGIN_SMALL_1x,
        ),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movieVO;
  final String unKnownUrl='https://cdn4.iconfinder.com/data/icons/political-elections/50/48-1024.png';
  MovieDetailsSliverAppBarView(this.onTapBack,{required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_SILVER_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
             Positioned.fill(
              child: MovieDetailsAppBarImageView(
                imageUrl: movieVO?.posterPath==null?unKnownUrl:'$BASE_IMAGE_URL${movieVO?.posterPath}'
              ),
            ),
            const Positioned.fill(child: GradientWidget()),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: MARGINN_XX_LARGE, left: TEXT_REGULAR_2X),
                child: BackButtonView(() {
                  onTapBack();
                }),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGINN_XX_LARGE + MARGIN_MEDIUM,
                    right: TEXT_REGULAR_2X),
                child: SearchButtonView(),
              ),
            ),
             Align(
              alignment: Alignment.bottomLeft,
              child:  Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailsAppBarInfoView(
                  movieVO: movieVO,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO? movieVO;
  MovieDetailsAppBarInfoView({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
             MovieDetailsYearView(
              year: movieVO?.releaseDate?.substring(0,4)??"",
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RatingLevel(),
                    const SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("${movieVO?.voteCount} VOTES"),
                    const SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM_2,
                ),
                 Text(
                  movieVO?.voteAverage.toString()??"",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
         Text(
          movieVO?.title.toString()??"",
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;
  MovieDetailsYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child:  Center(
        child: Text(
          year,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      height: MARGINN_X_LARGE,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(TEXT_REGULAR_2X)),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGINN_X_LARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        width: MARGINN_X_LARGE,
        height: MARGINN_X_LARGE,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGINN_X_LARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
 final String imageUrl;
 MovieDetailsAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
