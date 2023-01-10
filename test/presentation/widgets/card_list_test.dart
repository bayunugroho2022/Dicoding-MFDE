import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../pages/movie/movie_detail_page_test.mocks.dart';
import '../pages/tv/tv_series_detail_page_test.mocks.dart';

void main() {
  late MockTvDetailNotifier mockTvDetailNotifier;
  late MockMovieDetailNotifier mockMovieDetailNotifier;

  setUp(() {
    mockMovieDetailNotifier = MockMovieDetailNotifier();
    mockTvDetailNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieDetailNotifier>.value(
          value: mockMovieDetailNotifier,
        ),
        ChangeNotifierProvider<TvDetailNotifier>.value(
          value: mockTvDetailNotifier,
        ),
      ],
      child: MaterialApp(
        home: Material(
          child: body,
        ),
      ),
    );
  }

  // test card list widget
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
