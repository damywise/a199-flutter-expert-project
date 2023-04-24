import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWatchlistSeries {
  GetWatchlistSeries(this._repository);
  final SeriesRepository _repository;

  Future<Either<Failure, List<Series>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
