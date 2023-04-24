import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool tvSeriesMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context
                    .read<MovieSearchBloc>()
                    .add(GetMovieSearchEvent(query: query));
                context
                    .read<SeriesSearchBloc>()
                    .add(GetSeriesSearchEvent(query: query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (tvSeriesMode)
              BlocBuilder<SeriesSearchBloc, SeriesSearchState>(
                builder: (context, state) {
                  if (state is GetSeriesSearchInProgressState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetSeriesSearchCompletedState) {
                    final result = state.data;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final series = result[index];
                          return SeriesCard(series);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    // TODO(damywise): text if empty
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              )
            else
              BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is GetMovieSearchInProgressState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetMovieSearchCompletedState) {
                    final result = state.data;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final series = result[index];
                          return MovieCard(series);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    // TODO(damywise): text if empty
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
