import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/provider/series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_page_test.mocks.dart';

@GenerateMocks([SeriesDetailNotifier])
void main() {
  late MockSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesDetailNotifier();
  });

  Widget makeTestableWidget(Widget body, [Widget? body2]) {
    return ChangeNotifierProvider<SeriesDetailNotifier>.value(
      value: mockNotifier,
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
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when series is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(
      testSeriesDetail,
    );
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('SeriesDetailPage should display text when error',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Error);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.text(mockNotifier.message), findsOneWidget);
  });

  testWidgets('Recommendation should display text when error',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
    when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.text(mockNotifier.message), findsOneWidget);
  });

  testWidgets('Recommendation should display a series when loaded',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(testSeriesList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byType(ClipRRect), findsNWidgets(2));
  });

  testWidgets('Page should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loading);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(testSeriesList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'Recommendation should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
    when(mockNotifier.seriesRecommendations).thenReturn(testSeriesList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('Recommendation should display a Container when empty',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.seriesRecommendations).thenReturn(testSeriesList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

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
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesRecommendations).thenReturn(testSeriesList);
    when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
    when(mockNotifier.season).thenReturn(testSeasonDetail);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

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
