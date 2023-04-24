// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_rated_series_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialTopRatedSeriesEventState extends TopRatedSeriesState {}

class GetTopRatedSeriesEvent extends TopRatedSeriesEvent {}

class GetTopRatedSeriesInProgressState extends TopRatedSeriesState {}

class GetTopRatedSeriesCompletedState extends TopRatedSeriesState {
  final List<Series> series;
  GetTopRatedSeriesCompletedState({required this.series});
}

class GetTopRatedSeriesFailedState extends TopRatedSeriesState {
  final GlobalFailureModel failure;
  GetTopRatedSeriesFailedState({required this.failure});
}
