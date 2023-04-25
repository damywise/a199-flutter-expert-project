import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetSeriesDetail extends Mock implements GetSeriesDetail {}

void main() {
  late GetSeriesDetail getSeriesDetail;

  setUp(() {
    getSeriesDetail = MockGetSeriesDetail();
  });

  group('SeriesDetailBloc', () {
    const tSeriesDetail = testSeriesDetail;

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [GetSeriesDetailInProgressState, GetSeriesDetailCompletedState] '
      'when GetSeriesDetailEvent is added',
      build: () {
        when(() => getSeriesDetail.execute(any())).thenAnswer(
          (_) async => const Right(tSeriesDetail),
        );
        return SeriesDetailBloc(getSeriesDetail: getSeriesDetail);
      },
      act: (bloc) => bloc.add(GetSeriesDetailEvent(id: 1)),
      expect: () => [
        isA<GetSeriesDetailInProgressState>(),
        predicate<GetSeriesDetailCompletedState>(
          (state) => state.series == tSeriesDetail,
        ),
      ],
      verify: (_) {
        verify(() => getSeriesDetail.execute(any())).called(1);
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [GetSeriesDetailInProgressState, GetSeriesDetailFailedState] '
      'when GetSeriesDetailEvent throws an error',
      build: () {
        when(() => getSeriesDetail.execute(any())).thenAnswer(
          (_) async => const Left(ServerFailure('test')),
        );
        return SeriesDetailBloc(getSeriesDetail: getSeriesDetail);
      },
      act: (bloc) => bloc.add(GetSeriesDetailEvent(id: 1)),
      expect: () => [
        isA<GetSeriesDetailInProgressState>(),
        predicate<GetSeriesDetailFailedState>(
          (state) => state.failure == const GlobalFailureModel(message: 'test'),
        ),
      ],
      verify: (_) {
        verify(() => getSeriesDetail.execute(any())).called(1);
      },
    );
  });
}
