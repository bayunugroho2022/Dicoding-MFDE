import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation/recommendation_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
    late RecommendationTvBloc bloc;
    late GetTvRecommendations mockTvRepository;

    setUp(() {
      mockTvRepository = MockGetTvRecommendations();
      bloc = RecommendationTvBloc(mockTvRepository);
    });

    group('Tv - recommendation bloc test', () {
      test('initial state should be empty', () {
        expect(bloc.state, RecommendationTvEmpty());
      });

      blocTest<RecommendationTvBloc, RecommendationTvState>(
        'Should emit [Loading, Loaded] when data is successfully',
        build: () {
          when(mockTvRepository.execute(1))
              .thenAnswer((_) async => Right(testTvList));
          return bloc;
        },
        act: (bloc) => bloc.add(LoadRecommendationTv(1)),
        expect: () => [
          RecommendationTvLoading(),
          RecommendationTvLoaded(testTvList),
        ],
        verify: (bloc) {
          verify(mockTvRepository.execute(1));
          return LoadRecommendationTv(1).props;
        },
      );

      blocTest<RecommendationTvBloc, RecommendationTvState>(
        'Should emit [Loading, Error] when is unsuccessful',
        build: () {
          when(mockTvRepository.execute(1))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(LoadRecommendationTv(1)),
        expect: () => [
          RecommendationTvLoading(),
          RecommendationTvError('Server Failure'),
        ],
        verify: (bloc) => RecommendationTvLoading(),
      );
    });
}
