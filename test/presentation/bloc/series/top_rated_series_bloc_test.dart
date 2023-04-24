import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/presentation/bloc/series/top_rated_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedSeries extends Mock implements GetTopRatedSeries {}

void main() {
  group('TopRatedSeriesBloc', () {
    late GetTopRatedSeries topRatedSeries;

    setUp(() {
      topRatedSeries = MockGetTopRatedSeries();
    });

    blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'emits [GetTopRatedSeriesInProgressState, GetTopRatedSeriesCompletedState] when GetTopRatedSeriesEvent is added',
      build: () => TopRatedSeriesBloc(getTopRatedSeries: topRatedSeries),
      act: (bloc) {
        when(() => topRatedSeries.execute())
            .thenAnswer((invocation) async => Right(testSeriesList));
        bloc.add(GetTopRatedSeriesEvent());
      },
      expect: () => [
        isA<GetTopRatedSeriesInProgressState>(),
        predicate<GetTopRatedSeriesCompletedState>(
            (state) => state.series == testSeriesList),
      ],
    );

    blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'emits [GetTopRatedSeriesInProgressState, GetTopRatedSeriesFailedState] when GetTopRatedSeries throws an exception',
      build: () => TopRatedSeriesBloc(getTopRatedSeries: topRatedSeries),
      act: (bloc) {
        when(() => topRatedSeries.execute()).thenAnswer(
            (invocation) async => const Left(ServerFailure('failed')));
        bloc.add(GetTopRatedSeriesEvent());
      },
      expect: () => [
        isA<GetTopRatedSeriesInProgressState>(),
        predicate<GetTopRatedSeriesFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'failed')),
      ],
    );
  });
}
