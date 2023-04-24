// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialPopularMovieEventState extends PopularMovieState {}

class GetPopularMoviesEvent extends PopularMovieEvent {}

class GetPopularMoviesInProgressState extends PopularMovieState {}

class GetPopularMoviesCompletedState extends PopularMovieState {
  final List<Movie> movies;
  GetPopularMoviesCompletedState({required this.movies});
}

class GetPopularMoviesFailedState extends PopularMovieState {
  final GlobalFailureModel failure;
  GetPopularMoviesFailedState({required this.failure});
}
