import 'package:freezed_annotation/freezed_annotation.dart';

part 'season.freezed.dart';

@freezed
class Season with _$Season {
  const factory Season({
    required String? airDate,
    required int? episodeCount,
    required int? id,
    required String? name,
    required String? overview,
    required String? posterPath,
    required int? seasonNumber,
  }) = _Season;
}
