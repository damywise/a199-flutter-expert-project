import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesDetailModel = SeriesDetailModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originCountry: ['ID'],
  );

  const tSeriesDetail = SeriesDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    genres: [],
    numberOfEpisodes: null,
    numberOfSeasons: null,
    seasons: [],
  );

  test('should be a subclass of SeriesDetail entity', () async {
    final result = tSeriesDetailModel.toEntity();
    expect(result, tSeriesDetail);
  });

  test('should be a subclass of SeriesDetailModel', () async {
    final result = SeriesDetailModel.fromJson(tSeriesDetailModel.toJson());
    expect(result, tSeriesDetailModel);
  });
}
