import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget makeTestableWidget(Widget body, [Widget? body2]) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<MovieRecommendationBloc>.value(
          value: mockMovieRecommendationBloc,
        ),
        BlocProvider<WatchlistMovieBloc>.value(value: mockWatchlistMovieBloc),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => body,
          MovieDetailPage.ROUTE_NAME: (context) =>
              body2 ?? const SizedBox.shrink(),
        },
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    // when(mockMovieDetailBloc.movieState).thenReturn(RequestState.Loaded);
    // when(mockMovieDetailBloc.movie).thenReturn(testMovieDetail);
    // when(mockMovieDetailBloc.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockMovieDetailBloc.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockMovieDetailBloc.isAddedToWatchlist).thenReturn(false);
    when(() => mockMovieDetailBloc.state).thenReturn(
      GetMovieDetailCompletedState(
        movie: const MovieDetail(
          adult: false,
          backdropPath: 'backdropPath',
          genres: [],
          id: 1,
          originalTitle: 'originalTitle',
          overview: 'overview',
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          runtime: 120,
          title: 'title',
          voteAverage: 1,
          voteCount: 1,
        ),
      ),
    );
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: false),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    whenListen(
      mockWatchlistMovieBloc,
      Stream.fromIterable([
        AddWatchlistMovieCompletedState(message: 'Added to Watchlist_TEST'),
      ]),
      initialState:
          LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: false),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsNothing);
    expect(find.text('Added to Watchlist_TEST'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    whenListen(
      mockWatchlistMovieBloc,
      Stream.fromIterable([
        RemoveWatchlistMovieCompletedState(
          message: 'Removed from Watchlist_TEST',
        ),
      ]),
      initialState:
          LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsNothing);
    expect(find.text('Removed from Watchlist_TEST'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    whenListen(
      mockWatchlistMovieBloc,
      Stream.fromIterable([
        AddWatchlistMovieFailedState(
          failure: const GlobalFailureModel(message: 'Failed_TEST'),
        ),
      ]),
      initialState: InitialWatchlistMovieEventState(),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('MovieDetailPage should display text when error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
      GetMovieDetailFailedState(
        failure: const GlobalFailureModel(message: 'Failed_TEST'),
      ),
    );
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('Recommendation should display text when error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationFailedState(
        failure: const GlobalFailureModel(message: 'Failed_TEST'),
      ),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('Failed_TEST'), findsOneWidget);
  });

  testWidgets('Recommendation should display a movie when loaded',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets('Page should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailInProgressState());
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'Recommendation should display a CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationInProgressState(),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
  });

  testWidgets('Recommendation should display a Container when empty',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: []),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

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

  testWidgets('Should go to new page after tapping recommended movie',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(GetMovieDetailCompletedState(movie: testMovieDetail));
    when(() => mockMovieRecommendationBloc.state).thenReturn(
      GetMovieRecommendationCompletedState(movies: testMovieList),
    );
    when(() => mockWatchlistMovieBloc.state).thenReturn(
      LoadWatchlistStatusMovieCompletedState(isAddedToWatchlist: true),
    );

    const page1 = MovieDetailPage(id: 1);
    const page2 = MovieDetailPage(id: 123);

    await tester.pumpWidget(makeTestableWidget(page1, page2));

    final buttonToTap = find.byWidgetPredicate(
      (widget) => widget is InkWell && widget.child is ClipRRect,
    );

    await tester.dragUntilVisible(
      buttonToTap,
      find.byType(ListView),
      const Offset(0, 50),
    );
    await tester.tap(buttonToTap);
    await tester.pump();
    await tester.pump();

    expect(find.byWidgetPredicate((widget) => widget == page2), findsOneWidget);
  });
}
