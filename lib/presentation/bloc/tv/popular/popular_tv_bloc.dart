import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';

part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(PopularTvEmpty()) {
    on<LoadPopularTv>(
      (event, emit) async {
        emit(PopularTvLoading());

        final result = await _getPopularTv.execute();

        result.fold(
          (failure) {
            emit(PopularTvError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(PopularTvLoaded(data));
            } else {
              emit(PopularTvEmpty());
            }
          },
        );
      },
    );
  }
}
