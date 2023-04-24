import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  group('TopRatedMovieBloc', () {
    late GetTopRatedMovies topRatedMovies;

    setUp(() {
      topRatedMovies = MockGetTopRatedMovies();
    });

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'emits [GetTopRatedMoviesInProgressState, GetTopRatedMoviesCompletedState] when GetTopRatedMoviesEvent is added',
      build: () => TopRatedMovieBloc(getTopRatedMovies: topRatedMovies),
      act: (bloc) {
        when(() => topRatedMovies.execute())
            .thenAnswer((invocation) async => Right(testMovieList));
        bloc.add(GetTopRatedMoviesEvent());
      },
      expect: () => [
        isA<GetTopRatedMoviesInProgressState>(),
        predicate<GetTopRatedMoviesCompletedState>(
            (state) => state.movies == testMovieList),
      ],
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'emits [GetTopRatedMoviesInProgressState, GetTopRatedMoviesFailedState] when GetTopRatedMovies throws an exception',
      build: () => TopRatedMovieBloc(getTopRatedMovies: topRatedMovies),
      act: (bloc) {
        when(() => topRatedMovies.execute()).thenAnswer(
            (invocation) async => const Left(ServerFailure('failed')));
        bloc.add(GetTopRatedMoviesEvent());
      },
      expect: () => [
        isA<GetTopRatedMoviesInProgressState>(),
        predicate<GetTopRatedMoviesFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'failed')),
      ],
    );
  });
}
