import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieModel{

  //Network
  Future<List<MovieVO>?>getNowPlayingMovie();

  Future<List<MovieVO>?>getTopRatedMovie(int page);

  Future<List<MovieVO>?>getPopularMovie(int page);

  Future<List<GenresVO>?>getGenres();

  Future<List<MovieVO>?>getMoviesByGenres(int generesID);

  Future<List<ActorVO>?>getActors(int page);

  Future<MovieVO?>getMovieDetails(int movieID);

  // Future<List<ActorVO>?>getCreditsByMoviesCast(int movieID);

  // Future<List<ActorVO>?>getCreditsByMoviesCrew(int movieID);
  Future<List<List<ActorVO>?>?> getCreditsByMovie(int movieID);



  //Database
  Future<List<MovieVO>>getTopRatedMoviesFromDatabase();

  Future<List<MovieVO>>getNowPlayingMoviesFromDatabase();

  Future<List<MovieVO>>getPopularMoviesFromDatabase();

  Future<List<GenresVO>>getGenresFromDatabase();

  Future<List<ActorVO>>getAllActorsFromDatabase();

  Future<MovieVO>getMovieDetailsFromDatabase(int movieID);


}