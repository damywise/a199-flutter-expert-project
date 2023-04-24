// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialMovieSearchState extends MovieSearchState {}

class GetMovieSearchEvent extends MovieSearchEvent {
  final String query;
  GetMovieSearchEvent({required this.query});
}

class GetMovieSearchInProgressState extends MovieSearchState {}

class GetMovieSearchCompletedState extends MovieSearchState {
  final List<Movie> data;
  GetMovieSearchCompletedState({required this.data});
}

class GetMovieSearchFailedState extends MovieSearchState {
  final GlobalFailureModel failure;
  GetMovieSearchFailedState({required this.failure});
}
