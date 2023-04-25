import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.id});

  static const ROUTE_NAME = '/movie-detail';

  final int id;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<MovieDetailBloc>().add(
            GetMovieDetailEvent(id: widget.id),
          ),
    );

    Future.microtask(
      () => context.read<WatchlistMovieBloc>().add(
            LoadWatchlistStatusMovieEvent(id: widget.id),
          ),
    );

    Future.microtask(
      () => context.read<MovieRecommendationBloc>().add(
            GetMovieRecommendationEvent(id: widget.id),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is GetMovieDetailCompletedState) {
            final movie = state.movie;
            return SafeArea(
              child: DetailContent(
                movie,
              ),
            );
          } else if (state is GetMovieDetailFailedState) {
            return Text(state.failure.message);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent(
    this.movie, {
    super.key,
  });

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocListener<WatchlistMovieBloc,
                                WatchlistMovieState>(
                              listener: (context, state) {
                                final added =
                                    state is AddWatchlistMovieCompletedState;
                                final removed =
                                    state is RemoveWatchlistMovieCompletedState;

                                if (added || removed) {
                                  final message = added
                                      ? state.message
                                      : (state
                                              as RemoveWatchlistMovieCompletedState)
                                          .message;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                } else if (state
                                    is AddWatchlistMovieFailedState) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.failure.message),
                                      );
                                    },
                                  );
                                }
                              },
                              child: BlocBuilder<WatchlistMovieBloc,
                                  WatchlistMovieState>(
                                builder: (context, state) {
                                  var isAddedWatchlist = false;
                                  final added =
                                      state is AddWatchlistMovieCompletedState;
                                  final removed = state
                                      is RemoveWatchlistMovieCompletedState;
                                  if (state
                                      is LoadWatchlistStatusMovieCompletedState) {
                                    isAddedWatchlist = state.isAddedToWatchlist;
                                  }
                                  if (added) {
                                    isAddedWatchlist = true;
                                  }
                                  if (removed) {
                                    isAddedWatchlist = false;
                                  }
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (!isAddedWatchlist) {
                                        context.read<WatchlistMovieBloc>().add(
                                              AddWatchlistMovieEvent(
                                                movie: movie,
                                              ),
                                            );
                                      } else {
                                        context.read<WatchlistMovieBloc>().add(
                                              RemoveWatchlistMovieEvent(
                                                movie: movie,
                                              ),
                                            );
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (isAddedWatchlist)
                                          const Icon(Icons.check)
                                        else
                                          const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationBloc,
                                MovieRecommendationState>(
                              builder: (context, state) {
                                if (state
                                    is GetMovieRecommendationInProgressState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is GetMovieRecommendationFailedState) {
                                  return Text(state.failure.message);
                                } else if (state
                                    is GetMovieRecommendationCompletedState && state.movies.isNotEmpty) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.movies[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.movies.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    final result = StringBuffer();
    for (final genre in genres) {
      result.write('${genre.name}, ');
    }

    if (result.isEmpty) {
      return result.toString();
    }

    return result.toString().substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
