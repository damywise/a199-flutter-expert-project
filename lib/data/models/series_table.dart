import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesTable extends Equatable {
  const SeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory SeriesTable.fromEntity(SeriesDetail series) => SeriesTable(
        id: series.id,
        title: series.name,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
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
        'series': 1,
      };

  Series toEntity() => Series.watchlist(
        id: id,
        overview: overview!,
        posterPath: posterPath!,
        title: title!,
      );

  @override
  // TODO(noone): implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
