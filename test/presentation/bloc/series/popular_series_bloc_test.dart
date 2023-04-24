import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/presentation/bloc/series/popular_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularSeries extends Mock implements GetPopularSeries {}

void main() {
  group('PopularSeriesBloc', () {
    late GetPopularSeries popularSeries;

    setUp(() {
      popularSeries = MockGetPopularSeries();
    });

    blocTest<PopularSeriesBloc, PopularSeriesState>(
      'emits [GetPopularSeriesInProgressState, GetPopularSeriesCompletedState] when GetPopularSeriesEvent is added',
      build: () => PopularSeriesBloc(getPopularSeries: popularSeries),
      act: (bloc) {
        when(() => popularSeries.execute())
            .thenAnswer((invocation) async => Right(testSeriesList));
        bloc.add(GetPopularSeriesEvent());
      },
      expect: () => [
        isA<GetPopularSeriesInProgressState>(),
        predicate<GetPopularSeriesCompletedState>(
            (state) => state.series == testSeriesList),
      ],
    );

    blocTest<PopularSeriesBloc, PopularSeriesState>(
      'emits [GetPopularSeriesInProgressState, GetPopularSeriesFailedState] when GetPopularSeries throws an exception',
      build: () => PopularSeriesBloc(getPopularSeries: popularSeries),
      act: (bloc) {
        when(() => popularSeries.execute()).thenAnswer(
            (invocation) async => const Left(ServerFailure('failed')));
        bloc.add(GetPopularSeriesEvent());
      },
      expect: () => [
        isA<GetPopularSeriesInProgressState>(),
        predicate<GetPopularSeriesFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'failed')),
      ],
    );
  });
}
