import 'package:ditonton/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock/movie_mock.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUp(() {
    registerFallbackValue(MockMovieTopRatedEvent());
    registerFallbackValue(MockMovieTopRatedState());
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (_) => mockMovieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockMovieTopRatedBloc.close();
  });

  group('Movie - Top Rated', () {
    testWidgets('Page should display progressbar when loading',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedLoading());

      final viewProgress = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final listViewFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedError('Something went wrong'));

      final errorFinder = find.text('Something went wrong');
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(errorFinder, findsOneWidget);
    });
  });
}
