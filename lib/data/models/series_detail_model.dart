// To parse this JSON data, do
//
//     final seriesDetailModel = seriesDetailModelFromJson(jsonString);

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_detail_model.freezed.dart';

part 'series_detail_model.g.dart';

@freezed
class SeriesDetailModel with _$SeriesDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SeriesDetailModel({
    String? backdropPath,
    List<int>? episodeRunTime,
    String? firstAirDate,
    List<GenreModel>? genres,
    String? homepage,
    int? id,
    bool? inProduction,
    List<String>? languages,
    String? lastAirDate,
    String? name,
    dynamic nextEpisodeToAir,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<SeasonModel>? seasons,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
  }) = _SeriesDetailModel;

  factory SeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailModelFromJson(json);
}

extension SeriesDetailModelExtension on SeriesDetailModel {
  SeriesDetail toEntity() => SeriesDetail(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate.toString(),
        genres: genres?.map((e) => e.toEntity()).toList() ?? [],
        id: id!,
        originalName: originalName!,
        overview: overview!,
        posterPath: posterPath!,
        name: name!,
        voteAverage: voteAverage!,
        voteCount: voteCount!,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        seasons: seasons?.map((e) => e.toEntity()).toList() ?? [],
      );
}
