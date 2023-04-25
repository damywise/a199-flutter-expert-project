import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:http/io_client.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getNowPlayingSeries();

  Future<List<SeriesModel>> getPopularSeries();

  Future<List<SeriesModel>> getTopRatedSeries();

  Future<SeriesDetailModel> getSeriesDetail(int id);

  Future<SeasonDetailModel> getSeasonDetail(int seriesId, int seasonNumber);

  Future<EpisodeModel> getEpisodeDetail(
    int seriesId,
    int seasonNumber,
    int episodeId,
  );

  Future<List<SeriesModel>> getSeriesRecommendations(int id);

  Future<List<SeriesModel>> searchSeries(String query);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  SeriesRemoteDataSourceImpl({required this.client});
  static const API_KEY = MovieRemoteDataSourceImpl.API_KEY;
  static const BASE_URL = MovieRemoteDataSourceImpl.BASE_URL;

  final IOClient client;

  @override
  Future<List<SeriesModel>> getNowPlayingSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      ).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailModel> getSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesDetailModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      ).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      ).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      ).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      ).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getSeasonDetail(
    int seriesId,
    int seasonNumber,
  ) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$seriesId/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EpisodeModel> getEpisodeDetail(
    int seriesId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    final response = await client.get(
      Uri.parse(
        '$BASE_URL/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber?$API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return EpisodeModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
