import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
class Episode with _$Episode {
  const factory Episode({
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
  }) = _Episode;
}
