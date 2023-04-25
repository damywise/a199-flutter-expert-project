import 'package:ditonton/presentation/bloc/series/now_playing_series_bloc.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  const NowPlayingSeriesPage({super.key});

  static const ROUTE_NAME = '/now-playing-series';

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<NowPlayingSeriesBloc>().add(GetNowPlayingSeriesEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
          builder: (context, state) {
            if (state is GetNowPlayingSeriesInProgressState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetNowPlayingSeriesCompletedState) {
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
                  (state as GetNowPlayingSeriesFailedState).failure.message,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
