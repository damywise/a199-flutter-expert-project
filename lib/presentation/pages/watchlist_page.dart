import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/series/watchlist_series_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMovieBloc>().add(GetWatchlistMoviesEvent()));
    Future.microtask(() =>
        context.read<WatchlistSeriesBloc>().add(GetWatchlistSeriesEvent()));
  }

  bool tvSeriesMode = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchlistMoviesEvent());
    context.read<WatchlistSeriesBloc>().add(GetWatchlistSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                tvSeriesMode = !tvSeriesMode;
              });
            },
            icon: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              firstChild: const Icon(Icons.movie),
              secondChild:
                  Text('TV', style: Theme.of(context).textTheme.titleLarge),
              crossFadeState: tvSeriesMode
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: tvSeriesMode
            ? BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
                builder: (context, state) {
                  print(state.runtimeType);
                  if (state is GetWatchlistSeriesCompletedState) {
                    print('test');
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final series = state.series[index];
                        return SeriesCard(series);
                      },
                      itemCount: state.series.length,
                    );
                  } else if (state is GetWatchlistSeriesFailedState) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.failure.message),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                builder: (context, state) {
                  if (state is GetWatchlistMoviesCompletedState) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.movies.length,
                    );
                  } else if (state is GetWatchlistMoviesFailedState) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(
                        state.failure.message,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
