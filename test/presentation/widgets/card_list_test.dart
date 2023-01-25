import 'package:ditonton/presentation/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/detail/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/dummy_objects.dart';
import '../pages/movie/mock/movie_mock.dart';
import '../pages/tv/mock/tv_mock.dart';

void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockRecommendationTvBloc mockRecommendationTvBloc;
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockRecommendationMoviesBloc mockMovieRecommendationsBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;


  setUp(() {
    registerFallbackValue(MockDetailTvEvent());
    registerFallbackValue(MockDetailTvState());
    mockDetailTvBloc = MockDetailTvBloc();

    registerFallbackValue(MockRecommendationTvEvent());
    registerFallbackValue(MockRecommendationTvState());
    mockRecommendationTvBloc = MockRecommendationTvBloc();

    registerFallbackValue(MockWatchlistTvEvent());
    registerFallbackValue(MockWatchlistTvState());
    mockWatchlistTvBloc = MockWatchlistTvBloc();

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
        BlocProvider<DetailTvBloc>(
          create: (_) => mockDetailTvBloc,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => mockRecommendationTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => mockWatchlistTvBloc,
        ),
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
    mockDetailTvBloc.close();
    mockRecommendationTvBloc.close();
    mockWatchlistTvBloc.close();
    mockDetailMovieBloc.close();
    mockMovieRecommendationsBloc.close();
    mockWatchlistMovieBloc.close();
  });

  testWidgets('CardList has a InkWell widget',
      (WidgetTester tester) async {

    // arrange
    final cardList = CardList(
      dataList: testMovieDetail,
    );

    // act
    await tester.pumpWidget(_makeTestableWidget(cardList));
    final inkWellFinder = find.byType(InkWell);

    //assert
    expect(inkWellFinder, findsOneWidget);
  });
}
