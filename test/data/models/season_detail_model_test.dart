import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonDetailModel = SeasonDetailModel(
    name: 'name',
    overview: 'overview',
    airDate: 'airDate',
    seasonNumber: 1,
    id: 1,
    posterPath: 'posterPath',
    episodes: [],
    seasonDetailModelId: 1,
  );

  const tSeasonDetail = SeasonDetail(
    name: 'name',
    overview: 'overview',
    airDate: 'airDate',
    seasonNumber: 1,
    id: 1,
    posterPath: 'posterPath',
    episodes: [],
    seasonDetailModelId: 1,
  );

  test('should be a subclass of SeasonDetail entity', () async {
    final result = tSeasonDetailModel.toEntity();
    expect(result, tSeasonDetail);
  });

  test('should be a subclass of SeasonDetailModel', () async {
    final result = SeasonDetailModel.fromJson(tSeasonDetailModel.toJson());
    expect(result, tSeasonDetailModel);
  });
}
