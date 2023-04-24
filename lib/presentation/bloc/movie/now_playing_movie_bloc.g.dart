// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_movie_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialNowPlayingMovieEventState extends NowPlayingMovieState {}

class GetNowPlayingMoviesEvent extends NowPlayingMovieEvent {}

class GetNowPlayingMoviesInProgressState extends NowPlayingMovieState {}

class GetNowPlayingMoviesCompletedState extends NowPlayingMovieState {
  final List<Movie> movies;
  GetNowPlayingMoviesCompletedState({required this.movies});
}

class GetNowPlayingMoviesFailedState extends NowPlayingMovieState {
  final GlobalFailureModel failure;
  GetNowPlayingMoviesFailedState({required this.failure});
}
