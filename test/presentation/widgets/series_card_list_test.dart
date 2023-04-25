import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('SeriesCard widget test', () {
    const series = testSeries;

    testWidgets('should display SeriesCard widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SeriesCard(series),
          ),
        ),
      );

      expect(find.byType(SeriesCard), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.text(series.name!), findsOneWidget);
      expect(find.text(series.overview!), findsOneWidget);
    });

    testWidgets('should navigate to SeriesDetailPage when tapped',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: SeriesCard(series),
          ),
          navigatorObservers: [mockObserver],
          onGenerateRoute: (settings) {
            if (settings.name == SeriesDetailPage.ROUTE_NAME) {
              return MaterialPageRoute(
                builder: (context) => const SeriesDetailPage(id: 1),
              );
            }
            return null;
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // verify(mockObserver.didPush(any(), any())).captured.first;
      expect(find.byType(SeriesDetailPage), findsOneWidget);
    });
  });
}
