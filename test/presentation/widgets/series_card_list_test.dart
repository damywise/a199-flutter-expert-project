import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/provider/series_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../pages/series_detail_page_test.mocks.dart';

void main() {
  late MockSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesDetailNotifier();
  });

  group('SeriesCard widget test', () {
    const series = testSeries;

    testWidgets('should display series title and overview', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SeriesCard(series),
          ),
        ),
      );

      expect(find.text(series.name!), findsOneWidget);
      expect(find.text(series.overview!), findsOneWidget);
    });

    testWidgets('should navigate to series detail page when tapped',
        (tester) async {
      when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.series).thenReturn(testSeriesDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        ChangeNotifierProvider<SeriesDetailNotifier>.value(
          value: mockNotifier,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => const Scaffold(
                    body: SeriesCard(series),
                  ),
              SeriesDetailPage.ROUTE_NAME: (context) =>
                  SeriesDetailPage(id: series.id),
            },
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();
      await tester.pump();

      expect(find.byType(SeriesDetailPage), findsOneWidget);
    });

    testWidgets('Should not find SeriesDetailPage when navigating back',
        (tester) async {
      when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.series).thenReturn(testSeriesDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.seriesRecommendations).thenReturn(<Series>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        ChangeNotifierProvider<SeriesDetailNotifier>.value(
          value: mockNotifier,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => const Scaffold(
                    body: SeriesCard(series),
                  ),
              SeriesDetailPage.ROUTE_NAME: (context) =>
                  SeriesDetailPage(id: series.id),
            },
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      await tester.pump();

      expect(find.byType(SeriesDetailPage), findsNothing);
    });

    testWidgets('should display series poster image', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SeriesCard(series),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
