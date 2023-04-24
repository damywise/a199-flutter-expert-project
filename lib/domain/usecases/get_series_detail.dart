import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetSeriesDetail {
  GetSeriesDetail(this.repository);
  final SeriesRepository repository;

  Future<Either<Failure, SeriesDetail>> execute(int id) {
    return repository.getSeriesDetail(id);
  }
}
