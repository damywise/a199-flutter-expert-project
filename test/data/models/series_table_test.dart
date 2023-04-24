import 'package:ditonton/data/models/series_table.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesTable = SeriesTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tSeriesTableJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
    'series': 1,
  };

  const tSeriesDetail = SeriesDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 0,
    seasons: [],
  );

  test('should be a subclass of Json', () async {
    final result = tSeriesTable.toJson();
    expect(result, tSeriesTableJson);
  });

  test('should be a subclass of SeriesTable', () async {
    final result = SeriesTable.fromMap(tSeriesTableJson);
    expect(result, tSeriesTable);
  });

  test(
    'should be a subclass of SeriesTable',
    () async {
      final result = SeriesTable.fromEntity(tSeriesDetail);
      expect(result, tSeriesTable);
    },
  );

  test(
    'should be a subclass of Series',
    () async {
      final result = tSeriesTable.toEntity();
      expect(
        result,
        const Series(
          backdropPath: null,
          firstAirDate: null,
          genreIds: [],
          id: 1,
          originalName: null,
          overview: 'overview',
          popularity: null,
          posterPath: 'posterPath',
          name: 'title',
          voteAverage: null,
          voteCount: null,
        ),
      );
    },
  );
}
