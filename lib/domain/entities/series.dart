import 'package:freezed_annotation/freezed_annotation.dart';

part 'series.freezed.dart';

@freezed
class Series with _$Series {
  const factory Series({
    required String? backdropPath,
    required String? firstAirDate,
    required List<int>? genreIds,
    required int id,
    required String? originalName,
    required String? overview,
    required double? popularity,
    required String? posterPath,
    required String? name,
    required double? voteAverage,
    required int? voteCount,
  }) = _Series;

  factory Series.watchlist({
    required int id,
    required String overview,
    required String posterPath,
    required String title,
  }) =>
      _Series(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
        backdropPath: null,
        genreIds: [],
        originalName: null,
        popularity: null,
        firstAirDate: null,
        voteAverage: null,
        voteCount: null,
      );
}
