import 'package:ditonton/presentation/bloc/tv/detail/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'mock/tv_mock.dart';

void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockRecommendationTvBloc mockRecommendationTvBloc;
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    registerFallbackValue(MockDetailTvEvent());
    registerFallbackValue(MockDetailTvState());
    registerFallbackValue(MockRecommendationTvEvent());
    registerFallbackValue(MockRecommendationTvState());
    registerFallbackValue(MockWatchlistTvEvent());
    registerFallbackValue(MockWatchlistTvState());
    mockDetailTvBloc = MockDetailTvBloc();
    mockRecommendationTvBloc = MockRecommendationTvBloc();
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(
          create: (_) => mockDetailTvBloc,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => mockRecommendationTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => mockWatchlistTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockDetailTvBloc.close();
    mockRecommendationTvBloc.close();
    mockWatchlistTvBloc.close();
  });

  group('TV - detail TV', () {
    testWidgets(
        'Detail TV - Watchlist button should display add icon when tv show not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailTvBloc.state).thenReturn(DetailTvLoading());
      when(() => mockRecommendationTvBloc.state).thenReturn(RecommendationTvLoading());
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());

      final viewProgress = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Detail TV - Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockDetailTvBloc.state).thenReturn(DetailTvLoading());
      when(() => mockRecommendationTvBloc.state).thenReturn(RecommendationTvLoading());
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());

      final viewProgress = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Detail TV - Should display error message when failed to load data',
        (WidgetTester tester) async {
      when(() => mockDetailTvBloc.state).thenReturn(DetailTvError('Error'));
      when(() => mockRecommendationTvBloc.state)
          .thenReturn(RecommendationTvError('Error'));
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvError('Error'));

      final viewError = find.text('Error');

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(viewError, findsOneWidget);
    });
  });
}
