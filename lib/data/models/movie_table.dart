import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  const MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'] as int,
        title: map['title'] as String?,
        posterPath: map['posterPath'] as String?,
        overview: map['overview'] as String?,
      );
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'series': 0,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  // TODO(noone): implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
