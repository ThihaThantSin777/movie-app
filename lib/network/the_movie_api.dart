import 'package:dio/dio.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/response/get_actor_response.dart';
import 'package:movie_app/network/response/get_credit_by_movie_response.dart';
import 'package:movie_app/network/response/get_genres_response.dart';
import 'package:movie_app/network/response/get_now_playing_response.dart';
import 'package:retrofit/http.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieAPI {
  factory TheMovieAPI(Dio dio) = _TheMovieAPI;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<MovieListResponse> getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_TOP_RATED)
  Future<MovieListResponse>getTopRatedMovie(
      @Query(PARAM_API_KEY)String apiKey,
  @Query(PARAM_LANGUAGE)String language,
      @Query(PARAM_PAGE)String page,
      );
@GET(ENDPOINT_GET_POPULAR)
  Future<MovieListResponse>getPopularMovie(
      @Query(PARAM_API_KEY)String apiKey,
      @Query(PARAM_LANGUAGE)String language,
      @Query(PARAM_PAGE)String page,

      );

@GET(ENDPOINT_GET_GENERS)
Future<GetGenresResponse>getGenres(
    @Query(PARAM_API_KEY)String apiKey,
    @Query(PARAM_LANGUAGE)String language
    );

@GET(ENDPOINT_GET_MOVIES_BY_GENERS)
Future<MovieListResponse>getMoviesByGenres(
    @Query(PARAM_GENRE_ID)String genresID,
    @Query(PARAM_API_KEY)String apiKey,
    @Query(PARAM_LANGUAGE)String language
    );

@GET(ENDPOINT_GET_ACTORS)
Future<GetActorResponse>getActors(
    @Query(PARAM_API_KEY)String apiKey,
    @Query(PARAM_LANGUAGE)String language,
    @Query(PARAM_PAGE)String page,
    );

@GET('$ENDPOINT_GET_MOVIE_DETAILS/{movie_id}')
Future<MovieVO>getMovieDetails(
@Path('movie_id') String movieID,
  @Query(PARAM_API_KEY)String apiKey,
    );

@GET('/3/movie/{movie_id}/credits')
Future<GetCreditsByMovieResponse>getCreditsByMovie(
    @Path('movie_id') String movieID,
    @Query(PARAM_API_KEY) String apiKey,
    );
}
