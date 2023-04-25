import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series/watchlist_series_bloc.dart';
import 'package:ditonton/presentation/pages/series_season_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({super.key, required this.id});

  static const ROUTE_NAME = '/series-detail';

  final int id;

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SeriesDetailBloc>().add(
            GetSeriesDetailEvent(id: widget.id),
          ),
    );

    Future.microtask(
      () => context.read<WatchlistSeriesBloc>().add(
            LoadWatchlistStatusSeriesEvent(id: widget.id),
          ),
    );

    Future.microtask(
      () => context.read<SeriesRecommendationBloc>().add(
            GetSeriesRecommendationEvent(id: widget.id),
          ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    GetSeriesDetailEvent(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state is GetSeriesDetailCompletedState) {
            final series = state.series;
            return SafeArea(
              child: DetailContent(
                series,
              ),
            );
          } else if (state is GetSeriesDetailFailedState) {
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
    this.series, {
    super.key,
  });

  final SeriesDetail series;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
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
                        key: const Key('singlechildscrollview'),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: kHeading5,
                            ),
                            BlocListener<WatchlistSeriesBloc,
                                WatchlistSeriesState>(
                              listener: (context, state) {
                                final added =
                                    state is AddWatchlistSeriesCompletedState;
                                final removed = state
                                    is RemoveWatchlistSeriesCompletedState;

                                if (added || removed) {
                                  final message = added
                                      ? state.message
                                      : (state
                                              as RemoveWatchlistSeriesCompletedState)
                                          .message;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                } else if (state
                                    is AddWatchlistSeriesFailedState) {
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
                              child: BlocBuilder<WatchlistSeriesBloc,
                                  WatchlistSeriesState>(
                                builder: (context, state) {
                                  var isAddedWatchlist = false;
                                  final added =
                                      state is AddWatchlistSeriesCompletedState;
                                  final removed = state
                                      is RemoveWatchlistSeriesCompletedState;
                                  if (state
                                      is LoadWatchlistStatusSeriesCompletedState) {
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
                                        context.read<WatchlistSeriesBloc>().add(
                                              AddWatchlistSeriesEvent(
                                                series: series,
                                              ),
                                            );
                                      } else {
                                        context.read<WatchlistSeriesBloc>().add(
                                              RemoveWatchlistSeriesEvent(
                                                series: series,
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
                              _showGenres(series.genres),
                            ),
                            // Text(
                            //   _showDuration(series.),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: series.voteAverage / 2,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${series.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              series.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                key: const Key('season-list'),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = series.seasons?[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: InkWell(
                                      key: Key('season-$index'),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (_) =>
                                                SeriesSeasonDetailPage(
                                              seriesId: series.id,
                                              seasonNumber:
                                                  season!.seasonNumber!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${season?.posterPath ?? ''}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: series.seasons?.length,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationBloc,
                                SeriesRecommendationState>(
                              builder: (context, state) {
                                if (state
                                    is GetSeriesRecommendationInProgressState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is GetSeriesRecommendationFailedState) {
                                  return Text(state.failure.message);
                                } else if (state
                                    is GetSeriesRecommendationCompletedState) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final series = state.series[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SeriesDetailPage.ROUTE_NAME,
                                                arguments: series.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${series.posterPath}',
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
                                      itemCount: state.series.length,
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
}
