import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/data_agent/movie_data_agent.dart';
import 'package:movie_app/network/data_agent/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistance/daos/actor_daos.dart';
import 'package:movie_app/persistance/daos/genre_daos.dart';
import 'package:movie_app/persistance/daos/movie_daos.dart';

class MovieModelImpl extends MovieModel {
  final MovieDataAgent _dataAgent = RetrofitDataAgentImpl();
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() => _singleton;

  MovieModelImpl._internal();

  MovieDao movieDao = MovieDao();
  GenreDao genreDao = GenreDao();
  ActorDao actorDao = ActorDao();

  @override
  Future<List<MovieVO>?> getNowPlayingMovie() {
    return _dataAgent.getNowPlayingMovies(1).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveMovie(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page).then((actors) async {
      actorDao.saveAllActors(actors!);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenresVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres) async {
      genreDao.saveAllGenres(genres!);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenres(int generesID) {
    return _dataAgent.getMoviesByGenres(generesID);
  }

  @override
  Future<List<MovieVO>?> getPopularMovie(int page) {
    return _dataAgent.getPopularMovie(page).then((movies) async {
      List<MovieVO> nowPopularMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveMovie(nowPopularMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovie(int page) {
    return _dataAgent.getTopRatedMovie(page).then((movies) async {
      List<MovieVO> nowTopRatedMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      movieDao.saveMovie(nowTopRatedMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<List<ActorVO>?>?> getCreditsByMovie(int movieID) {
    return _dataAgent.getCreditsByMovie(movieID);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieID) {
    return _dataAgent.getMovieDetails(movieID).then((movie) async {
      movieDao.saveSingleMovie(movie!);
      return Future.value(movie);
    });
  }

  //Database
  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(actorDao.getAllActors());
  }

  @override
  Future<List<GenresVO>> getGenresFromDatabase() {
    return Future.value(genreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieID) {
    return Future.value(movieDao.getMovieByID(movieID));
  }

  @override
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    return Future.value(
        movieDao.getAllMovies().where((movie) => movie.isNowPlaying??true).toList());
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    return Future.value(
        movieDao.getAllMovies().where((movie) => movie.isPopular??true).toList());
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    return Future.value(
        movieDao.getAllMovies().where((movie) => movie.isTopRated??true).toList());
  }

  // @override
  // Future<List<ActorVO>?> getCreditsByMoviesCast(int movieID) {
  //  return _dataAgent.getCreditsByMoviesCast(movieID);
  // }
  //
  // @override
  // Future<List<ActorVO>?> getCreditsByMoviesCrew(int movieID) {
  //   return _dataAgent.getCreditsByMoviesCrew(movieID);
  // }

}
