import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/presentation/bloc/series/season_detail_bloc.dart';
import 'package:ditonton/presentation/pages/series_season_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_page_test.dart';

void main() {
  late MockSeasonDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockSeasonDetailBloc();
  });

  Widget makeTestableWidget([Widget? body]) {
    return BlocProvider<SeasonDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SeriesSeasonDetailPage(
                seriesId: testSeason.id!,
                seasonNumber: testSeason.seasonNumber!,
              ),
          SeriesSeasonDetailPage.ROUTE_NAME: (context) =>
              body ?? const SizedBox.shrink(),
        },
      ),
    );
  }

  testWidgets('SeriesSeasonDetailPage should display text when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      GetSeasonDetailFailedState(
        failure: const GlobalFailureModel(message: 'Failed_TEST'),
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('Page should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      GetSeasonDetailInProgressState(),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
