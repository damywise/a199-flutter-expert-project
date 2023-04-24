import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_detail.freezed.dart';

@freezed
class SeriesDetail with _$SeriesDetail {
  const factory SeriesDetail({
    required String? backdropPath,
    required String firstAirDate,
    required List<Genre> genres,
    required int id,
    required String originalName,
    required String overview,
    required String posterPath,
    required String name,
    required double voteAverage,
    required int voteCount,
    required int? numberOfEpisodes,
    required int? numberOfSeasons,
    required List<Season>? seasons,
  }) = _SeriesDetail;
}
