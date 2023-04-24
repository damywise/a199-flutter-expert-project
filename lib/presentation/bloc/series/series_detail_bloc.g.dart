// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_detail_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialSeriesDetailState extends SeriesDetailState {}

class GetSeriesDetailEvent extends SeriesDetailEvent {
  final int id;
  GetSeriesDetailEvent({required this.id});
}

class GetSeriesDetailInProgressState extends SeriesDetailState {}

class GetSeriesDetailCompletedState extends SeriesDetailState {
  final SeriesDetail series;
  GetSeriesDetailCompletedState({required this.series});
}

class GetSeriesDetailFailedState extends SeriesDetailState {
  final GlobalFailureModel failure;
  GetSeriesDetailFailedState({required this.failure});
}
