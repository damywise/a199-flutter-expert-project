import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_series_bloc.g.dart';

@BlocAnnotation(
  baseEventType: NowPlayingSeriesEvent,
  baseStateType: NowPlayingSeriesState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetNowPlayingSeries',
      output: {'series': List<Series>},
    ),
  ],
)
abstract class NowPlayingSeriesEvent {}

abstract class NowPlayingSeriesState {}

class NowPlayingSeriesBloc
    extends Bloc<NowPlayingSeriesEvent, NowPlayingSeriesState> {
  NowPlayingSeriesBloc({
    required GetNowPlayingSeries getNowPlayingSeries,
  })  : _getNowPlayingSeries = getNowPlayingSeries,
        super(InitialNowPlayingSeriesEventState()) {
    on<GetNowPlayingSeriesEvent>(
      (event, emit) => _onGetNowPlayingSeries(),
    );
  }

  final GetNowPlayingSeries _getNowPlayingSeries;

  Future<void> _onGetNowPlayingSeries() async {
    emit(GetNowPlayingSeriesInProgressState());

    final result = await _getNowPlayingSeries.execute();
    result.fold(
      (failure) {
        emit(
          GetNowPlayingSeriesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(GetNowPlayingSeriesCompletedState(series: series));
      },
    );
  }
}
