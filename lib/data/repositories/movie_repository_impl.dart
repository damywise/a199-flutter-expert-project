import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await remoteDataSource.getTopRatedMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
