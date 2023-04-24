import 'package:ditonton/domain/entities/episode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_model.freezed.dart';

part 'episode_model.g.dart';

@freezed
class EpisodeModel with _$EpisodeModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EpisodeModel({
    String? airDate,
    int? episodeNumber,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? seasonNumber,
    String? stillPath,
    double? voteAverage,
    int? voteCount,
  }) = _EpisodeModel;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
}

extension EpisodeModelExtension on EpisodeModel {
  Episode toEntity() => Episode(
        name: name,
        overview: overview,
        airDate: airDate,
        episodeNumber: episodeNumber,
        id: id,
        productionCode: productionCode,
        seasonNumber: seasonNumber,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
