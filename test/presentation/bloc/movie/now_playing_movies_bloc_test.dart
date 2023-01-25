import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  group('movie - now playing bloc test', () {

    test('initial state should be empty', () {
      expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
    });

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(LoadMovieNowPlaying()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        return LoadMovieNowPlaying().props;
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, Error] when get load is unsuccessful or Failed',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(LoadMovieNowPlaying()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingError('Server Failure'),
      ],
      verify: (bloc) => LoadMovieNowPlaying(),
    );
  });
}
