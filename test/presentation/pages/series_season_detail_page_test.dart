import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/series_season_detail_page.dart';
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

  Widget makeTestableWidget([Widget? body]) {
    return ChangeNotifierProvider<SeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SeriesSeasonDetailPage(
                seriesId: testSeries.id,
                seasonNumber: testSeason.id!,
              ),
          SeriesSeasonDetailPage.ROUTE_NAME: (context) =>
              body ?? const SizedBox.shrink(),
        },
      ),
    );
  }

  testWidgets('SeriesSeasonDetailPage should display text when error',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Empty);
    when(mockNotifier.season).thenReturn(testSeasonDetail);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text(mockNotifier.message), findsOneWidget);
  });

  testWidgets('Recommendation should display text when error',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Error);
    when(mockNotifier.season).thenReturn(testSeasonDetail);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text(mockNotifier.message), findsOneWidget);
  });

  testWidgets('Page should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
    when(mockNotifier.season).thenReturn(testSeasonDetail);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');
    when(mockNotifier.message).thenReturn('Message');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // testWidgets('Should go to new page after tapping recommended series',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.series).thenReturn(testSeriesSeasonDetail);
  //   when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.season).thenReturn(testSeriesList);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //   const page1 = SeriesSeasonDetailPage(id: 1);
  //   const page2 = SeriesSeasonDetailPage(id: 123);
  //
  //   await tester.pumpWidget(makeTestableWidget(page1, page2));
  //
  //   final buttonToTap = find.byWidgetPredicate(
  //     (widget) => widget is InkWell && widget.child is ClipRRect,
  //   );
  //
  //   await tester.dragUntilVisible(
  //     buttonToTap,
  //     find.byType(ListView),
  //     const Offset(0, 50),
  //   );
  //   await tester.tap(buttonToTap);
  //   await tester.pump();
  //   await tester.pump();
  //
  //   expect(find.byWidgetPredicate((widget) => widget == page2), findsOneWidget);
  // });
}
