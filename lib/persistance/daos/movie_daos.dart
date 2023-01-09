import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistance/hive_constant.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao.internal();

  factory MovieDao() => _singleton;

  MovieDao.internal();

  void saveMovie(List<MovieVO> movieList) async {
    Map<int, MovieVO> genreMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(genreMap);
  }

  void saveSingleMovie(MovieVO movieVO) async =>
      getMovieBox().put(movieVO.id, movieVO);

  List<MovieVO> getAllMovies() => getMovieBox().values.toList();

  MovieVO? getMovieByID(int movieID) => getMovieBox().get(movieID);

  Box<MovieVO> getMovieBox() => Hive.box<MovieVO>(BOX_NAME_MOVIEVO);
}
