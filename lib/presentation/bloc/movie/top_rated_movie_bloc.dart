import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movie_bloc.g.dart';

@BlocAnnotation(
  baseEventType: TopRatedMovieEvent,
  baseStateType: TopRatedMovieState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetTopRatedMovies',
      output: {'movies': List<Movie>},
    ),
  ],
)
abstract class TopRatedMovieEvent {}

abstract class TopRatedMovieState {}

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  TopRatedMovieBloc({
    required GetTopRatedMovies getTopRatedMovies,
  })  : _getTopRatedMovies = getTopRatedMovies,
        super(InitialTopRatedMovieEventState()) {
    on<GetTopRatedMoviesEvent>(
      (event, emit) => _onGetTopRatedMovies(),
    );
  }

  final GetTopRatedMovies _getTopRatedMovies;

  Future<void> _onGetTopRatedMovies() async {
    emit(GetTopRatedMoviesInProgressState());

    final result = await _getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(
          GetTopRatedMoviesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movies) {
        emit(GetTopRatedMoviesCompletedState(movies: movies));
      },
    );
  }
}
