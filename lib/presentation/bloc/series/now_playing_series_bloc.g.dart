// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_series_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialNowPlayingSeriesEventState extends NowPlayingSeriesState {}

class GetNowPlayingSeriesEvent extends NowPlayingSeriesEvent {}

class GetNowPlayingSeriesInProgressState extends NowPlayingSeriesState {}

class GetNowPlayingSeriesCompletedState extends NowPlayingSeriesState {
  final List<Series> series;
  GetNowPlayingSeriesCompletedState({required this.series});
}

class GetNowPlayingSeriesFailedState extends NowPlayingSeriesState {
  final GlobalFailureModel failure;
  GetNowPlayingSeriesFailedState({required this.failure});
}
