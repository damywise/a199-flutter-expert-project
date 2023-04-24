import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Series', () {
    final tSeriesList = SeriesResponse.fromJson(
      json.decode(readJson('dummy_data/airing_today.json'))
          as Map<String, dynamic>,
    ).seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/airing_today.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getNowPlayingSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tSeriesList = SeriesResponse.fromJson(
      json.decode(readJson('dummy_data/popular.json')) as Map<String, dynamic>,
    ).seriesList;

    test('should return list of series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(readJson('dummy_data/popular.json'), 200),
      );
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Series', () {
    final tSeriesList = SeriesResponse.fromJson(
      json.decode(readJson('dummy_data/top_rated.json'))
          as Map<String, dynamic>,
    ).seriesList;

    test('should return list of series when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(readJson('dummy_data/top_rated.json'), 200),
      );
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series detail', () {
    const tId = 1;
    final tSeriesDetail = SeriesDetailModel.fromJson(
      json.decode(readJson('dummy_data/series_detail.json'))
          as Map<String, dynamic>,
    );

    test('should return series detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/series_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get season detail', () {
    const tId = 1;
    final tSeasonDetail = SeasonDetailModel.fromJson(
      json.decode(readJson('dummy_data/season_detail.json'))
          as Map<String, dynamic>,
    );

    test('should return season detail when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            '$BASE_URL/tv/$tId/season/${tSeasonDetail.seasonNumber}?$API_KEY',
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/season_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result =
          await dataSource.getSeasonDetail(tId, tSeasonDetail.seasonNumber!);
      // assert
      expect(result, equals(tSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            '$BASE_URL/tv/$tId/season/${tSeasonDetail.seasonNumber!}?$API_KEY',
          ),
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonDetail(tId, tSeasonDetail.seasonNumber!);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get episode detail', () {
    const tId = 1418;
    const tSId = 1;
    final tEpisodeDetail = EpisodeModel.fromJson(
      json.decode(readJson('dummy_data/episode_detail.json'))
          as Map<String, dynamic>,
    );

    test('should return episode detail when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            '$BASE_URL/tv/$tId/season/$tSId/episode/${tEpisodeDetail.episodeNumber}?$API_KEY',
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/episode_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getEpisodeDetail(1418, 1, 1);
      // assert
      expect(result, equals(tEpisodeDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            '$BASE_URL/tv/$tId/season/$tSId/episode/${tEpisodeDetail.episodeNumber}?$API_KEY',
          ),
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call =
          dataSource.getEpisodeDetail(tId, tSId, tEpisodeDetail.episodeNumber!);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series recommendations', () {
    final tSeriesList = SeriesResponse.fromJson(
      json.decode(readJson('dummy_data/series_recommendations.json'))
          as Map<String, dynamic>,
    ).seriesList;
    const tId = 1;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient
            .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/series_recommendations.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient
            .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search series', () {
    final tSearchResult = SeriesResponse.fromJson(
      json.decode(readJson('dummy_data/search_bbt_series.json'))
          as Map<String, dynamic>,
    ).seriesList;
    const tQuery = 'Big%20Bang%20Theory';

    test('should return list of series when response code is 200', () async {
      // arrange
      when(
        mockHttpClient
            .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/search_bbt_series.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(
        mockHttpClient
            .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
