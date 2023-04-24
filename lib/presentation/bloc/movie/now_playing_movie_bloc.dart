import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movie_bloc.g.dart';

@BlocAnnotation(
  baseEventType: NowPlayingMovieEvent,
  baseStateType: NowPlayingMovieState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetNowPlayingMovies',
      output: {'movies': List<Movie>},
    ),
  ],
)
abstract class NowPlayingMovieEvent {}

abstract class NowPlayingMovieState {}

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  NowPlayingMovieBloc({
    required GetNowPlayingMovies getNowPlayingMovies,
  })  : _getNowPlayingMovies = getNowPlayingMovies,
        super(InitialNowPlayingMovieEventState()) {
    on<GetNowPlayingMoviesEvent>(
      (event, emit) => _onGetNowPlayingMovies(),
    );
  }

  final GetNowPlayingMovies _getNowPlayingMovies;

  Future<void> _onGetNowPlayingMovies() async {
    emit(GetNowPlayingMoviesInProgressState());

    final result = await _getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(
          GetNowPlayingMoviesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movies) {
        emit(GetNowPlayingMoviesCompletedState(movies: movies));
      },
    );
  }
}
