import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWatchlistMovies {
  GetWatchlistMovies(this._repository);
  final MovieRepository _repository;

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
