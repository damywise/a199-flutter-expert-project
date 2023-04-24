// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_recommendation_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialSeriesRecommendationState extends SeriesRecommendationState {}

class GetSeriesRecommendationEvent extends SeriesRecommendationEvent {
  final int id;
  GetSeriesRecommendationEvent({required this.id});
}

class GetSeriesRecommendationInProgressState
    extends SeriesRecommendationState {}

class GetSeriesRecommendationCompletedState extends SeriesRecommendationState {
  final List<Series> series;
  GetSeriesRecommendationCompletedState({required this.series});
}

class GetSeriesRecommendationFailedState extends SeriesRecommendationState {
  final GlobalFailureModel failure;
  GetSeriesRecommendationFailedState({required this.failure});
}
