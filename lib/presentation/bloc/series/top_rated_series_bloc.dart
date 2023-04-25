import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_series_bloc.g.dart';

@BlocAnnotation(
  baseEventType: TopRatedSeriesEvent,
  baseStateType: TopRatedSeriesState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetTopRatedSeries',
      output: {'series': List<Series>},
    ),
  ],
)
abstract class TopRatedSeriesEvent {}

abstract class TopRatedSeriesState {}

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  TopRatedSeriesBloc({
    required GetTopRatedSeries getTopRatedSeries,
  })  : _getTopRatedSeries = getTopRatedSeries,
        super(InitialTopRatedSeriesEventState()) {
    on<GetTopRatedSeriesEvent>(
      (event, emit) => _onGetTopRatedSeries(),
    );
  }

  final GetTopRatedSeries _getTopRatedSeries;

  Future<void> _onGetTopRatedSeries() async {
    emit(GetTopRatedSeriesInProgressState());

    final result = await _getTopRatedSeries.execute();
    result.fold(
      (failure) {
        emit(
          GetTopRatedSeriesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(GetTopRatedSeriesCompletedState(series: series));
      },
    );
  }
}
