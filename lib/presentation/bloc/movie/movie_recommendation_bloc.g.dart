// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_recommendation_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialMovieRecommendationState extends MovieRecommendationState {}

class GetMovieRecommendationEvent extends MovieRecommendationEvent {
  final int id;
  GetMovieRecommendationEvent({required this.id});
}

class GetMovieRecommendationInProgressState extends MovieRecommendationState {}

class GetMovieRecommendationCompletedState extends MovieRecommendationState {
  final List<Movie> movies;
  GetMovieRecommendationCompletedState({required this.movies});
}

class GetMovieRecommendationFailedState extends MovieRecommendationState {
  final GlobalFailureModel failure;
  GetMovieRecommendationFailedState({required this.failure});
}
