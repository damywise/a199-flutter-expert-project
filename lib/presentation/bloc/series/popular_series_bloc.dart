import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_series_bloc.g.dart';

@BlocAnnotation(
  baseEventType: PopularSeriesEvent,
  baseStateType: PopularSeriesState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetPopularSeries',
      output: {'series': List<Series>},
    ),
  ],
)
abstract class PopularSeriesEvent {}

abstract class PopularSeriesState {}

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  PopularSeriesBloc({
    required GetPopularSeries getPopularSeries,
  })  :
        _getPopularSeries = getPopularSeries,
        super(InitialPopularSeriesEventState()) {
    on<GetPopularSeriesEvent>(
      (event, emit) => _onGetPopularSeries(),
    );
  }

  final GetPopularSeries _getPopularSeries;

  Future<void> _onGetPopularSeries() async {
    emit(GetPopularSeriesInProgressState());

    final result = await _getPopularSeries.execute();
    result.fold(
      (failure) {
        emit(
          GetPopularSeriesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(GetPopularSeriesCompletedState(series: series));
      },
    );
  }
}
