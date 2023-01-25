import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/home/home_bloc.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:ditonton/presentation/bloc/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  group('Home bloc test', () {
    test('initial state should be empty', () {
      expect(homeBloc.state, HomeEmpty());
    });

    blocTest<HomeBloc, HomeState>(
      'Should emit [HomeLoaded] when data is successfully',
      build: () => homeBloc,
      act: (bloc) => bloc.add(OnPageChanged(0)),
      expect: () => [
        HomeLoaded(0),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Should emit [HomeLoaded] when data is successfully',
      build: () => homeBloc,
      act: (bloc) => bloc.add(OnPageChanged(0)),
      expect: () => [
        HomeLoaded(0),
      ],
      verify: (bloc) {
        expect(bloc.state.props, [0]);
        return OnPageChanged(0).props;
      },
    );

  });
}
