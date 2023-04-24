import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

const testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

const testSeries = Series(
  posterPath: '/wQoosZYg9FqPrmI4zeCLRdEbqAB.jpg',
  popularity: 24.933765,
  id: 1418,
  backdropPath: '/nGsNruW3W27V6r4gkyc3iiEGsKR.jpg',
  voteAverage: 7.21,
  overview:
      "The Big Bang Theory is centered on five characters living in Pasadena, California: roommates Leonard Hofstadter and Sheldon Cooper; Penny, a waitress and aspiring actress who lives across the hall; and Leonard and Sheldon's equally geeky and socially awkward friends and co-workers, mechanical engineer Howard Wolowitz and astrophysicist Raj Koothrappali. The geekiness and intellect of the four guys is contrasted for comic effect with Penny's social skills and common sense.",
  firstAirDate: '2007-09-24',
  genreIds: [35],
  voteCount: 597,
  name: 'The Big Bang Theory',
  originalName: 'The Big Bang Theory',
);

final testMovieList = [testMovie];
final testSeriesList = [testSeries];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testSeriesDetail = SeriesDetail(
  posterPath: '/wQoosZYg9FqPrmI4zeCLRdEbqAB.jpg',
  id: 1418,
  backdropPath: '/nGsNruW3W27V6r4gkyc3iiEGsKR.jpg',
  voteAverage: 7.21,
  overview:
      "The Big Bang Theory is centered on five characters living in Pasadena, California: roommates Leonard Hofstadter and Sheldon Cooper; Penny, a waitress and aspiring actress who lives across the hall; and Leonard and Sheldon's equally geeky and socially awkward friends and co-workers, mechanical engineer Howard Wolowitz and astrophysicist Raj Koothrappali. The geekiness and intellect of the four guys is contrasted for comic effect with Penny's social skills and common sense.",
  firstAirDate: '2007-09-24',
  voteCount: 597,
  name: 'The Big Bang Theory',
  originalName: 'The Big Bang Theory',
  genres: [
    Genre(id: 35, name: 'Comedy'),
  ],
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  seasons: [testSeason],
);

const testSeason = Season(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testSeasonModel = SeasonModel(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testSeriesDetailModel = SeriesDetailModel(
  posterPath: '/wQoosZYg9FqPrmI4zeCLRdEbqAB.jpg',
  id: 1418,
  backdropPath: '/nGsNruW3W27V6r4gkyc3iiEGsKR.jpg',
  voteAverage: 7.21,
  overview:
      "The Big Bang Theory is centered on five characters living in Pasadena, California: roommates Leonard Hofstadter and Sheldon Cooper; Penny, a waitress and aspiring actress who lives across the hall; and Leonard and Sheldon's equally geeky and socially awkward friends and co-workers, mechanical engineer Howard Wolowitz and astrophysicist Raj Koothrappali. The geekiness and intellect of the four guys is contrasted for comic effect with Penny's social skills and common sense.",
  firstAirDate: '2007-09-24',
  voteCount: 597,
  name: 'The Big Bang Theory',
  originalName: 'The Big Bang Theory',
  genres: [
    GenreModel(id: 35, name: 'Comedy'),
  ],
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  seasons: [testSeasonModel],
);

const testEpisodeModel = EpisodeModel(
  airDate: 'airDate',
  name: 'name',
  overview: 'overview',
  episodeNumber: 1,
  id: 1,
  voteCount: 1,
  voteAverage: 1,
  stillPath: 'stillPath',
  seasonNumber: 1,
  productionCode: 'productionCode',
);

final testEpisode = testEpisodeModel.toEntity();

const testSeasonDetailModel = SeasonDetailModel(
  id: 1,
  airDate: 'airDate',
  episodes: [testEpisodeModel],
  name: 'name',
  overview: 'overview',
  seasonDetailModelId: 1,
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final testSeasonDetail = testSeasonDetailModel.toEntity();

const testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistSeries = Series.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testSeriesTable = SeriesTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'series': 0,
};

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'series': 1,
};
