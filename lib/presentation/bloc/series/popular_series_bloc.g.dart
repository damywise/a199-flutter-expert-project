// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_series_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialPopularSeriesEventState extends PopularSeriesState {}

class GetPopularSeriesEvent extends PopularSeriesEvent {}

class GetPopularSeriesInProgressState extends PopularSeriesState {}

class GetPopularSeriesCompletedState extends PopularSeriesState {
  final List<Series> series;
  GetPopularSeriesCompletedState({required this.series});
}

class GetPopularSeriesFailedState extends PopularSeriesState {
  final GlobalFailureModel failure;
  GetPopularSeriesFailedState({required this.failure});
}
