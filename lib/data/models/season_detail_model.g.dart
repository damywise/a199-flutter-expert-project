// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SeasonDetailModel _$$_SeasonDetailModelFromJson(Map<String, dynamic> json) =>
    _$_SeasonDetailModel(
      id: json['id'] as int?,
      airDate: json['air_date'] as String?,
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      seasonDetailModelId: json['season_detail_model_id'] as int?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int?,
    );

Map<String, dynamic> _$$_SeasonDetailModelToJson(
        _$_SeasonDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'air_date': instance.airDate,
      'episodes': instance.episodes,
      'name': instance.name,
      'overview': instance.overview,
      'season_detail_model_id': instance.seasonDetailModelId,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
    };
