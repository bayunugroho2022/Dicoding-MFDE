import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/now_playing_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'mock/tv_mock.dart';

void main() {
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;

  setUp(() {
    registerFallbackValue(MockNowPlayingTvEvent());
    registerFallbackValue(MockNowPlayingTvState());
    mockNowPlayingTvBloc = MockNowPlayingTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvBloc>(
      create: (_) => mockNowPlayingTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockNowPlayingTvBloc.close();
  });

  group('TV - Now Playing ', () {
    testWidgets('Page should display progressbar when loading',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(NowPlayingTvLoading());

      final viewProgress = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(viewProgress, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(NowPlayingTvLoaded([]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    //error
    testWidgets('Page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(NowPlayingTvError('Error'));

      final errorFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

      expect(errorFinder, findsOneWidget);
    });

  });
}
