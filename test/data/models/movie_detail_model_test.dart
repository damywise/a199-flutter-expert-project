import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [GenreModel(id: 2, name: 'name')],
    homepage: 'homepage',
    id: 3,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 4,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 5,
    runtime: 6,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 7,
    voteCount: 8,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 2, name: 'name')],
    id: 3,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 6,
    title: 'title',
    voteAverage: 7,
    voteCount: 8,
  );

  final tMovieDetailJson = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 1,
    'genres': [{'id': 2, 'name': 'name'}],
    'homepage': 'homepage',
    'id': 3,
    'imdb_id': 'imdbId',
    'original_language': 'originalLanguage',
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 4.0,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'revenue': 5,
    'runtime': 6,
    'status': 'status',
    'tagline': 'tagline',
    'title': 'title',
    'video': false,
    'vote_average': 7.0,
    'vote_count': 8
  };

  test('should be a subclass of MovieDetail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });

  test('should be a subclass of Json', () async {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailJson);
  });
}
