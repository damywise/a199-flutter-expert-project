import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesModel = SeriesModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: 'Original Title',
    overview: 'Overview',
    popularity: 1,
    posterPath: '/path.jpg',
    firstAirDate: '2020-05-05',
    name: 'Title',
    voteAverage: 1,
    voteCount: 1,
  );

  const tSeriesResponseModel =
      SeriesResponse(results: <SeriesModel>[tSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final jsonMap = tSeriesModel.toJson();
      // act
      final result = SeriesResponse.fromJson({
        'results': [jsonMap]
      }).seriesList;

      // assert
      expect(result, tSeriesResponseModel.seriesList);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        'page': null,
        'results': [
          tSeriesModel,
        ],
        'total_pages': null,
        'total_results': null
      };
      expect(result, expectedJsonMap);
    });
  });
}
