import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genres_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constant/api_constant.dart';
import 'package:movie_app/network/the_movie_api.dart';

import 'movie_data_agent.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieAPI movieAPI;
  static final RetrofitDataAgentImpl _singleton=RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl()=>_singleton;

  RetrofitDataAgentImpl._internal(){
    final dio = Dio();
    movieAPI = TheMovieAPI(dio);
  }
  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return movieAPI
        .getNowPlayingMovies(API_KEY, LANGUAGE, page.toString()).asStream().map((response) => response.results).first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return movieAPI.getActors(API_KEY, LANGUAGE, page.toString()).asStream().map((response) => response.result).first;
  }

  @override
  Future<List<GenresVO>?> getGenres() {
    return movieAPI.getGenres(API_KEY, LANGUAGE).asStream().map((response) => response.genres).first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenres(int generesID) {
    return movieAPI.getMoviesByGenres(generesID.toString(), API_KEY, LANGUAGE).asStream().map((response) =>response.results).first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovie(int page) {
    return movieAPI.getPopularMovie(API_KEY, LANGUAGE, page.toString()).asStream().map((response) => response.results).first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovie(int page) {
    return movieAPI.getTopRatedMovie(API_KEY, LANGUAGE, page.toString()).asStream().map((response) => response.results).first;
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieID) {
   return movieAPI.getCreditsByMovie(movieID.toString(), API_KEY).asStream().map((getCreditsByMovieResponse){
     return [getCreditsByMovieResponse.cast,getCreditsByMovieResponse.crew];
   }).first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieID) {
   return movieAPI.getMovieDetails(movieID.toString(), API_KEY);
  }

  // @override
  // Future<List<ActorVO>?> getCreditsByMoviesCast(int movieID) {
  //   return movieAPI.getCreditsByMovie(movieID.toString(), API_KEY).asStream().map((response) => response.cast).first;
  // }
  //
  // @override
  // Future<List<ActorVO>?> getCreditsByMoviesCrew(int movieID) {
  //   return movieAPI.getCreditsByMovie(movieID.toString(), API_KEY).asStream().map((response) => response.crew).first;
  // }
}
