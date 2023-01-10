import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTvDetail(mockTVRepository);
  });

  final tId = 1;

  test('should get TV detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTVDetailEntity));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVDetailEntity));
  });
}
