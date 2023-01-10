import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/provider/search/search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_notifier_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchNotifier provider;
  late MockSearchTv mockSearchTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    provider = SearchNotifier(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvModel = Tv(
      backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
      firstAirDate: "2022-03-24",
      genreIds: [10759, 10765],
      id: 52814,
      name: "Halo",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Halo",
      overview:
          "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
      popularity: 7348.55,
      posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
      voteAverage: 8.7,
      voteCount: 472);
  final tTvList = <Tv>[tTvModel];
  final query = 'halo';

  group('search tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTv.execute(query)).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchMovieAndTvSearch(query, 'tv');
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should return list tv when data is gotten successfully', () async {
      // arrange
      when(mockSearchTv.execute(query)).thenAnswer((_) async => Right(tTvList));

      // act
      await provider.fetchMovieAndTvSearch(query, 'tv');
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTv.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieAndTvSearch(query, 'tv');
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
