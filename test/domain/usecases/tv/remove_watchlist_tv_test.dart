import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(mockTvRepository);
  });

  test('should remove watchlist tv  from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTVDetailEntity))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetailEntity);
    // assert
    verify(mockTvRepository.removeWatchlist(testTVDetailEntity));
    expect(result, Right('Removed from watchlist'));
  });
}
