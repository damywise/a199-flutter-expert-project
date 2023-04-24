// To parse this JSON data, do
//
//     final seasonDetailModel = seasonDetailModelFromJson(jsonString);

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_detail_model.freezed.dart';

part 'season_detail_model.g.dart';

@freezed
class SeasonDetailModel with _$SeasonDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SeasonDetailModel({
    int? id,
    String? airDate,
    List<EpisodeModel>? episodes,
    String? name,
    String? overview,
    int? seasonDetailModelId,
    String? posterPath,
    int? seasonNumber,
  }) = _SeasonDetailModel;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonDetailModelFromJson(json);
}

extension SeasonModelExtension on SeasonDetailModel {
  SeasonDetail toEntity() => SeasonDetail(
        id: id!,
        airDate: airDate!,
        episodes: episodes?.map((e) => e.toEntity()).toList() ?? [],
        name: name!,
        overview: overview!,
        seasonDetailModelId: seasonDetailModelId,
        posterPath: posterPath ?? '',
        seasonNumber: seasonNumber!,
      );
}
