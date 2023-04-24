import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/domain/usecases/get_episode_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_season_detail.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/series/episode_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/now_playing_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/season_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/series/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/watchlist_series_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // bloc
  locator
    ..registerFactory(
      () => NowPlayingMovieBloc(
        getNowPlayingMovies: locator(),
      ),
    )
    ..registerFactory(
      () => PopularMovieBloc(
        getPopularMovies: locator(),
      ),
    )
    ..registerFactory(
      () => TopRatedMovieBloc(
        getTopRatedMovies: locator(),
      ),
    )
    ..registerFactory(
      () => MovieDetailBloc(
        getMovieDetail: locator(),
      ),
    )
    ..registerFactory(
      () => MovieSearchBloc(
        searchMovies: locator(),
      ),
    )
    ..registerFactory(
          () => MovieRecommendationBloc(
        getMovieRecommendations: locator(),
      ),
    )
    ..registerFactory(
      () => WatchlistMovieBloc(
        getWatchlistMovies: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ),
    )

    // use case
    ..registerLazySingleton(() => GetNowPlayingMovies(locator()))
    ..registerLazySingleton(() => GetPopularMovies(locator()))
    ..registerLazySingleton(() => GetTopRatedMovies(locator()))
    ..registerLazySingleton(() => GetMovieDetail(locator()))
    ..registerLazySingleton(() => GetMovieRecommendations(locator()))
    ..registerLazySingleton(() => SearchMovies(locator()))
    ..registerLazySingleton(() => GetWatchListStatus(locator()))
    ..registerLazySingleton(() => SaveWatchlistMovie(locator()))
    ..registerLazySingleton(() => RemoveWatchlistMovie(locator()))
    ..registerLazySingleton(() => GetWatchlistMovies(locator()))

    // repository
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
    )

    // data sources
    ..registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()),
    )
    ..registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()),
    )

    // =======================Series

    // bloc
    ..registerFactory(
      () => NowPlayingSeriesBloc(
        getNowPlayingSeries: locator(),
      ),
    )
    ..registerFactory(
      () => PopularSeriesBloc(
        getPopularSeries: locator(),
      ),
    )
    ..registerFactory(
      () => TopRatedSeriesBloc(
        getTopRatedSeries: locator(),
      ),
    )
    ..registerFactory(
      () => SeriesDetailBloc(
        getSeriesDetail: locator(),
      ),
    )
    ..registerFactory(
      () => SeasonDetailBloc(
        getSeasonDetail: locator(),
      ),
    )
    ..registerFactory(
      () => EpisodeDetailBloc(
        getEpisodeDetail: locator(),
      ),
    )
    ..registerFactory(
      () => SeriesSearchBloc(
        searchSeries: locator(),
      ),
    )
    ..registerFactory(
      () => SeriesRecommendationBloc(
        getSeriesRecommendations: locator(),
      ),
    )
    ..registerFactory(
      () => WatchlistSeriesBloc(
        getWatchlistSeries: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ),
    )

    // use case
    ..registerLazySingleton(() => GetNowPlayingSeries(locator()))
    ..registerLazySingleton(() => GetPopularSeries(locator()))
    ..registerLazySingleton(() => GetTopRatedSeries(locator()))
    ..registerLazySingleton(() => GetSeriesDetail(locator()))
    ..registerLazySingleton(() => GetSeasonDetail(locator()))
    ..registerLazySingleton(() => GetEpisodeDetail(locator()))
    ..registerLazySingleton(() => GetSeriesRecommendations(locator()))
    ..registerLazySingleton(() => SearchSeries(locator()))
    ..registerLazySingleton(() => SaveWatchlistSeries(locator()))
    ..registerLazySingleton(() => RemoveWatchlistSeries(locator()))
    ..registerLazySingleton(() => GetWatchlistSeries(locator()))

    // repository
    ..registerLazySingleton<SeriesRepository>(
      () => SeriesRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
    )

    // data sources
    ..registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()),
    )
    ..registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()),
    )

    // helper
    ..registerLazySingleton<DatabaseHelper>(DatabaseHelper.new)

    // external
    ..registerLazySingleton(http.Client.new);
}
