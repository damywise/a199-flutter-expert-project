import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/series/series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetSeriesRecommendation extends Mock
    implements GetSeriesRecommendations {}

void main() {
  late GetSeriesRecommendations getSeriesRecommendation;

  setUp(() {
    getSeriesRecommendation = MockGetSeriesRecommendation();
  });

  group('SeriesRecommendationBloc', () {
    final tSeriesRecommendation = testSeriesList;

    blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
      'emits [GetSeriesRecommendationInProgressState, GetSeriesRecommendationCompletedState] '
      'when GetSeriesRecommendationEvent is added',
      build: () {
        when(() => getSeriesRecommendation.execute(any())).thenAnswer(
          (_) async => Right(tSeriesRecommendation),
        );
        return SeriesRecommendationBloc(
          getSeriesRecommendations: getSeriesRecommendation,
        );
      },
      act: (bloc) => bloc.add(GetSeriesRecommendationEvent(id: 1)),
      expect: () => [
        isA<GetSeriesRecommendationInProgressState>(),
        predicate<GetSeriesRecommendationCompletedState>(
          (state) => state.series == tSeriesRecommendation,
        ),
      ],
      verify: (_) {
        verify(() => getSeriesRecommendation.execute(any())).called(1);
      },
    );

    blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
      'emits [GetSeriesRecommendationInProgressState, GetSeriesRecommendationFailedState] '
      'when GetSeriesRecommendationEvent throws an error',
      build: () {
        when(() => getSeriesRecommendation.execute(any())).thenAnswer(
          (_) async => const Left(ServerFailure('test')),
        );
        return SeriesRecommendationBloc(
          getSeriesRecommendations: getSeriesRecommendation,
        );
      },
      act: (bloc) => bloc.add(GetSeriesRecommendationEvent(id: 1)),
      expect: () => [
        isA<GetSeriesRecommendationInProgressState>(),
        predicate<GetSeriesRecommendationFailedState>(
          (state) => state.failure == const GlobalFailureModel(message: 'test'),
        ),
      ],
      verify: (_) {
        verify(() => getSeriesRecommendation.execute(any())).called(1);
      },
    );
  });
}
