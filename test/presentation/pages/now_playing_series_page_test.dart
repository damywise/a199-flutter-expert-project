import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/presentation/bloc/series/now_playing_series_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_series_page.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingSeriesBloc
    extends MockBloc<NowPlayingSeriesEvent, NowPlayingSeriesState>
    implements NowPlayingSeriesBloc {}

void main() {
  late MockNowPlayingSeriesBloc mockBloc;

  setUp(() {
    mockBloc = MockNowPlayingSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(GetNowPlayingSeriesInProgressState());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display a list of SeriesCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(GetNowPlayingSeriesCompletedState(series: testSeriesList));

    final listViewFinder = find.byType(SeriesCard);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingSeriesPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      GetNowPlayingSeriesFailedState(
        failure: const GlobalFailureModel(message: 'Error message'),
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
