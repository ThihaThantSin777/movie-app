import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieDataAgent {
  Future<List<MovieVO>?> getNowPlayingMovies(int page);

  Future<List<MovieVO>?>getTopRatedMovie(int page);

  Future<List<MovieVO>?>getPopularMovie(int page);

  Future<List<GenresVO>?>getGenres();

  Future<List<MovieVO>?>getMoviesByGenres(int generesID);

  Future<List<ActorVO>?>getActors(int page);

  Future<MovieVO?>getMovieDetails(int movieID);

   Future<List<List<ActorVO>?>> getCreditsByMovie(int movieID);

}
