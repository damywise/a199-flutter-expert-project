import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetSeasonDetail {
  GetSeasonDetail(this.repository);
  final SeriesRepository repository;

  Future<Either<Failure, SeasonDetail>> execute(
    int seriesId,
    int seasonNumber,
  ) {
    return repository.getSeasonDetail(seriesId, seasonNumber);
  }
}
