import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/usecases/get_episode_detail.dart';
import 'package:ditonton/presentation/bloc/series/episode_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetEpisodeDetail extends Mock implements GetEpisodeDetail {}

void main() {
  late GetEpisodeDetail getEpisodeDetail;

  setUp(() {
    getEpisodeDetail = MockGetEpisodeDetail();
  });

  group('EpisodeDetailBloc', () {
    final tEpisodeDetail = testEpisode;

    blocTest<EpisodeDetailBloc, EpisodeDetailState>(
      'emits [GetEpisodeDetailInProgressState, GetEpisodeDetailCompletedState] '
      'when GetEpisodeDetailEvent is added',
      build: () {
        when(() => getEpisodeDetail.execute(any(), any(), any())).thenAnswer(
          (_) async => Right(tEpisodeDetail),
        );
        return EpisodeDetailBloc(getEpisodeDetail: getEpisodeDetail);
      },
      act: (bloc) => bloc.add(GetEpisodeDetailEvent(seriesId: 1, seasonNumber: 1,episodeNumber: 1)),
      expect: () => [
        isA<GetEpisodeDetailInProgressState>(),
        predicate<GetEpisodeDetailCompletedState>((state) => state.episode == tEpisodeDetail),
      ],
      verify: (_) {
        verify(() => getEpisodeDetail.execute(any(), any(), any())).called(1);
      },
    );

    blocTest<EpisodeDetailBloc, EpisodeDetailState>(
      'emits [GetEpisodeDetailInProgressState, GetEpisodeDetailFailedState] '
      'when GetEpisodeDetailEvent throws an error',
      build: () {
        when(() => getEpisodeDetail.execute(any(), any(), any())).thenAnswer(
          (_) async => const Left(ServerFailure('test')),
        );
        return EpisodeDetailBloc(getEpisodeDetail: getEpisodeDetail);
      },
      act: (bloc) => bloc.add(GetEpisodeDetailEvent(seriesId: 1, seasonNumber: 1, episodeNumber: 1)),
      expect: () => [
        isA<GetEpisodeDetailInProgressState>(),
        predicate<GetEpisodeDetailFailedState>((state) => state.failure == GlobalFailureModel(message: 'test')),
      ],
      verify: (_) {
        verify(() => getEpisodeDetail.execute(any(), any(), any())).called(1);
      },
    );
  });
}
