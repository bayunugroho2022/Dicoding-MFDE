import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_event.dart';

part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _getOnTheAirTv;

  NowPlayingTvBloc(this._getOnTheAirTv) : super(NowPlayingTvEmpty()) {
    on<LoadNowPlayingTv>(
      (event, emit) async {
        emit(NowPlayingTvLoading());

        final result = await _getOnTheAirTv.execute();

        result.fold(
          (failure) {
            emit(NowPlayingTvError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(NowPlayingTvLoaded(data));
            } else {
              emit(NowPlayingTvEmpty());
            }
          },
        );
      },
    );
  }
}
