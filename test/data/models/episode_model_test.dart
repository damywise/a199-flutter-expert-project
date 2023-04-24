import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    name: 'name',
    overview: 'overview',
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  const tEpisode = Episode(
    name: 'name',
    overview: 'overview',
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Series entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });

  test('should be a subclass of EpisodeModel', () async {
    final result = EpisodeModel.fromJson(tEpisodeModel.toJson());
    expect(result, tEpisodeModel);
  });
}
