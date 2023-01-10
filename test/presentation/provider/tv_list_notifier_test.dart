import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListNotifier provider;
  late MockGetNowPlayingTv mockGetNowPlayingTV;
  late MockGetPopularTv mockGetPopularTV;
  late MockGetTopRatedTv mockGetTopRatedTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTV = MockGetNowPlayingTv();
    mockGetPopularTV = MockGetPopularTv();
    mockGetTopRatedTV = MockGetTopRatedTv();
    provider = TvListNotifier(
      getNowPlayingTv: mockGetNowPlayingTV,
      getPopularTv: mockGetPopularTV,
      getTopRatedTv: mockGetTopRatedTV,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeries = Tv(
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
  final tTVSeriesList = <Tv>[tTVSeries];

  group('now playing TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchNowPlayingTv();
      // assert
      verify(mockGetNowPlayingTV.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTv, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change TV Series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTv, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loading);
    });

    test('should change TV Series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loaded);
      expect(provider.topRatedTv, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
