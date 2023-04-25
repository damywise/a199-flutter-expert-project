import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/bloc/series/series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSearchSeries extends Mock implements SearchSeries {}

void main() {
  group('SeriesSearchBloc', () {
    late SearchSeries searchSeries;

    setUp(() {
      searchSeries = MockSearchSeries();
    });

    blocTest<SeriesSearchBloc, SeriesSearchState>(
      'emits [GetSeriesSearchInProgressState, GetSeriesSearchCompletedState] when GetSeriesSearchEvent is added',
      build: () => SeriesSearchBloc(searchSeries: searchSeries),
      act: (bloc) {
        when(() => searchSeries.execute('query'))
            .thenAnswer((invocation) async => Right(testSeriesList));
        bloc.add(GetSeriesSearchEvent(query: 'query'));
      },
      expect: () => [
        isA<GetSeriesSearchInProgressState>(),
        predicate<GetSeriesSearchCompletedState>(
          (state) => state.data == testSeriesList,
        ),
      ],
    );

    blocTest<SeriesSearchBloc, SeriesSearchState>(
      'emits [GetSeriesSearchInProgressState, GetSeriesSearchFailedState] when SearchSeries throws an exception',
      build: () => SeriesSearchBloc(searchSeries: searchSeries),
      act: (bloc) {
        when(() => searchSeries.execute('query')).thenAnswer(
          (invocation) async => const Left(ServerFailure('failed')),
        );
        bloc.add(GetSeriesSearchEvent(query: 'query'));
      },
      expect: () => [
        isA<GetSeriesSearchInProgressState>(),
        predicate<GetSeriesSearchFailedState>(
          (state) =>
              state.failure == const GlobalFailureModel(message: 'failed'),
        ),
      ],
    );
  });
}
