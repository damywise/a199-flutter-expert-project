import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetNowPlayingMovies {
  GetNowPlayingMovies(this.repository);
  final MovieRepository repository;

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
