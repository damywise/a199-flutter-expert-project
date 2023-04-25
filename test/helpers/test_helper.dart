import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    SeriesRepository,
    SeriesRemoteDataSource,
    SeriesLocalDataSource,
    DatabaseHelper,
  ],
  customMocks: [MockSpec<IOClient>(as: #MockHttpClient)],
)
void main() {}
