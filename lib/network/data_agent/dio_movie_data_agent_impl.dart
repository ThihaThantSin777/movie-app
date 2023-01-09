// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../api_constant/api_constant.dart';
// import 'movie_data_agent.dart';
//
// class DIOMovieDataAgentImpl extends MovieDataAgent {
//   @override
//   void getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE,
//       PARAM_PAGE: page.toString(),
//     };
//
//     Dio()
//         .get("$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
//             queryParameters: queryParameters)
//         .then((value) {
//       debugPrint("Now Playing Movie ===========> ${value.toString()}");
//     }).catchError((onError) {
//       debugPrint("Error ===========> ${onError.toString()}");
//     });
//   }
// }
