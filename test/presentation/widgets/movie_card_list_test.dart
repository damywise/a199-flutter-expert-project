import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../pages/movie_detail_page_test.mocks.dart';

void main() {

  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  group('MovieCard widget test', () {
    final movie = testMovie;

    testWidgets('should display movie title and overview', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(movie),
          ),
        ),
      );

      expect(find.text(movie.title!), findsOneWidget);
      expect(find.text(movie.overview!), findsOneWidget);
    });

    testWidgets('should navigate to movie detail page when tapped', (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        ChangeNotifierProvider<MovieDetailNotifier>.value(
          value: mockNotifier,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                body: MovieCard(movie),
              ),
              MovieDetailPage.ROUTE_NAME: (context) => MovieDetailPage(id: movie.id),
            },
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();
      await tester.pump();

      expect(find.byType(MovieDetailPage), findsOneWidget);
    });

    testWidgets('Should not find MovieDetailPage when navigating back', (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(
        ChangeNotifierProvider<MovieDetailNotifier>.value(
          value: mockNotifier,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                body: MovieCard(movie),
              ),
              MovieDetailPage.ROUTE_NAME: (context) => MovieDetailPage(id: movie.id),
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

      expect(find.byType(MovieDetailPage), findsNothing);
    });

    testWidgets('should display movie poster image', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(movie),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
