import 'package:ditonton/presentation/bloc/tv/popular/popular_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mock/tv_mock.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    registerFallbackValue(MockPopularTvEvent());
    registerFallbackValue(MockPopularTvState());
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockPopularTvBloc.close();
  });

  group('TV - Popular', () {
    testWidgets('Page should display progressbar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());

      final viewProgress = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoaded([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvError('Error'));

      final errorFinder = find.text('Error');

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(errorFinder, findsOneWidget);
    });

    testWidgets('Page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvError('Error'));

      final errorFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(errorFinder, findsOneWidget);
    });
  });
}
