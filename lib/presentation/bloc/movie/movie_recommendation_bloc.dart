import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendation_bloc.g.dart';

abstract class MovieRecommendationEvent {}

abstract class MovieRecommendationState {}

@BlocAnnotation(
  baseEventType: MovieRecommendationEvent,
  baseStateType: MovieRecommendationState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetMovieRecommendation',
      input: {
        'id': int,
      },
      output: {
        'movies': List<Movie>,
      },
    ),
  ],
)
class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(InitialMovieRecommendationState()) {
    on<GetMovieRecommendationEvent>(
      _onGetMovieRecommendation,
    );
  }

  final GetMovieRecommendations getMovieRecommendations;

  Future<void> _onGetMovieRecommendation(GetMovieRecommendationEvent event,
      Emitter<MovieRecommendationState> emit) async {
    emit(GetMovieRecommendationInProgressState());
    final recommendationResult = await getMovieRecommendations.execute(event.id);
    recommendationResult.fold(
      (failure) {
        emit(
          GetMovieRecommendationFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movies) {
        emit(GetMovieRecommendationCompletedState(movies: movies));
      },
    );
  }
}
