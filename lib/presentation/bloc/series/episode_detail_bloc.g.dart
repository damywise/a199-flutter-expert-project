// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_detail_bloc.dart';

// **************************************************************************
// BlocGenerator
// **************************************************************************

class InitialEpisodeDetailState extends EpisodeDetailState {}

class GetEpisodeDetailEvent extends EpisodeDetailEvent {
  final int seriesId;
  final int seasonNumber;
  final int episodeNumber;
  GetEpisodeDetailEvent(
      {required this.seriesId,
      required this.seasonNumber,
      required this.episodeNumber});
}

class GetEpisodeDetailInProgressState extends EpisodeDetailState {}

class GetEpisodeDetailCompletedState extends EpisodeDetailState {
  final Episode episode;
  GetEpisodeDetailCompletedState({required this.episode});
}

class GetEpisodeDetailFailedState extends EpisodeDetailState {
  final GlobalFailureModel failure;
  GetEpisodeDetailFailedState({required this.failure});
}
