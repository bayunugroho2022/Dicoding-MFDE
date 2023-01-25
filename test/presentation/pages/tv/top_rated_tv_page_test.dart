import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'mock/tv_mock.dart';

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    registerFallbackValue(MockTopRatedTvEvent());
    registerFallbackValue(MockTopRatedTvState());
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockTopRatedTvBloc.close();
  });

  group('TV - Top Rated ', () {
    testWidgets('Page should display progressbar when loading',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

      final viewProgress = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoaded([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvError('error'));

      final errorFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(errorFinder, findsOneWidget);
    });

  });
}
