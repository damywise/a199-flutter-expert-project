import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = SeasonModel(
    name: 'name',
    overview: 'overview',
    airDate: 'airDate',
    seasonNumber: 1,
    id: 1,
    posterPath: 'posterPath',
    episodeCount: 1,
  );

  const tSeason = Season(
    name: 'name',
    overview: 'overview',
    airDate: 'airDate',
    seasonNumber: 1,
    id: 1,
    posterPath: 'posterPath',
    episodeCount: 1,
  );

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });

  test('should be a subclass of SeasonModel', () async {
    final result = SeasonModel.fromJson(tSeasonModel.toJson());
    expect(result, tSeasonModel);
  });
}
