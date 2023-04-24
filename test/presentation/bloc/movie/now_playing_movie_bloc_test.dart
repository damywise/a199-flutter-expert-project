import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  group('NowPlayingMovieBloc', () {
    late GetNowPlayingMovies nowPlayingMovies;

    setUp(() {
      nowPlayingMovies = MockGetNowPlayingMovies();
    });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits [GetNowPlayingMoviesInProgressState, GetNowPlayingMoviesCompletedState] when GetNowPlayingMoviesEvent is added',
      build: () => NowPlayingMovieBloc(getNowPlayingMovies: nowPlayingMovies),
      act: (bloc) {
        when(() => nowPlayingMovies.execute())
            .thenAnswer((invocation) async => Right(testMovieList));
        bloc.add(GetNowPlayingMoviesEvent());
      },
      expect: () => [
        isA<GetNowPlayingMoviesInProgressState>(),
        predicate<GetNowPlayingMoviesCompletedState>(
            (state) => state.movies == testMovieList),
      ],
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits [GetNowPlayingMoviesInProgressState, GetNowPlayingMoviesFailedState] when GetNowPlayingMovies throws an exception',
      build: () => NowPlayingMovieBloc(getNowPlayingMovies: nowPlayingMovies),
      act: (bloc) {
        when(() => nowPlayingMovies.execute()).thenAnswer(
            (invocation) async => const Left(ServerFailure('failed')));
        bloc.add(GetNowPlayingMoviesEvent());
      },
      expect: () => [
        isA<GetNowPlayingMoviesInProgressState>(),
        predicate<GetNowPlayingMoviesFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'failed')),
      ],
    );
  });
}
