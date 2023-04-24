import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlistMovie extends Mock implements SaveWatchlistMovie {}

class MockRemoveWatchlistMovie extends Mock implements RemoveWatchlistMovie {}

void main() {
  group('WatchlistMovieBloc', () {
    late GetWatchlistMovies getWatchlistMovies;
    late GetWatchListStatus getWatchListStatus;
    late SaveWatchlistMovie saveWatchlist;
    late RemoveWatchlistMovie removeWatchlist;
    late WatchlistMovieBloc watchlistMovieBloc;

    setUp(() {
      getWatchlistMovies = MockGetWatchlistMovies();
      getWatchListStatus = MockGetWatchListStatus();
      saveWatchlist = MockSaveWatchlistMovie();
      removeWatchlist = MockRemoveWatchlistMovie();
      watchlistMovieBloc = WatchlistMovieBloc(
        getWatchlistMovies: getWatchlistMovies,
        getWatchListStatus: getWatchListStatus,
        saveWatchlist: saveWatchlist,
        removeWatchlist: removeWatchlist,
      );
    });

    blocTest(
      'emits [] when no events are added',
      build: () => watchlistMovieBloc,
      expect: () => [],
    );

    blocTest(
      'emits [GetWatchlistMoviesInProgressState, GetWatchlistMoviesCompletedState] when GetWatchlistMoviesEvent is added',
      build: () {
        when(() => getWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
      expect: () => [
        isA<GetWatchlistMoviesInProgressState>(),
        predicate<GetWatchlistMoviesCompletedState>(
          (state) => state.movies.isEmpty,
        )
      ],
    );

    blocTest(
      'emits [GetWatchlistMoviesInProgressState, GetWatchlistMoviesFailedState] when GetWatchlistMoviesEvent failed',
      build: () {
        when(() => getWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
      expect: () => [
        isA<GetWatchlistMoviesInProgressState>(),
        predicate<GetWatchlistMoviesFailedState>(
          (state) => state.failure.message == 'Failed',
        )
      ],
    );

    blocTest(
      'emits [AddWatchlistMovieInProgressState, AddWatchlistMovieCompletedState] when AddWatchlistMovieEvent event is added',
      build: () {
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(''));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovieEvent(movie: testMovieDetail)),
      expect: () => [
        isA<AddWatchlistMovieInProgressState>(),
        predicate<AddWatchlistMovieCompletedState>(
          (state) => state.message.compareTo('Added to Watchlist') == 0,
        ),
      ],
    );

    blocTest(
      'emits [AddWatchlistMovieInProgressState, AddWatchlistMovieFailedState] when AddWatchlistMovieEvent event failed',
      build: () {
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovieEvent(movie: testMovieDetail)),
      expect: () => [
        isA<AddWatchlistMovieInProgressState>(),
        predicate<AddWatchlistMovieFailedState>(
          (state) => state.failure.message == 'Failed',
        ),
      ],
    );

    blocTest(
      'emits [RemoveWatchlistMovieInProgressState, RemoveWatchlistMovieCompletedState] when RemoveWatchlistMovieEvent event is added',
      build: () {
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(''));
        return watchlistMovieBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveWatchlistMovieEvent(movie: testMovieDetail)),
      expect: () => [
        isA<RemoveWatchlistMovieInProgressState>(),
        predicate<RemoveWatchlistMovieCompletedState>(
          (state) => state.message == 'Removed from Watchlist',
        ),
      ],
    );

    blocTest(
      'emits [RemoveWatchlistMovieInProgressState, RemoveWatchlistMovieFailedState] when RemoveWatchlistMovieEvent event failed',
      build: () {
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveWatchlistMovieEvent(movie: testMovieDetail)),
      expect: () => [
        isA<RemoveWatchlistMovieInProgressState>(),
        predicate<RemoveWatchlistMovieFailedState>(
          (state) => state.failure.message == 'Failed',
        ),
      ],
    );

    blocTest(
      'emits [LoadWatchlistStatusMovieCompletedState] when LoadWatchlistStatusMovieEvent is added',
      build: () {
        when(() => getWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusMovieEvent(id: 1)),
      expect: () => [
        predicate<LoadWatchlistStatusMovieCompletedState>(
          (state) => state.isAddedToWatchlist == true,
        )
      ],
    );

    tearDown(() {
      watchlistMovieBloc.close();
    });
  });
}
