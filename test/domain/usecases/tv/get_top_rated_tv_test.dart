import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTVRepository);
  });

  final tTV = <Tv>[];

  test('should get list of TV  from repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTV));
  });
}
