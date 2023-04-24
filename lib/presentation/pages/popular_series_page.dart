import 'package:ditonton/presentation/bloc/series/popular_series_bloc.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularSeriesPage extends StatefulWidget {
  const PopularSeriesPage({super.key});

  static const ROUTE_NAME = '/popular-series';

  @override
  _PopularSeriesPageState createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularSeriesBloc>().add(GetPopularSeriesEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (context, state) {
            if (state is GetPopularSeriesInProgressState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPopularSeriesCompletedState) {
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
                  (state as GetPopularSeriesFailedState).failure.message,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
