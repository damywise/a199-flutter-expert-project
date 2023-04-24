import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecase;
  late RemoveWatchlistSeries usecaseSeries;
  late MockMovieRepository mockMovieRepository;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlistMovie(mockMovieRepository);
    usecaseSeries = RemoveWatchlistSeries(mockSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });

  test('should remove watchlist series from repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlist(testSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecaseSeries.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlist(testSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
