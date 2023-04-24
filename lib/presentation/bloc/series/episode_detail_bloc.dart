import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episode_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'episode_detail_bloc.g.dart';

abstract class EpisodeDetailEvent {}

abstract class EpisodeDetailState {}

@BlocAnnotation(
  baseEventType: EpisodeDetailEvent,
  baseStateType: EpisodeDetailState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetEpisodeDetail',
      input: {
        'seriesId': int,
        'seasonNumber': int,
        'episodeNumber': int,
      },
      output: {'episode': Episode},
    ),
  ],
)
class EpisodeDetailBloc extends Bloc<EpisodeDetailEvent, EpisodeDetailState> {
  EpisodeDetailBloc({
    required this.getEpisodeDetail,
  }) : super(InitialEpisodeDetailState()) {
    on<GetEpisodeDetailEvent>(_onGetEpisodeDetail,
    );
  }

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetEpisodeDetail getEpisodeDetail;

  Future<void> _onGetEpisodeDetail(GetEpisodeDetailEvent event, Emitter<EpisodeDetailState> emit) async {
    emit(GetEpisodeDetailInProgressState());
    final seriesId = event.seriesId;
    final seasonNumber = event.seasonNumber;
    final episodeNumber = event.episodeNumber;

    final detailResult = await getEpisodeDetail.execute(seriesId, seasonNumber, episodeNumber);
    detailResult.fold(
      (failure) {
        emit(
          GetEpisodeDetailFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (episode) {
        emit(GetEpisodeDetailCompletedState(episode: episode));
      },
    );
  }

}