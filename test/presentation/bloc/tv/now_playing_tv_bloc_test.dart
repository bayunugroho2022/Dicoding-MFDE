import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  group('tv - now playing bloc test', () {
    test('initial state should be empty', () {
      expect(nowPlayingTvBloc.state, NowPlayingTvEmpty());
    });

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTv()),
      expect: () => [
        NowPlayingTvLoading(),
        NowPlayingTvLoaded(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
        return LoadNowPlayingTv().props;
      },
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit [Loading, Error] when get load is unsuccessful or Failed',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTv()),
      expect: () => [
        NowPlayingTvLoading(),
        NowPlayingTvError('Server Failure'),
      ],
      verify: (bloc) => LoadNowPlayingTv(),
    );
  });
}
