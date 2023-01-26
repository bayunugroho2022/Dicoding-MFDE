import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {

  test('should be a subclass of Tv entity', () async {
    // arrange
    final tv = Tv.watchlist(
      id: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      name: 'name',
    );

    // act
    // assert
    expect(tv, testTvWatchlist);
  });
}
