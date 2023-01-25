import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });
  //
  group('Movie - watchlist bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(LoadAllWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return LoadAllWatchlistMovie().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(LoadAllWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('Movie - status watchlist bloc test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(LoadGotWatchlistMovie(testMovieDetail.id)),
      expect: () => [
        InsertDataMovieToWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        return LoadGotWatchlistMovie(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(LoadGotWatchlistMovie(testMovieDetail.id)),
      expect: () => [
        InsertDataMovieToWatchlist(false),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('Movie - add watchlist bloc test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieLoading(),
        MessageMovieWatchlist('Added to Watchlist'),
        InsertDataMovieToWatchlist(true)
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return InsertWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistMovie(testMovieDetail),
    );
  });

  group('Movie - delete watchlist bloc test', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        MessageMovieWatchlist('Delete to Watchlist'),
        InsertDataMovieToWatchlist(false)
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return DeleteWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistMovie(testMovieDetail),
    );
  });
}
