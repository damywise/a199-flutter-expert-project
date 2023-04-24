// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_search_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialSeriesSearchState extends SeriesSearchState {}

class GetSeriesSearchEvent extends SeriesSearchEvent {
  final String query;
  GetSeriesSearchEvent({required this.query});
}

class GetSeriesSearchInProgressState extends SeriesSearchState {}

class GetSeriesSearchCompletedState extends SeriesSearchState {
  final List<Series> data;
  GetSeriesSearchCompletedState({required this.data});
}

class GetSeriesSearchFailedState extends SeriesSearchState {
  final GlobalFailureModel failure;
  GetSeriesSearchFailedState({required this.failure});
}
