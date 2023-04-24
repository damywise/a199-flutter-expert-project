import 'package:ditonton/domain/entities/episode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_detail.freezed.dart';

@freezed
class SeasonDetail with _$SeasonDetail {
  const factory SeasonDetail({
    required int id,
    required String airDate,
    required List<Episode> episodes,
    required String name,
    required String overview,
    required int? seasonDetailModelId,
    required String posterPath,
    required int seasonNumber,
  }) = _SeasonDetail;
}
