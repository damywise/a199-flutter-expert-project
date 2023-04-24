import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieRecommendation extends Mock
    implements GetMovieRecommendations {}

void main() {
  late GetMovieRecommendations getMovieRecommendation;

  setUp(() {
    getMovieRecommendation = MockGetMovieRecommendation();
  });

  group('MovieRecommendationBloc', () {
    final tMovieRecommendation = testMovieList;

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'emits [GetMovieRecommendationInProgressState, GetMovieRecommendationCompletedState] '
      'when GetMovieRecommendationEvent is added',
      build: () {
        when(() => getMovieRecommendation.execute(any())).thenAnswer(
          (_) async => Right(tMovieRecommendation),
        );
        return MovieRecommendationBloc(
            getMovieRecommendations: getMovieRecommendation);
      },
      act: (bloc) => bloc.add(GetMovieRecommendationEvent(id: 1)),
      expect: () => [
        isA<GetMovieRecommendationInProgressState>(),
        predicate<GetMovieRecommendationCompletedState>(
            (state) => state.movies == tMovieRecommendation),
      ],
      verify: (_) {
        verify(() => getMovieRecommendation.execute(any())).called(1);
      },
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'emits [GetMovieRecommendationInProgressState, GetMovieRecommendationFailedState] '
      'when GetMovieRecommendationEvent throws an error',
      build: () {
        when(() => getMovieRecommendation.execute(any())).thenAnswer(
          (_) async => const Left(ServerFailure('test')),
        );
        return MovieRecommendationBloc(
            getMovieRecommendations: getMovieRecommendation);
      },
      act: (bloc) => bloc.add(GetMovieRecommendationEvent(id: 1)),
      expect: () => [
        isA<GetMovieRecommendationInProgressState>(),
        predicate<GetMovieRecommendationFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'test')),
      ],
      verify: (_) {
        verify(() => getMovieRecommendation.execute(any())).called(1);
      },
    );
  });
}
