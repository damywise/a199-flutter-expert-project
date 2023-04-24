// To parse this JSON data, do
//
//     final seriesModel = seriesModelFromJson(jsonString);

import 'package:ditonton/domain/entities/series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_model.freezed.dart';

part 'series_model.g.dart';

@freezed
class SeriesModel with _$SeriesModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SeriesModel({
    String? backdropPath,
    String? firstAirDate,
    List<int>? genreIds,
    int? id,
    String? name,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    double? voteAverage,
    int? voteCount,
  }) = _SeriesModel;

  factory SeriesModel.fromJson(Map<String, dynamic> json) =>
      _$SeriesModelFromJson(json);
}

extension SeriesModelExtension on SeriesModel {
  Series toEntity() => Series(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate.toString(),
        genreIds: genreIds,
        id: id!,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
