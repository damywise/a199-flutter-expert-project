import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:ditonton/presentation/bloc/series/watchlist_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistSeries extends Mock implements GetWatchlistSeries {}

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlistSeries extends Mock implements SaveWatchlistSeries {}

class MockRemoveWatchlistSeries extends Mock implements RemoveWatchlistSeries {}

void main() {
  group('WatchlistSeriesBloc', () {
    late GetWatchlistSeries getWatchlistSeries;
    late GetWatchListStatus getWatchListStatus;
    late SaveWatchlistSeries saveWatchlist;
    late RemoveWatchlistSeries removeWatchlist;
    late WatchlistSeriesBloc watchlistSeriesBloc;

    setUp(() {
      getWatchlistSeries = MockGetWatchlistSeries();
      getWatchListStatus = MockGetWatchListStatus();
      saveWatchlist = MockSaveWatchlistSeries();
      removeWatchlist = MockRemoveWatchlistSeries();
      watchlistSeriesBloc = WatchlistSeriesBloc(
        getWatchlistSeries: getWatchlistSeries,
        getWatchListStatus: getWatchListStatus,
        saveWatchlist: saveWatchlist,
        removeWatchlist: removeWatchlist,
      );
    });

    blocTest(
      'emits [] when no events are added',
      build: () => watchlistSeriesBloc,
      expect: () => [],
    );

    blocTest(
      'emits [GetWatchlistSeriesInProgressState, GetWatchlistSeriesCompletedState] when GetWatchlistSeriesEvent is added',
      build: () {
        when(() => getWatchlistSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistSeriesEvent()),
      expect: () => [
        isA<GetWatchlistSeriesInProgressState>(),
        predicate<GetWatchlistSeriesCompletedState>(
          (state) => state.series.isEmpty,
        )
      ],
    );

    blocTest(
      'emits [GetWatchlistSeriesInProgressState, GetWatchlistSeriesFailedState] when GetWatchlistSeriesEvent failed',
      build: () {
        when(() => getWatchlistSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return watchlistSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistSeriesEvent()),
      expect: () => [
        isA<GetWatchlistSeriesInProgressState>(),
        predicate<GetWatchlistSeriesFailedState>(
          (state) => state.failure.message == 'Failed',
        )
      ],
    );

    blocTest(
      'emits [AddWatchlistSeriesInProgressState, AddWatchlistSeriesCompletedState] when AddWatchlistSeriesEvent event is added',
      build: () {
        when(() => saveWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Right(''));
        return watchlistSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(AddWatchlistSeriesEvent(series: testSeriesDetail)),
      expect: () => [
        isA<AddWatchlistSeriesInProgressState>(),
        predicate<AddWatchlistSeriesCompletedState>(
          (state) => state.message.compareTo('Added to Watchlist') == 0,
        ),
      ],
    );

    blocTest(
      'emits [AddWatchlistSeriesInProgressState, AddWatchlistSeriesFailedState] when AddWatchlistSeriesEvent event failed',
      build: () {
        when(() => saveWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return watchlistSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(AddWatchlistSeriesEvent(series: testSeriesDetail)),
      expect: () => [
        isA<AddWatchlistSeriesInProgressState>(),
        predicate<AddWatchlistSeriesFailedState>(
          (state) => state.failure.message == 'Failed',
        ),
      ],
    );

    blocTest(
      'emits [RemoveWatchlistSeriesInProgressState, RemoveWatchlistSeriesCompletedState] when RemoveWatchlistSeriesEvent event is added',
      build: () {
        when(() => removeWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Right(''));
        return watchlistSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveWatchlistSeriesEvent(series: testSeriesDetail)),
      expect: () => [
        isA<RemoveWatchlistSeriesInProgressState>(),
        predicate<RemoveWatchlistSeriesCompletedState>(
          (state) => state.message == 'Removed from Watchlist',
        ),
      ],
    );

    blocTest(
      'emits [RemoveWatchlistSeriesInProgressState, RemoveWatchlistSeriesFailedState] when RemoveWatchlistSeriesEvent event failed',
      build: () {
        when(() => removeWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return watchlistSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveWatchlistSeriesEvent(series: testSeriesDetail)),
      expect: () => [
        isA<RemoveWatchlistSeriesInProgressState>(),
        predicate<RemoveWatchlistSeriesFailedState>(
          (state) => state.failure.message == 'Failed',
        ),
      ],
    );

    blocTest(
      'emits [LoadWatchlistStatusSeriesCompletedState] when LoadWatchlistStatusSeriesEvent is added',
      build: () {
        when(() => getWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return watchlistSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatusSeriesEvent(id: 1)),
      expect: () => [
        predicate<LoadWatchlistStatusSeriesCompletedState>(
          (state) => state.isAddedToWatchlist == true,
        )
      ],
    );

    tearDown(() {
      watchlistSeriesBloc.close();
    });
  });
}
