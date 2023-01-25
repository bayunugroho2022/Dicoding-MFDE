import 'package:ditonton/presentation/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'mock/movie_mock.dart';

void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockRecommendationMoviesBloc mockMovieRecommendationsBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUp(() {
    registerFallbackValue(MockDetailMovieEvent());
    registerFallbackValue(MockDetailMovieState());
    mockDetailMovieBloc = MockDetailMovieBloc();

    registerFallbackValue(MockRecommendationMoviesEvent());
    registerFallbackValue(MockRecommendationMoviesState());
    mockMovieRecommendationsBloc = MockRecommendationMoviesBloc();

    registerFallbackValue(MockWatchlistMovieEvent());
    registerFallbackValue(MockWatchlistMovieState());
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (_) => mockDetailMovieBloc,
        ),
        BlocProvider<RecommendationMoviesBloc>(
          create: (_) => mockMovieRecommendationsBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => mockWatchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockDetailMovieBloc.close();
    mockMovieRecommendationsBloc.close();
    mockWatchlistMovieBloc.close();
  });

  group('Detail Movie', () {
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state).thenReturn(DetailMovieLoading());
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(RecommendationMoviesLoading());
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieLoading());

      final viewProgress = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(viewProgress, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state).thenReturn(DetailMovieLoading());
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(RecommendationMoviesLoading());
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieLoading());

      final viewProgress = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(viewProgress, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(DetailMovieHasData(testMovieDetail));

      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(RecommendationMoviesHasData(testMovieList));

      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(InsertDataMovieToWatchlist(false));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect((watchlistButton), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(DetailMovieHasData(testMovieDetail));
      when(() => mockMovieRecommendationsBloc.state)
          .thenReturn(RecommendationMoviesHasData(testMovieList));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(InsertDataMovieToWatchlist(false));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect((watchlistButton), findsOneWidget);
    });
  });
}
