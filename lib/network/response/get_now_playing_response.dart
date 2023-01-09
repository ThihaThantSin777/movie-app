import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/date_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

part 'get_now_playing_response.g.dart';
@JsonSerializable()
class MovieListResponse{
  @JsonKey(name: "results")
  List<MovieVO>?results;

  @JsonKey(name: 'page')
  int ?page;

  @JsonKey(name: 'dates')
  DateVO? date;

  MovieListResponse(this.results, this.page, this.date);

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}