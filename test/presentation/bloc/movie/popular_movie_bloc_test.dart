import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  group('PopularMovieBloc', () {
    late GetPopularMovies popularMovies;

    setUp(() {
      popularMovies = MockGetPopularMovies();
    });

    blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [GetPopularMoviesInProgressState, GetPopularMoviesCompletedState] when GetPopularMoviesEvent is added',
      build: () => PopularMovieBloc(getPopularMovies: popularMovies),
      act: (bloc) {
        when(() => popularMovies.execute())
            .thenAnswer((invocation) async => Right(testMovieList));
        bloc.add(GetPopularMoviesEvent());
      },
      expect: () => [
        isA<GetPopularMoviesInProgressState>(),
        predicate<GetPopularMoviesCompletedState>(
          (state) => state.movies == testMovieList,
        ),
      ],
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [GetPopularMoviesInProgressState, GetPopularMoviesFailedState] when GetPopularMovies throws an exception',
      build: () => PopularMovieBloc(getPopularMovies: popularMovies),
      act: (bloc) {
        when(() => popularMovies.execute()).thenAnswer(
          (invocation) async => const Left(ServerFailure('failed')),
        );
        bloc.add(GetPopularMoviesEvent());
      },
      expect: () => [
        isA<GetPopularMoviesInProgressState>(),
        predicate<GetPopularMoviesFailedState>(
          (state) =>
              state.failure == const GlobalFailureModel(message: 'failed'),
        ),
      ],
    );
  });
}
