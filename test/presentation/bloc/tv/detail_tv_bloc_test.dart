import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/detail/detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  const tId = 1;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  group('Tv - detail tv bloc test', () {
    test('initial state should be empty', () {
      expect(detailTvBloc.state, DetailTvEmpty());
    });

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetailEntity));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(LoadDetailTv(tId)),
      expect: () => [
        DetailTvLoading(),
        DetailTvLoaded(testTVDetailEntity),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
        return LoadDetailTv(tId).props;
      },
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(LoadDetailTv(tId)),
      expect: () => [
        DetailTvLoading(),
        DetailTvError('Server Failure'),
      ],
      verify: (bloc) => DetailTvLoading(),
    );
  });
}
