import 'dart:async';

import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_bloc.g.dart';

@BlocAnnotation(
  baseEventType: WatchlistMovieEvent,
  baseStateType: WatchlistMovieState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetWatchlistMovies',
      output: {'movies': List<Movie>},
    ),
    BlocUseCase(
      name: 'AddWatchlistMovie',
      input: {
        'movie': MovieDetail,
      },
      output: {
        'message': String,
      },
    ),
    BlocUseCase(
      name: 'RemoveWatchlistMovie',
      input: {
        'movie': MovieDetail,
      },
      output: {
        'message': String,
      },
    ),
    BlocUseCase(
      name: 'LoadWatchlistStatusMovie',
      input: {
        'id': int,
      },
      output: {'isAddedToWatchlist': bool},
    ),
  ],
)
abstract class WatchlistMovieEvent {}

abstract class WatchlistMovieState {}

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistMovieBloc({
    required GetWatchlistMovies getWatchlistMovies,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlistMovie saveWatchlist,
    required RemoveWatchlistMovie removeWatchlist,
  })  : _removeWatchlist = removeWatchlist,
        _saveWatchlist = saveWatchlist,
        _getWatchListStatus = getWatchListStatus,
        _getWatchlistMovies = getWatchlistMovies,
        super(InitialWatchlistMovieEventState()) {
    on<GetWatchlistMoviesEvent>(_onGetWatchlistMovies);
    on<AddWatchlistMovieEvent>(
      _onAddWatchlistMovie,
    );
    on<RemoveWatchlistMovieEvent>(
      _onRemoveWatchlistMovie,
    );
    on<LoadWatchlistStatusMovieEvent>(
      _onLoadWatchlistStatusMovie,
    );
  }

  static const _watchlistAddSuccessMessage = 'Added to Watchlist';
  static const _watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  FutureOr<void> _onGetWatchlistMovies(
    GetWatchlistMoviesEvent event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(GetWatchlistMoviesInProgressState());
    final result = await _getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(
          GetWatchlistMoviesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movies) {
        emit(GetWatchlistMoviesCompletedState(movies: movies));
      },
    );
  }

  FutureOr<void> _onAddWatchlistMovie(
    AddWatchlistMovieEvent event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(AddWatchlistMovieInProgressState());
    final movie = event.movie;

    final detailResult = await _saveWatchlist.execute(movie);
    detailResult.fold(
      (failure) {
        emit(
          AddWatchlistMovieFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movie) {
        emit(
          AddWatchlistMovieCompletedState(
            message: _watchlistAddSuccessMessage,
          ),
        );
      },
    );
  }

  FutureOr<void> _onRemoveWatchlistMovie(
    RemoveWatchlistMovieEvent event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(RemoveWatchlistMovieInProgressState());

    final movie = event.movie;

    final detailResult = await _removeWatchlist.execute(movie);
    detailResult.fold(
      (failure) {
        emit(
          RemoveWatchlistMovieFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movie) {
        emit(
          RemoveWatchlistMovieCompletedState(
            message: _watchlistRemoveSuccessMessage,
          ),
        );
      },
    );
  }

  FutureOr<void> _onLoadWatchlistStatusMovie(
    LoadWatchlistStatusMovieEvent event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    final id = event.id;
    final added = await _getWatchListStatus.execute(id);
    emit(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: added),
    );
  }
}
