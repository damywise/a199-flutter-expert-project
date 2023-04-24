import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/series/now_playing_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<NowPlayingMovieBloc>()..add(GetNowPlayingMoviesEvent()),
    );
    Future.microtask(
      () =>
          context.read<PopularMovieBloc>()..add(GetPopularMoviesEvent()),
    );
    Future.microtask(
      () =>
          context.read<TopRatedMovieBloc>()..add(GetTopRatedMoviesEvent()),
    );
    Future.microtask(
      () =>
          context.read<NowPlayingSeriesBloc>()..add(GetNowPlayingSeriesEvent()),
    );
    Future.microtask(
      () =>
          context.read<PopularSeriesBloc>()..add(GetPopularSeriesEvent()),
    );
    Future.microtask(
      () =>
          context.read<TopRatedSeriesBloc>()..add(GetTopRatedSeriesEvent()),
    );
  }

  bool _tvSeriesMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          ),
          Tooltip(
            message: _tvSeriesMode ? 'Switch to Movies' : 'Switch to TV Series',
            child: IconButton(
              onPressed: () {
                setState(() {
                  _tvSeriesMode = !_tvSeriesMode;
                });
              },
              icon: AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                firstChild: const Icon(Icons.movie),
                secondChild:
                    Text('TV', style: Theme.of(context).textTheme.titleLarge),
                crossFadeState: _tvSeriesMode
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () => Navigator.pushNamed(
                  context,
                  _tvSeriesMode
                      ? NowPlayingSeriesPage.ROUTE_NAME
                      : NowPlayingMoviesPage.ROUTE_NAME,
                ),
              ),
              if (_tvSeriesMode)
                BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if (state is GetNowPlayingSeriesCompletedState) {
                      return SeriesList(state.series);
                    } else if (state is GetNowPlayingSeriesFailedState) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              else
                BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                  builder: (context, state) {
                    if (state is GetNowPlayingMoviesCompletedState) {
                      return MovieList(state.movies);
                    } else if (state is GetNowPlayingMoviesFailedState) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  _tvSeriesMode
                      ? PopularSeriesPage.ROUTE_NAME
                      : PopularMoviesPage.ROUTE_NAME,
                ),
              ),
              if (_tvSeriesMode)
                BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                  builder: (context, state) {
                    if (state is GetPopularSeriesCompletedState) {
                      return SeriesList(state.series);
                    } else if (state is GetPopularSeriesFailedState) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              else
                BlocBuilder<PopularMovieBloc, PopularMovieState>(
                  builder: (context, state) {
                    if (state is GetPopularMoviesCompletedState) {
                      return MovieList(state.movies);
                    } else if (state is GetPopularMoviesFailedState) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  _tvSeriesMode
                      ? TopRatedSeriesPage.ROUTE_NAME
                      : TopRatedMoviesPage.ROUTE_NAME,
                ),
              ),
              if (_tvSeriesMode)
                BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                  builder: (context, state) {
                    if (state is GetTopRatedSeriesCompletedState) {
                      return SeriesList(state.series);
                    } else if (state is GetTopRatedSeriesFailedState) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              else
                BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                  builder: (context, state) {
                    if (state is GetTopRatedMoviesCompletedState) {
                      return MovieList(state.movies);
                    } else if (state is GetTopRatedMoviesFailedState) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required void Function() onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class SeriesList extends StatelessWidget {
  const SeriesList(this.series, {super.key});

  final List<Series> series;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final show = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: show.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${show.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
