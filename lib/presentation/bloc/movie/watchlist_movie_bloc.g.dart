// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_movie_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialWatchlistMovieEventState extends WatchlistMovieState {}

class GetWatchlistMoviesEvent extends WatchlistMovieEvent {}

class GetWatchlistMoviesInProgressState extends WatchlistMovieState {}

class GetWatchlistMoviesCompletedState extends WatchlistMovieState {
  final List<Movie> movies;
  GetWatchlistMoviesCompletedState({required this.movies});
}

class GetWatchlistMoviesFailedState extends WatchlistMovieState {
  final GlobalFailureModel failure;
  GetWatchlistMoviesFailedState({required this.failure});
}

class AddWatchlistMovieEvent extends WatchlistMovieEvent {
  final MovieDetail movie;
  AddWatchlistMovieEvent({required this.movie});
}

class AddWatchlistMovieInProgressState extends WatchlistMovieState {}

class AddWatchlistMovieCompletedState extends WatchlistMovieState {
  final String message;
  AddWatchlistMovieCompletedState({required this.message});
}

class AddWatchlistMovieFailedState extends WatchlistMovieState {
  final GlobalFailureModel failure;
  AddWatchlistMovieFailedState({required this.failure});
}

class RemoveWatchlistMovieEvent extends WatchlistMovieEvent {
  final MovieDetail movie;
  RemoveWatchlistMovieEvent({required this.movie});
}

class RemoveWatchlistMovieInProgressState extends WatchlistMovieState {}

class RemoveWatchlistMovieCompletedState extends WatchlistMovieState {
  final String message;
  RemoveWatchlistMovieCompletedState({required this.message});
}

class RemoveWatchlistMovieFailedState extends WatchlistMovieState {
  final GlobalFailureModel failure;
  RemoveWatchlistMovieFailedState({required this.failure});
}

class LoadWatchlistStatusMovieEvent extends WatchlistMovieEvent {
  final int id;
  LoadWatchlistStatusMovieEvent({required this.id});
}

class LoadWatchlistStatusMovieInProgressState extends WatchlistMovieState {}

class LoadWatchlistStatusMovieCompletedState extends WatchlistMovieState {
  final bool isAddedToWatchlist;
  LoadWatchlistStatusMovieCompletedState({required this.isAddedToWatchlist});
}

class LoadWatchlistStatusMovieFailedState extends WatchlistMovieState {
  final GlobalFailureModel failure;
  LoadWatchlistStatusMovieFailedState({required this.failure});
}
