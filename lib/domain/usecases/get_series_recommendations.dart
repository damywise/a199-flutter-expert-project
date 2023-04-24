import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetSeriesRecommendations {
  GetSeriesRecommendations(this.repository);
  final SeriesRepository repository;

  Future<Either<Failure, List<Series>>> execute(int id) {
    return repository.getSeriesRecommendations(id);
  }
}
