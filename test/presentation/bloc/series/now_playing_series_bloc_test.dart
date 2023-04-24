import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/presentation/bloc/series/now_playing_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingSeries extends Mock implements GetNowPlayingSeries {}

void main() {
  group('NowPlayingSeriesBloc', () {
    late GetNowPlayingSeries nowPlayingSeries;

    setUp(() {
      nowPlayingSeries = MockGetNowPlayingSeries();
    });

    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      'emits [GetNowPlayingSeriesInProgressState, GetNowPlayingSeriesCompletedState] when GetNowPlayingSeriesEvent is added',
      build: () => NowPlayingSeriesBloc(getNowPlayingSeries: nowPlayingSeries),
      act: (bloc) {
        when(() => nowPlayingSeries.execute())
            .thenAnswer((invocation) async => Right(testSeriesList));
        bloc.add(GetNowPlayingSeriesEvent());
      },
      expect: () => [
        isA<GetNowPlayingSeriesInProgressState>(),
        predicate<GetNowPlayingSeriesCompletedState>(
            (state) => state.series == testSeriesList),
      ],
    );

    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      'emits [GetNowPlayingSeriesInProgressState, GetNowPlayingSeriesFailedState] when GetNowPlayingSeries throws an exception',
      build: () => NowPlayingSeriesBloc(getNowPlayingSeries: nowPlayingSeries),
      act: (bloc) {
        when(() => nowPlayingSeries.execute()).thenAnswer(
            (invocation) async => const Left(ServerFailure('failed')));
        bloc.add(GetNowPlayingSeriesEvent());
      },
      expect: () => [
        isA<GetNowPlayingSeriesInProgressState>(),
        predicate<GetNowPlayingSeriesFailedState>(
            (state) => state.failure == GlobalFailureModel(message: 'failed')),
      ],
    );
  });
}
