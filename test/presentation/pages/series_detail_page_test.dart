import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/presentation/bloc/series/season_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series/watchlist_series_bloc.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeriesDetailBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}

class MockSeriesRecommendationBloc
    extends MockBloc<SeriesRecommendationEvent, SeriesRecommendationState>
    implements SeriesRecommendationBloc {}

class MockWatchlistSeriesBloc
    extends MockBloc<WatchlistSeriesEvent, WatchlistSeriesState>
    implements WatchlistSeriesBloc {}

class MockSeasonDetailBloc
    extends MockBloc<SeasonDetailEvent, SeasonDetailState>
    implements SeasonDetailBloc {}

void main() {
  late MockSeriesDetailBloc mockSeriesDetailBloc;
  late MockSeasonDetailBloc mockSeasonDetailBloc;
  late MockSeriesRecommendationBloc mockSeriesRecommendationBloc;
  late MockWatchlistSeriesBloc mockWatchlistSeriesBloc;

  setUp(() {
    mockSeriesDetailBloc = MockSeriesDetailBloc();
    mockSeasonDetailBloc = MockSeasonDetailBloc();
    mockSeriesRecommendationBloc = MockSeriesRecommendationBloc();
    mockWatchlistSeriesBloc = MockWatchlistSeriesBloc();
  });

  Widget makeTestableWidget(Widget body, [Widget? body2]) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeriesDetailBloc>.value(value: mockSeriesDetailBloc),
        BlocProvider<SeasonDetailBloc>.value(value: mockSeasonDetailBloc),
        BlocProvider<SeriesRecommendationBloc>.value(
          value: mockSeriesRecommendationBloc,
        ),
        BlocProvider<WatchlistSeriesBloc>.value(value: mockWatchlistSeriesBloc),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => body,
          SeriesDetailPage.ROUTE_NAME: (context) =>
              body2 ?? const SizedBox.shrink(),
        },
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: false),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    whenListen(
      mockWatchlistSeriesBloc,
      Stream.fromIterable([
        AddWatchlistSeriesCompletedState(message: 'Added to Watchlist_TEST'),
      ]),
      initialState:
          LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: false),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist_TEST'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    whenListen(
      mockWatchlistSeriesBloc,
      Stream.fromIterable([
        RemoveWatchlistSeriesCompletedState(
          message: 'Removed from Watchlist_TEST',
        ),
      ]),
      initialState:
          LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist_TEST'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    whenListen(
      mockWatchlistSeriesBloc,
      Stream.fromIterable([
        AddWatchlistSeriesFailedState(
          failure: const GlobalFailureModel(message: 'Failed_TEST'),
        ),
      ]),
      initialState: InitialWatchlistSeriesEventState(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('SeriesDetailPage should display text when error',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state).thenReturn(
      GetSeriesDetailFailedState(
        failure: const GlobalFailureModel(message: 'Failed_TEST'),
      ),
    );
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('Recommendation should display text when error',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationFailedState(
        failure: const GlobalFailureModel(message: 'Failed_TEST'),
      ),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('Recommendation should display a series when loaded',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byType(ClipRRect), findsNWidgets(2));
  });

  testWidgets('Page should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailInProgressState());
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'Recommendation should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationInProgressState(),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('Recommendation should display a Container when empty',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: []),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child == null &&
            widget.decoration == null &&
            widget.color == null,
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should go to new page after tapping recommended series',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(GetSeriesDetailCompletedState(series: testSeriesDetail));
    when(() => mockSeasonDetailBloc.state)
        .thenReturn(GetSeasonDetailCompletedState(season: testSeasonDetail));
    when(() => mockSeriesRecommendationBloc.state).thenReturn(
      GetSeriesRecommendationCompletedState(series: testSeriesList),
    );
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: true),
    );

    const page2 = SeriesDetailPage(id: 123);

    await tester.pumpWidget(makeTestableWidget(page2));

    final buttonToTap = find.byKey(const Key('season-0'));

    await tester.dragUntilVisible(
      buttonToTap,
      find.byType(DraggableScrollableSheet),
      const Offset(0, 10),
    );
    await tester.tap(buttonToTap);
    await tester.pump();
    await tester.pump();

    expect(find.byWidgetPredicate((widget) => widget == page2), findsOneWidget);
  });
}
