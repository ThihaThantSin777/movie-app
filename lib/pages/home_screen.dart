import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/data/model/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/widget/actor_and_creators_session_view.dart';
import 'package:movie_app/widget/see_more_text.dart';
import 'package:movie_app/widget/show_case_view.dart';
import 'package:movie_app/widget/title_text_see_more_view.dart';
import 'package:movie_app/resources/color_attribute.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/item_view/banner_view.dart';
import 'package:movie_app/item_view/popular_movies_view.dart';
import 'package:movie_app/item_view/title_text_view.dart';
import 'package:movie_app/resources/strings.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel movieModel = MovieModelImpl();
  List<MovieVO>? getNowPlayingMoviesList;
  List<MovieVO>? getTopRatedMoviesList;
  List<MovieVO>? getPopularMoviesList;
  List<GenresVO>? getGenresList;
  List<MovieVO>? getMoviesByGenresList;
  List<ActorVO>? getActorsList;

  @override
  void initState() {
    //Get Now Playing
    movieModel.getNowPlayingMovie().then((movieList) {
      setState(() {
        getNowPlayingMoviesList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    movieModel.getNowPlayingMoviesFromDatabase().then((movieList) {
      setState(() {
        getNowPlayingMoviesList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    //Get Top Rated
    movieModel.getTopRatedMovie(1).then((movieList) {
      setState(() {
        getTopRatedMoviesList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    movieModel.getTopRatedMoviesFromDatabase().then((movieList) {
      setState(() {
        getTopRatedMoviesList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    //Get Popular
    movieModel.getPopularMovie(1).then((movieList) {
      setState(() {
        getPopularMoviesList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    movieModel.getPopularMoviesFromDatabase().then((movieList) {
      setState(() {
        getPopularMoviesList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    //Get Genres
    movieModel.getGenres().then((movieList) {
      setState(() {
        getGenresList = movieList;
      });
      _getMoviesByGenresID(movieList?.first.id ?? 0);
    }).catchError((error) => debugPrint(error.toString()));

    movieModel.getGenresFromDatabase().then((movieList) {
      setState(() {
        getGenresList = movieList;
      });
      _getMoviesByGenresID(movieList.first.id ?? 0);
    }).catchError((error) => debugPrint(error.toString()));

    //Get Actor
    movieModel.getActors(1).then((movieList) {
      setState(() {
        getActorsList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));

    movieModel.getAllActorsFromDatabase().then((movieList) {
      setState(() {
        getActorsList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));
    super.initState();
  }

  void _getMoviesByGenresID(int id) {
    movieModel.getMoviesByGenres(id).then((movieList) {
      setState(() {
        getMoviesByGenresList = movieList;
      });
    }).catchError((error) => debugPrint(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HOME_SCREEN_COLOR,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          title: const Text(
            APP_BAR_TITLE_NAME,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                  top: 0, left: 0, bottom: 0, right: RIGHT_PADDING_VALUE),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerMainView(
                movieList: getPopularMoviesList?.take(5).toList(),
              ),
              const SizedBox(
                height: SIZE_BOX_15_TIMES,
              ),
              const PopularMovieTitle(),
              const SizedBox(
                height: SIZE_BOX_10_TIMES,
              ),
              PopularMovieSessionView(
                (movieID) {
                  if (movieID != null) {
                    _navigateMovieView(context, movieID);
                  }
                },
                movieList: getNowPlayingMoviesList,
              ),
              const SizedBox(
                height: SIZE_BOX_10_TIMES,
              ),
              const CheckMoviewShowTimeSession(),
              const SizedBox(
                height: SIZE_BOX_15_TIMES,
              ),
              GeneralSessionView(
                generList: getGenresList,
                movieList: getMoviesByGenresList,
                onTapMovie: (movieID) {
                  if (movieID != null) {
                    _navigateMovieView(context, movieID);
                  }
                },
                onChooseGeneres: (id) {
                  if (id != null) {
                    _getMoviesByGenresID(id);
                  }
                },
              ),
              const SizedBox(
                height: SIZE_BOX_30_TIMES,
              ),
              ShowCasesSession(
                movies: getTopRatedMoviesList,
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              BestActorAndCreatorSessionView(
                BEST_ACTOR_TITLE,
                BEST_MORE_ACTORS,
                actors: getActorsList,
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
            ],
          ),
        ));
  }

  void _navigateMovieView(context, movieID) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailsPage(
        movieID: movieID,
      );
    }));
  }
}

class GeneralSessionView extends StatelessWidget {
  final List<GenresVO>? generList;
  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGeneres;

  GeneralSessionView(
      {required this.generList,
      required this.movieList,
      required this.onTapMovie,
      required this.onChooseGeneres});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: generList?.length ?? 0,
            child: TabBar(
                indicatorColor: PLAY_BUTTON_COLOR,
                unselectedLabelColor: POPULAR_MOVIE_TITLE_COLOR,
                isScrollable: true,
                onTap: (index) {
                  onChooseGeneres(generList?[index].id);
                },
                tabs: generList
                        ?.map(
                          (geners) => Tab(
                            child: Text(geners.name ?? ""),
                          ),
                        )
                        .toList() ??
                    []),
          ),
        ),
        const SizedBox(
          height: SIZE_BOX_15_TIMES,
        ),
        HorizontalMovieListView(
            movieList: movieList, onTapMovie: (movieID) => onTapMovie(movieID))
      ],
    );
  }
}

class CheckMoviewShowTimeSession extends StatelessWidget {
  const CheckMoviewShowTimeSession({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MARGIN_LARGE),
      color: PRIMARY_COLOR,
      height: SHOWTIME_SESSION_HEIGHT,
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(SCREEN_CHECK_MOVIEW_SHOW_TIME,
                style: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
            const Spacer(),
            SeeMoreText(
              SEE_MORE_ALL_CAP,
              color: Colors.amber,
            )
          ]),
          const Spacer(),
          const Icon(
            Icons.location_on,
            color: Colors.white,
            size: ICON_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}

class ShowCasesSession extends StatelessWidget {
  final List<MovieVO>? movies;

  ShowCasesSession({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child:
                TitleTextSeeMoreView(SHOW_CASES_STRING, SEE_MORE_SHOW_CASES)),
        const SizedBox(
          height: MARGIN_LARGE,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              children: movies
                      ?.map((movies) => ShowCaseView(moviesVO: movies))
                      .toList() ??
                  []),
        ),
      ],
    );
  }
}

class PopularMovieTitle extends StatelessWidget {
  const PopularMovieTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: POPULAR_MARGIN_LEFT),
        child: TitleText(BEST_MOVIE_TILE_NAME));
  }
}

class PopularMovieSessionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  PopularMovieSessionView(this.onTapMovie, {required this.movieList});

  @override
  Widget build(BuildContext context) {
    return HorizontalMovieListView(
        movieList: movieList, onTapMovie: (movieID) => onTapMovie(movieID));
  }
}

class HorizontalMovieListView extends StatelessWidget {
  const HorizontalMovieListView({
    Key? key,
    required this.movieList,
    required this.onTapMovie,
  }) : super(key: key);

  final List<MovieVO>? movieList;
  final Function(int?) onTapMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return movieList != null
                ? GestureDetector(
                    onTap: () => onTapMovie(movieList?[index].id),
                    child: PopularMovies(
                      movieVO: movieList?[index],
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class BannerMainView extends StatefulWidget {
  List<MovieVO>? movieList;
  BannerMainView({required this.movieList});
  @override
  State<BannerMainView> createState() => _BannerMainViewState();
}

class _BannerMainViewState extends State<BannerMainView> {
  double position = 0;
  bool isNull()=>widget.movieList?.isEmpty??true;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: PageView(
            onPageChanged: (val) {
              setState(() {
                position = val.toDouble();
              });
            },
            children: widget.movieList
                    ?.map(
                      (movie) => BannerView(
                        movieVO: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(
          height: SIZE_BOX_10_TIMES,
        ),
        DotsIndicator(
          dotsCount: isNull()?1:widget.movieList?.length??1,
          position: position,
          decorator: const DotsDecorator(
              color: BANNER_IMAGE_PAGE_INDICATOR_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        ),
      ],
    );
  }
}
