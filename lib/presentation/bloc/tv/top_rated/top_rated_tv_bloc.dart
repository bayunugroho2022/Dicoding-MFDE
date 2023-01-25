import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<LoadTopRatedTv>(
      (event, emit) async {
        emit(TopRatedTvLoading());

        final result = await _getTopRatedTv.execute();

        result.fold(
          (failure) {
            emit(TopRatedTvError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(TopRatedTvLoaded(data));
            } else {
              emit(TopRatedTvEmpty());
            }
          },
        );
      },
    );
  }
}
