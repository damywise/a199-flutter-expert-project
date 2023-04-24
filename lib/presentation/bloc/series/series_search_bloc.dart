import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_search_bloc.g.dart';

abstract class SeriesSearchEvent {}

abstract class SeriesSearchState {}

@BlocAnnotation(
  baseEventType: SeriesSearchEvent,
  baseStateType: SeriesSearchState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetSeriesSearch',
      input: {'query': String},
      output: {'data': List<Series>},
    )
  ],
)
class SeriesSearchBloc extends Bloc<SeriesSearchEvent, SeriesSearchState> {
  SeriesSearchBloc({required this.searchSeries})
      : super(InitialSeriesSearchState()) {
    on<GetSeriesSearchEvent>((event, emit) => _onGetSeriesSearch(event.query));
  }

  final SearchSeries searchSeries;

  Future<void> _onGetSeriesSearch(String query) async {
    emit(GetSeriesSearchInProgressState());

    final result = await searchSeries.execute(query);
    result.fold(
      (failure) {
        emit(
          GetSeriesSearchFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (data) {
        emit(GetSeriesSearchCompletedState(data: data));
      },
    );
  }
}
