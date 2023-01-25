import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/detail/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_series_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularTvEvent extends Fake implements PopularTvEvent {}

class MockPopularTvState extends Fake implements PopularTvState {}

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState> implements PopularTvBloc {}

class MockTopRatedTvEvent extends Fake implements TopRatedTvEvent {}

class MockTopRatedTvState extends Fake implements TopRatedTvState {}

class MockTopRatedTvBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState> implements TopRatedTvBloc {}

class MockNowPlayingTvEvent extends Fake implements NowPlayingTvEvent {}

class MockNowPlayingTvState extends Fake implements NowPlayingTvState {}

class MockNowPlayingTvBloc extends MockBloc<NowPlayingTvEvent, NowPlayingTvState> implements NowPlayingTvBloc {}

class MockDetailTvEvent extends Fake implements DetailTvEvent {}

class MockDetailTvState extends Fake implements DetailTvState {}

class MockDetailTvBloc extends MockBloc<DetailTvEvent, DetailTvState> implements DetailTvBloc {}

class MockRecommendationTvEvent extends Fake implements RecommendationTvEvent {}

class MockRecommendationTvState extends Fake implements RecommendationTvState {}

class MockRecommendationTvBloc extends MockBloc<RecommendationTvEvent, RecommendationTvState> implements RecommendationTvBloc {}

class MockWatchlistTvEvent extends Fake implements WatchlistTvEvent {}

class MockWatchlistTvState extends Fake implements WatchlistTvState {}

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState> implements WatchlistTvBloc {}


