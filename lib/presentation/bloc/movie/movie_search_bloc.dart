import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_search_bloc.g.dart';

abstract class MovieSearchEvent {}

abstract class MovieSearchState {}

@BlocAnnotation(
  baseEventType: MovieSearchEvent,
  baseStateType: MovieSearchState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetMovieSearch',
      input: {'query': String},
      output: {'data': List<Movie>},
    )
  ],
)
class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc({required this.searchMovies})
      : super(InitialMovieSearchState()) {
    on<GetMovieSearchEvent>(_onGetMovieSearch);
  }

  final SearchMovies searchMovies;

  Future<void> _onGetMovieSearch(GetMovieSearchEvent event, Emitter<MovieSearchState> emit) async {
    emit(GetMovieSearchInProgressState());

    final result = await searchMovies.execute(event.query);
    result.fold(
      (failure) {
        emit(
          GetMovieSearchFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (data) {
        emit(GetMovieSearchCompletedState(data: data));
      },
    );
  }
}
