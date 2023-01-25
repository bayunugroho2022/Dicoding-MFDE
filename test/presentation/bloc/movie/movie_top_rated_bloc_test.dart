import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  group('Movie - top rated bloc test', () {
    test('initial state should be empty', () {
      expect(topRatedMoviesBloc.state, MovieTopRatedEmpty());
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(LoadMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
        return LoadMovieTopRated().props;
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(LoadMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedError('Server Failure'),
      ],
      verify: (bloc) => MovieTopRatedLoading(),
    );
  });
}
