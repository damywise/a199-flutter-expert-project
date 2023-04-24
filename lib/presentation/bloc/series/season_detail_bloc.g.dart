// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_detail_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialSeasonDetailState extends SeasonDetailState {}

class GetSeasonDetailEvent extends SeasonDetailEvent {
  final int seriesId;
  final int seasonNumber;
  GetSeasonDetailEvent({required this.seriesId, required this.seasonNumber});
}

class GetSeasonDetailInProgressState extends SeasonDetailState {}

class GetSeasonDetailCompletedState extends SeasonDetailState {
  final SeasonDetail season;
  GetSeasonDetailCompletedState({required this.season});
}

class GetSeasonDetailFailedState extends SeasonDetailState {
  final GlobalFailureModel failure;
  GetSeasonDetailFailedState({required this.failure});
}
