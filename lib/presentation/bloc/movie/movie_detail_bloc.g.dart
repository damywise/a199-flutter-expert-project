// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialMovieDetailState extends MovieDetailState {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;
  GetMovieDetailEvent({required this.id});
}

class GetMovieDetailInProgressState extends MovieDetailState {}

class GetMovieDetailCompletedState extends MovieDetailState {
  final MovieDetail movie;
  GetMovieDetailCompletedState({required this.movie});
}

class GetMovieDetailFailedState extends MovieDetailState {
  final GlobalFailureModel failure;
  GetMovieDetailFailedState({required this.failure});
}
