import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_recommendation_bloc.g.dart';

abstract class SeriesRecommendationEvent {}

abstract class SeriesRecommendationState {}

@BlocAnnotation(
  baseEventType: SeriesRecommendationEvent,
  baseStateType: SeriesRecommendationState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetSeriesRecommendation',
      input: {
        'id': int,
      },
      output: {
        'series': List<Series>,
      },
    ),
  ],
)
class SeriesRecommendationBloc
    extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  SeriesRecommendationBloc({required this.getSeriesRecommendations})
      : super(InitialSeriesRecommendationState()) {
    on<GetSeriesRecommendationEvent>(
      _onGetSeriesRecommendation,
    );
  }

  final GetSeriesRecommendations getSeriesRecommendations;

  Future<void> _onGetSeriesRecommendation(
    GetSeriesRecommendationEvent event,
    Emitter<SeriesRecommendationState> emit,
  ) async {
    emit(GetSeriesRecommendationInProgressState());
    final recommendationResult =
        await getSeriesRecommendations.execute(event.id);
    recommendationResult.fold(
      (failure) {
        emit(
          GetSeriesRecommendationFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(GetSeriesRecommendationCompletedState(series: series));
      },
    );
  }
}
