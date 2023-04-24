import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  group('MovieSearchBloc', () {
    late SearchMovies searchMovies;

    setUp(() {
      searchMovies = MockSearchMovies();
    });

    blocTest<MovieSearchBloc, MovieSearchState>(
      'emits [GetMovieSearchInProgressState, GetMovieSearchCompletedState] when GetMovieSearchEvent is added',
      build: () => MovieSearchBloc(searchMovies: searchMovies),
      act: (bloc) {
        when(() => searchMovies.execute('query'))
            .thenAnswer((invocation) async => Right(testMovieList));
        bloc.add(GetMovieSearchEvent(query: 'query'));
      },
      expect: () => [
        isA<GetMovieSearchInProgressState>(),
        predicate<GetMovieSearchCompletedState>(
            (state) => state.data == testMovieList),
      ],
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'emits [GetMovieSearchInProgressState, GetMovieSearchFailedState] when SearchMovies throws an exception',
      build: () => MovieSearchBloc(searchMovies: searchMovies),
      act: (bloc) {
        when(() => searchMovies.execute('query')).thenAnswer(
            (invocation) async => const Left(ServerFailure('failed')));
        bloc.add(GetMovieSearchEvent(query: 'query'));
      },
      expect: () => [
        isA<GetMovieSearchInProgressState>(),
        predicate<GetMovieSearchFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'failed')),
      ],
    );
  });
}
