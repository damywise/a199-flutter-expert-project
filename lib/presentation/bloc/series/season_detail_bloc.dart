import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/usecases/get_season_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'season_detail_bloc.g.dart';

abstract class SeasonDetailEvent {}

abstract class SeasonDetailState {}

@BlocAnnotation(
  baseEventType: SeasonDetailEvent,
  baseStateType: SeasonDetailState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetSeasonDetail',
      input: {
        'seriesId': int,
        'seasonNumber': int,
      },
      output: {'season': SeasonDetail},
    ),
  ],
)
class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  SeasonDetailBloc({
    required this.getSeasonDetail,
  }) : super(InitialSeasonDetailState()) {
    on<GetSeasonDetailEvent>(
      _onGetSeasonDetail,
    );
  }

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeasonDetail getSeasonDetail;

  Future<void> _onGetSeasonDetail(
    GetSeasonDetailEvent event,
    Emitter<SeasonDetailState> emit,
  ) async {
    emit(GetSeasonDetailInProgressState());
    final seriesId = event.seriesId;
    final seasonNumber = event.seasonNumber;

    final detailResult = await getSeasonDetail.execute(seriesId, seasonNumber);
    detailResult.fold(
      (failure) {
        emit(
          GetSeasonDetailFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (season) {
        emit(GetSeasonDetailCompletedState(season: season));
      },
    );
  }
}
