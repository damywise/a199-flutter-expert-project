import 'package:ditonton/presentation/bloc/series/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedSeriesPage extends StatefulWidget {
  const TopRatedSeriesPage({super.key});

  static const ROUTE_NAME = '/top-rated-series';

  @override
  _TopRatedSeriesPageState createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedSeriesBloc>().add(GetTopRatedSeriesEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state is GetTopRatedSeriesInProgressState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetTopRatedSeriesCompletedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.series[index];
                  return SeriesCard(series);
                },
                itemCount: state.series.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(
                  (state as GetTopRatedSeriesFailedState).failure.message,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
