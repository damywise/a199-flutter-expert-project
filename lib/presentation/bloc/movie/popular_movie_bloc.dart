import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movie_bloc.g.dart';

@BlocAnnotation(
  baseEventType: PopularMovieEvent,
  baseStateType: PopularMovieState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetPopularMovies',
      output: {'movies': List<Movie>},
    ),
  ],
)
abstract class PopularMovieEvent {}

abstract class PopularMovieState {}

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  PopularMovieBloc({
    required GetPopularMovies getPopularMovies,
  })  :
        _getPopularMovies = getPopularMovies,
        super(InitialPopularMovieEventState()) {
    on<GetPopularMoviesEvent>(
      (event, emit) => _onGetPopularMovies(),
    );
  }

  final GetPopularMovies _getPopularMovies;

  Future<void> _onGetPopularMovies() async {
    emit(GetPopularMoviesInProgressState());

    final result = await _getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(
          GetPopularMoviesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movies) {
        emit(GetPopularMoviesCompletedState(movies: movies));
      },
    );
  }
}
