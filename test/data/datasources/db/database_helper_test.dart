import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late DatabaseHelper databaseHelper;
  setUp(() async {
    databaseHelper = MockDatabaseHelper();
  });

  group('Test Database Helper', () {
    test('databaseHelper should not be null', () {
      expect(databaseHelper, isNotNull);
    });

    // test insert watchlist
    test('insert watchlist should return true', () async {
      // arrange
      when(databaseHelper.insertWatchlist(MovieTable(
              id: 1,
              title: 'title',
              overview: 'overview',
              posterPath: 'posterPath')))
          .thenAnswer((_) async => 1);

      // act
      final result = await databaseHelper.insertWatchlist(MovieTable(
          id: 1,
          title: 'title',
          overview: 'overview',
          posterPath: 'posterPath'));

      // assert
      expect(result, 1);
    });

    // test remove watchlist
    test('remove watchlist should return true', () async {
      // arrange
      when(databaseHelper.removeWatchlist(MovieTable(
              id: 1,
              title: 'title',
              overview: 'overview',
              posterPath: 'posterPath')))
          .thenAnswer((_) async => 1);

      // act
      final result = await databaseHelper.removeWatchlist(MovieTable(
          id: 1,
          title: 'title',
          overview: 'overview',
          posterPath: 'posterPath'));

      // assert
      expect(result, 1);
    });
  });
}
