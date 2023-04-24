import 'package:ditonton/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: List<MovieModel>.from(
          (json['results'] as List)
              .map((x) => MovieModel.fromJson(x as Map<String, dynamic>))
              .where((element) => element.posterPath != null),
        ),
      );
  final List<MovieModel> movieList;

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
