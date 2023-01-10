import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = SaveWatchlistTv(mockTVRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTVRepository.saveWatchlist(testTVDetailEntity))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetailEntity);
    // assert
    verify(mockTVRepository.saveWatchlist(testTVDetailEntity));
    expect(result, Right('Added to Watchlist'));
  });
}
