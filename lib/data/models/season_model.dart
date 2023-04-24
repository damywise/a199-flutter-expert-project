import 'package:ditonton/domain/entities/season.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_model.freezed.dart';

part 'season_model.g.dart';

@freezed
class SeasonModel with _$SeasonModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SeasonModel({
    String? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
  }) = _SeasonModel;

  factory SeasonModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonModelFromJson(json);
}

extension SeasonModelExtension on SeasonModel {
  Season toEntity() => Season(
        airDate: airDate,
        episodeCount: episodeCount,
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath ?? '',
        seasonNumber: seasonNumber,
      );
}
