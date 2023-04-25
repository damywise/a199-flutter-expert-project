import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late GetMovieDetail getMovieDetail;

  setUp(() {
    getMovieDetail = MockGetMovieDetail();
  });

  group('MovieDetailBloc', () {
    const tMovieDetail = testMovieDetail;

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [GetMovieDetailInProgressState, GetMovieDetailCompletedState] '
      'when GetMovieDetailEvent is added',
      build: () {
        when(() => getMovieDetail.execute(any())).thenAnswer(
          (_) async => const Right(tMovieDetail),
        );
        return MovieDetailBloc(getMovieDetail: getMovieDetail);
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(id: 1)),
      expect: () => [
        isA<GetMovieDetailInProgressState>(),
        predicate<GetMovieDetailCompletedState>(
          (state) => state.movie == tMovieDetail,
        ),
      ],
      verify: (_) {
        verify(() => getMovieDetail.execute(any())).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [GetMovieDetailInProgressState, GetMovieDetailFailedState] '
      'when GetMovieDetailEvent throws an error',
      build: () {
        when(() => getMovieDetail.execute(any())).thenAnswer(
          (_) async => const Left(ServerFailure('test')),
        );
        return MovieDetailBloc(getMovieDetail: getMovieDetail);
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(id: 1)),
      expect: () => [
        isA<GetMovieDetailInProgressState>(),
        predicate<GetMovieDetailFailedState>(
          (state) => state.failure == const GlobalFailureModel(message: 'test'),
        ),
      ],
      verify: (_) {
        verify(() => getMovieDetail.execute(any())).called(1);
      },
    );
  });
}
