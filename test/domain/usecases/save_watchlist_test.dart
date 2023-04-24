import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistMovie usecase;
  late MockMovieRepository mockMovieRepository;
  late SaveWatchlistSeries usecaseSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistMovie(mockMovieRepository);
    mockSeriesRepository = MockSeriesRepository();
    usecaseSeries = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, const Right('Added to Watchlist'));
  });

  test('should save series to the repository', () async {
    // arrange
    when(mockSeriesRepository.saveWatchlist(testSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecaseSeries.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.saveWatchlist(testSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
