import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  group('DatabaseHelper tests', () {
    late MockDatabaseHelper databaseHelper;

    setUp(() {
      databaseHelper = MockDatabaseHelper();
    });

    test('Insert watchlist movie', () async {
      when(databaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((realInvocation) async => testMovieTable.id);
      final result = await databaseHelper.insertWatchlist(testMovieTable);
      expect(result, 1);
    });

    test('Remove watchlist movie', () async {
      when(databaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((realInvocation) async => testMovieTable.id);
      final result = await databaseHelper.removeWatchlist(testMovieTable);
      expect(result, 1);
    });

    test('Get movie by id', () async {
      when(databaseHelper.getMovieById(testMovieTable.id))
          .thenAnswer((realInvocation) async => testMovieTable.toJson());
      final result = await databaseHelper.getMovieById(testMovieTable.id);
      expect(result?['title'], testMovieTable.title);
    });

    test('Get all watchlist movies', () async {
      when(databaseHelper.getWatchlistMovies()).thenAnswer(
          (realInvocation) async =>
              [testMovieTable.toJson(), testMovieTable.toJson()]);
      final result = await databaseHelper.getWatchlistMovies();
      expect(result.length, 2);
    });
  });
}
