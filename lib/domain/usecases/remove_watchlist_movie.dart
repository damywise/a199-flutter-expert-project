import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveWatchlistMovie {
  RemoveWatchlistMovie(this.repository);
  final MovieRepository repository;

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
