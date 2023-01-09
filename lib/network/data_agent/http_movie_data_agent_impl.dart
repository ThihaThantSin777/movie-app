// import 'package:flutter/cupertino.dart';
// import 'package:movie_app/network/api_constant/api_constant.dart';
// import 'package:http/http.dart' as http;
//
// import 'movie_data_agent.dart';
//
// class HTTPMovieDataAgentIMPL extends MovieDataAgent {
//   @override
//   void getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE,
//       PARAM_PAGE: page.toString(),
//     };
//
//     var url = Uri.https(BASE_URL, ENDPOINT_GET_NOW_PLAYING, queryParameters);
//     print(url);
//     print("");
//     http.get(url).then((value) {
//       debugPrint("Now Playing Movie ===========> ${value.body.toString()}");
//     }).catchError((onError) {
//       debugPrint("Error ===========> ${onError.toString()}");
//     });
//   }
// }
