import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../pages/movie_detail_page_test.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('MovieCard widget test', () {
    late MockMovieDetailBloc mockMovieDetailBloc;
    late MockMovieRecommendationBloc mockMovieRecommendationBloc;
    late MockWatchlistMovieBloc mockWatchlistMovieBloc;

    setUp(() {
      mockMovieDetailBloc = MockMovieDetailBloc();
      mockMovieRecommendationBloc = MockMovieRecommendationBloc();
      mockWatchlistMovieBloc = MockWatchlistMovieBloc();
    });

    const movie = testMovie;

    testWidgets('should display MovieCard widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
            BlocProvider<MovieRecommendationBloc>.value(
              value: mockMovieRecommendationBloc,
            ),
            BlocProvider<WatchlistMovieBloc>.value(
                value: mockWatchlistMovieBloc),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: MovieCard(movie),
            ),
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
      when(() => mockMovieDetailBloc.state)
          .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
      when(() => mockMovieRecommendationBloc.state).thenReturn(
        GetMovieRecommendationCompletedState(movies: testMovieList),
      );
      when(() => mockWatchlistMovieBloc.state).thenReturn(
        LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
      );
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
            BlocProvider<MovieRecommendationBloc>.value(
              value: mockMovieRecommendationBloc,
            ),
            BlocProvider<WatchlistMovieBloc>.value(
                value: mockWatchlistMovieBloc),
          ],
          child: MaterialApp(
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
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();
      await tester.pump();

      // verify(mockObserver.didPush(any(), any())).captured.first;
      expect(find.byType(MovieDetailPage), findsOneWidget);
    });
  });
}
