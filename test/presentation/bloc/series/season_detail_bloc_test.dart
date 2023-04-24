import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_season_detail.dart';
import 'package:ditonton/presentation/bloc/series/season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetSeasonDetail extends Mock implements GetSeasonDetail {}

void main() {
  late GetSeasonDetail getSeasonDetail;

  setUp(() {
    getSeasonDetail = MockGetSeasonDetail();
  });

  group('SeasonDetailBloc', () {
    final tSeasonDetail = testSeasonDetail;

    blocTest<SeasonDetailBloc, SeasonDetailState>(
      'emits [GetSeasonDetailInProgressState, GetSeasonDetailCompletedState] '
      'when GetSeasonDetailEvent is added',
      build: () {
        when(() => getSeasonDetail.execute(any(), any())).thenAnswer(
          (_) async => Right(tSeasonDetail),
        );
        return SeasonDetailBloc(getSeasonDetail: getSeasonDetail);
      },
      act: (bloc) => bloc.add(GetSeasonDetailEvent(seriesId: 1, seasonNumber: 1)),
      expect: () => [
        isA<GetSeasonDetailInProgressState>(),
        predicate<GetSeasonDetailCompletedState>((state) => state.season == tSeasonDetail),
      ],
      verify: (_) {
        verify(() => getSeasonDetail.execute(any(), any())).called(1);
      },
    );

    blocTest<SeasonDetailBloc, SeasonDetailState>(
      'emits [GetSeasonDetailInProgressState, GetSeasonDetailFailedState] '
      'when GetSeasonDetailEvent throws an error',
      build: () {
        when(() => getSeasonDetail.execute(any(), any())).thenAnswer(
          (_) async => const Left(ServerFailure('test')),
        );
        return SeasonDetailBloc(getSeasonDetail: getSeasonDetail);
      },
      act: (bloc) => bloc.add(GetSeasonDetailEvent(seriesId: 1, seasonNumber: 1)),
      expect: () => [
        isA<GetSeasonDetailInProgressState>(),
        predicate<GetSeasonDetailFailedState>((state) => state.failure == GlobalFailureModel(message: 'test')),
      ],
      verify: (_) {
        verify(() => getSeasonDetail.execute(any(), any())).called(1);
      },
    );
  });
}
