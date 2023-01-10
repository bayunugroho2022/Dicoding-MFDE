import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTVSeriesRepository);
  });

  final tId = 1;
  final tTv = <Tv>[];

  test('should get list of TV recommendations from the repository',
      () async {
    // arrange
    when(mockTVSeriesRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}
