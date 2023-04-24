// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_rated_movie_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialTopRatedMovieEventState extends TopRatedMovieState {}

class GetTopRatedMoviesEvent extends TopRatedMovieEvent {}

class GetTopRatedMoviesInProgressState extends TopRatedMovieState {}

class GetTopRatedMoviesCompletedState extends TopRatedMovieState {
  final List<Movie> movies;
  GetTopRatedMoviesCompletedState({required this.movies});
}

class GetTopRatedMoviesFailedState extends TopRatedMovieState {
  final GlobalFailureModel failure;
  GetTopRatedMoviesFailedState({required this.failure});
}
