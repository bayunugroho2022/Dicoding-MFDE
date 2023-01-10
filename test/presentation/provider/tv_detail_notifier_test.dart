import 'package:dartz/dartz.dart';

import 'package:ditonton/common/failure.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late MockTvRepository mockTVRepository;
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTVDetail;
  late MockGetTvRecommendations mockGetTVRecommendations;
  late GetWatchListStatusTv mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockTVRepository = MockTvRepository();
    mockGetTVDetail = MockGetTvDetail();
    mockGetTVRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = GetWatchListStatusTv(mockTVRepository);
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTVDetail,
      getTvRecommendations: mockGetTVRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;

  final tATVSeries = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );
  final tTVSeries = <Tv>[tATVSeries];

  void _arrangeUsecase() {
    when(mockGetTVDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetailEntity));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTVSeries));
  }

  group('Get TV Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTVDetail.execute(tId));
      verify(mockGetTVRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTVDetailEntity);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation TV Series when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvDetail(tId);
          // assert
          expect(provider.tvState, RequestState.Loaded);
          expect(provider.tvRecommendations, tTVSeries);
        });
  });

  group('Get TV Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTVRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTVSeries);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.tvRecommendations, tTVSeries);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetailEntity));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetailEntity))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetailEntity);
      // assert
      verify(mockSaveWatchlist.execute(testTVDetailEntity));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTVDetailEntity))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTVDetailEntity);
      // assert
      verify(mockRemoveWatchlist.execute(testTVDetailEntity));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetailEntity))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetailEntity);
      // assert
      verify(mockGetWatchlistStatus.execute(testTVSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetailEntity))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTVDetailEntity);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVSeries));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
