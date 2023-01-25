import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/recommendation_movies_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetRecommendationMovies;

  const tId = 1;

  setUp(() {
    mockGetRecommendationMovies = MockGetMovieRecommendations();
    recommendationMoviesBloc = RecommendationMoviesBloc(mockGetRecommendationMovies);
  });

  group('Movie - recommendation movies bloc test', () {

    test('initial state should be empty', () {
      expect(recommendationMoviesBloc.state, RecommendationMoviesEmpty());
    });

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(LoadRecommendationMovies(tId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationMovies.execute(tId));
        return LoadRecommendationMovies(tId).props;
      },
    );

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetRecommendationMovies.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(LoadRecommendationMovies(tId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationMovies.execute(tId));
        return LoadRecommendationMovies(tId).props;
      },
    );
  });

}
