
import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/persistance/hive_constant.dart';

class GenreDao{
  static final GenreDao _singleton=GenreDao.internal();

  factory GenreDao()=>_singleton;

  GenreDao.internal();

  void saveAllGenres(List<GenresVO>genreList)async{

    Map<int,GenresVO>genreMap=Map.fromIterable(genreList,key: (genre)=>genre.id,value: (genre)=>genre);
    await getGenreBox().putAll(genreMap);
  }

  List<GenresVO>getAllGenres()=>getGenreBox().values.toList();

  Box<GenresVO>getGenreBox()=> Hive.box<GenresVO>(BOX_NAME_GENRESVO);

}