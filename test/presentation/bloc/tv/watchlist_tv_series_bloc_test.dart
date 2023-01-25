import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTv,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    watchlistTvBloc = WatchlistTvBloc(
      mockGetWatchlistTv,
      mockGetWatchListStatusTv,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  group('TV - watchlist bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistTvBloc.state, WatchlistTvEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(LoadAllWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvLoaded(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
        return LoadAllWatchlistTv().props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(LoadAllWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvLoading(),
    );
  });

  group('TV - add watchlist TV  bloc test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockSaveWatchlistTv.execute(testTVDetailResponseEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistTv(testTVDetailResponseEntity)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistTv(testTVDetailResponseEntity),
    );
  });

  group('TV - status watchlist TV bloc test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockGetWatchListStatusTv.execute(testTVModel.id))
            .thenAnswer((_) async => false);

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistTv(testTVModel.id!)),
      expect: () => [
        WatchlistTvLoading(),
        InsertDataTvToWatchlist(false),
      ],
      verify: (bloc) => WatchlistTvLoading(),
    );
  });

  group('TV - delete watchlist TV  bloc test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is successfully',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTVDetailResponseEntity))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTv(testTVDetailResponseEntity)),
      expect: () => [
        WatchlistTvLoading(),
        MessageTvWatchlist('Delete to Watchlist'),
        InsertDataTvToWatchlist(false)
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTVDetailResponseEntity));
        return DeleteWatchlistTv(testTVDetailResponseEntity).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTVDetailResponseEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTv(testTVDetailResponseEntity)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistTv(testTVDetailResponseEntity),
    );
  });
}
