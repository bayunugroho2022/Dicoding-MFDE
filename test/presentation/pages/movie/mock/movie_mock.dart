import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ditonton/presentation/bloc/movie/popular/movie_popular_bloc.dart';

class MockMoviePopularEvent extends Fake implements MoviePopularEvent {}

class MockMoviePopularState extends Fake implements MoviePopularState {}

class MockMoviePopularBloc extends MockBloc<MoviePopularEvent, MoviePopularState> implements MoviePopularBloc {}

class MockMovieTopRatedEvent extends Fake implements MovieTopRatedEvent {}

class MockMovieTopRatedState extends Fake implements MovieTopRatedState {}

class MockMovieTopRatedBloc extends MockBloc<MovieTopRatedEvent, MovieTopRatedState> implements MovieTopRatedBloc {}

class MockDetailMovieEvent extends Fake implements DetailMovieEvent {}

class MockDetailMovieState extends Fake implements DetailMovieState {}

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState> implements DetailMovieBloc {}

class MockWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

class MockWatchlistMovieState extends Fake implements WatchlistMovieState {}

class MockWatchlistMovieBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState> implements WatchlistMovieBloc {}

class MockRecommendationMoviesEvent extends Fake implements RecommendationMoviesEvent {}

class MockRecommendationMoviesState extends Fake implements RecommendationMoviesState {}

class MockRecommendationMoviesBloc extends MockBloc<RecommendationMoviesEvent, RecommendationMoviesState> implements RecommendationMoviesBloc {}

