import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/presentation/bloc/series/season_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesSeasonDetailPage extends StatefulWidget {
  const SeriesSeasonDetailPage({
    super.key,
    required this.seriesId,
    required this.seasonNumber,
  });

  static const ROUTE_NAME = '/season-detail';

  final int seriesId;
  final int seasonNumber;

  @override
  _SeriesSeasonDetailPageState createState() => _SeriesSeasonDetailPageState();
}

class _SeriesSeasonDetailPageState extends State<SeriesSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeasonDetailBloc>().add(
            GetSeasonDetailEvent(
              seriesId: widget.seriesId,
              seasonNumber: widget.seasonNumber,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        builder: (context, state) {
          if (state is GetSeasonDetailCompletedState) {
            final season = state.season;
            return SafeArea(
              child: DetailContent(
                season,
              ),
            );
          } else if (state is GetSeasonDetailFailedState) {
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
  const DetailContent(this.season, {super.key});

  final SeasonDetail season;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
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
                              season.name,
                              style: kHeading5,
                            ),
                            // Text(
                            //   _showDuration(series.),
                            // ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              season.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            ...season.episodes.map(
                              (episode) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: InkWell(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      insetPadding: const EdgeInsets.all(8)
                                          .copyWith(top: 128, bottom: 128),
                                      backgroundColor: kRichBlack,
                                      child: Align(
                                        child: Padding(
                                          padding: const EdgeInsets.all(32),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  episode.name ?? '-',
                                                  style: kHeading6,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  episode.overview ?? '-',
                                                  style: kSubtitle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 32,
                                        child: Text(
                                          episode.episodeNumber.toString(),
                                          style: kHeading6,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              episode.name ?? '-',
                                              overflow: TextOverflow.ellipsis,
                                              style: kSubtitle,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              episode.overview ?? '-',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const ColoredBox(
                                              color: Colors.white,
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
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
        ),
      ],
    );
  }
}
