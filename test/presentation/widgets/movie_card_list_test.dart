import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('MovieCard widget test', () {
    const movie = testMovie;

    testWidgets('should display MovieCard widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MovieCard(movie),
          ),
        ),
      );

      expect(find.byType(MovieCard), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.text(movie.title!), findsOneWidget);
      expect(find.text(movie.overview!), findsOneWidget);
    });

    testWidgets('should navigate to MovieDetailPage when tapped',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: MovieCard(movie),
          ),
          navigatorObservers: [mockObserver],
          onGenerateRoute: (settings) {
            if (settings.name == MovieDetailPage.ROUTE_NAME) {
              return MaterialPageRoute(
                builder: (context) => const MovieDetailPage(id: 1),
              );
            }
            return null;
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // verify(mockObserver.didPush(any(), any())).captured.first;
      expect(find.byType(MovieDetailPage), findsOneWidget);
    });
  });
}
