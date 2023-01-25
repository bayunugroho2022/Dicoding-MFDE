import 'package:ditonton/presentation/bloc/movie/popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mock/movie_mock.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUp(() {
    registerFallbackValue(MockMoviePopularEvent());
    registerFallbackValue(MockMoviePopularState());
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (_) => mockMoviePopularBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() {
    mockMoviePopularBloc.close();
  });

  group('Movie - Popular', () {
    testWidgets('Page should display progressbar when loading',
        (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state).thenReturn(MoviePopularLoading());

      final viewProgress = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state).thenReturn(MoviePopularLoaded([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });
    
    testWidgets('Page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockMoviePopularBloc.state).thenReturn(MoviePopularError('Something went wrong'));

      final errorFinder = find.text('Something went wrong');

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(errorFinder, findsOneWidget);
    });
  });
}
