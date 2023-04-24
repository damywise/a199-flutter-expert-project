import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetEpisodeDetail {
  GetEpisodeDetail(this.repository);
  final SeriesRepository repository;

  Future<Either<Failure, Episode>> execute(
    int seriesId,
    int seasonNumber,
    int episodeNumber,
  ) {
    return repository.getEpisodeDetail(seriesId, seasonNumber, episodeNumber);
  }
}
