import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/series/now_playing_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/season_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/series/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/watchlist_series_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/now_playing_movies_page.dart';
import 'package:ditonton/presentation/pages/now_playing_series_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider<PopularMovieBloc>(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider<NowPlayingSeriesBloc>(
          create: (_) => di.locator<NowPlayingSeriesBloc>(),
        ),
        BlocProvider<PopularSeriesBloc>(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider<TopRatedSeriesBloc>(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider<SeriesDetailBloc>(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider<SeasonDetailBloc>(
          create: (_) => di.locator<SeasonDetailBloc>(),
        ),
        BlocProvider<SeriesSearchBloc>(
          create: (_) => di.locator<SeriesSearchBloc>(),
        ),
        BlocProvider<WatchlistSeriesBloc>(
          create: (_) => di.locator<WatchlistSeriesBloc>(),
        ),
        BlocProvider<SeriesRecommendationBloc>(
          create: (_) => di.locator<SeriesRecommendationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int? ?? -1;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const WatchlistPage(),
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const PopularSeriesPage(),
              );
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedSeriesPage(),
              );
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int? ?? -1;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case NowPlayingMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const NowPlayingMoviesPage(),
                settings: settings,
              );
            case NowPlayingSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => const NowPlayingSeriesPage(),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
