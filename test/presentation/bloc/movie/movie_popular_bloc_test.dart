import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular/movie_popular_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  group('Movie - popular bloc test', () {
    test('initial state should be empty', () {
      expect(popularMoviesBloc.state, MoviePopularEmpty());
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(LoadMoviePopular()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
        return LoadMoviePopular().props;
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, Error] when get load is unsuccessful or Failed',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(LoadMoviePopular()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularError('Server Failure'),
      ],
      verify: (bloc) => MoviePopularLoading(),
    );
  });

}
