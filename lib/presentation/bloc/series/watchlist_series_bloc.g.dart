// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_series_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialWatchlistSeriesEventState extends WatchlistSeriesState {}

class GetWatchlistSeriesEvent extends WatchlistSeriesEvent {}

class GetWatchlistSeriesInProgressState extends WatchlistSeriesState {}

class GetWatchlistSeriesCompletedState extends WatchlistSeriesState {
  final List<Series> series;
  GetWatchlistSeriesCompletedState({required this.series});
}

class GetWatchlistSeriesFailedState extends WatchlistSeriesState {
  final GlobalFailureModel failure;
  GetWatchlistSeriesFailedState({required this.failure});
}

class AddWatchlistSeriesEvent extends WatchlistSeriesEvent {
  final SeriesDetail series;
  AddWatchlistSeriesEvent({required this.series});
}

class AddWatchlistSeriesInProgressState extends WatchlistSeriesState {}

class AddWatchlistSeriesCompletedState extends WatchlistSeriesState {
  final String message;
  AddWatchlistSeriesCompletedState({required this.message});
}

class AddWatchlistSeriesFailedState extends WatchlistSeriesState {
  final GlobalFailureModel failure;
  AddWatchlistSeriesFailedState({required this.failure});
}

class RemoveWatchlistSeriesEvent extends WatchlistSeriesEvent {
  final SeriesDetail series;
  RemoveWatchlistSeriesEvent({required this.series});
}

class RemoveWatchlistSeriesInProgressState extends WatchlistSeriesState {}

class RemoveWatchlistSeriesCompletedState extends WatchlistSeriesState {
  final String message;
  RemoveWatchlistSeriesCompletedState({required this.message});
}

class RemoveWatchlistSeriesFailedState extends WatchlistSeriesState {
  final GlobalFailureModel failure;
  RemoveWatchlistSeriesFailedState({required this.failure});
}

class LoadWatchlistStatusSeriesEvent extends WatchlistSeriesEvent {
  final int id;
  LoadWatchlistStatusSeriesEvent({required this.id});
}

class LoadWatchlistStatusSeriesInProgressState extends WatchlistSeriesState {}

class LoadWatchlistStatusSeriesCompletedState extends WatchlistSeriesState {
  final bool isAddedToWatchlist;
  LoadWatchlistStatusSeriesCompletedState({required this.isAddedToWatchlist});
}

class LoadWatchlistStatusSeriesFailedState extends WatchlistSeriesState {
  final GlobalFailureModel failure;
  LoadWatchlistStatusSeriesFailedState({required this.failure});
}
