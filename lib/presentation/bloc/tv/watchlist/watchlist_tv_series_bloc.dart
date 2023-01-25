import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getDataWatchlistTv;
  final GetWatchListStatusTv _getDataTvWatchListStatus;
  final SaveWatchlistTv _saveTvFromWatchlist;
  final RemoveWatchlistTv _deleteTvFromWatchlist;

  WatchlistTvBloc(this._getDataWatchlistTv, this._getDataTvWatchListStatus,
      this._saveTvFromWatchlist, this._deleteTvFromWatchlist)
      : super(WatchlistTvEmpty()) {
    on<LoadAllWatchlistTv>(
      (event, emit) async {
        emit(WatchlistTvLoading());

        final result = await _getDataWatchlistTv.execute();

        result.fold(
          (failure) {
            emit(WatchlistTvError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(WatchlistTvLoaded(data));
            } else {
              emit(WatchlistTvEmpty());
            }
          },
        );
      },
    );
    on<LoadWatchlistTv>(
      (event, emit) async {
        emit(WatchlistTvLoading());
        final id = event.id;

        final result = await _getDataTvWatchListStatus.execute(id);
        emit(InsertDataTvToWatchlist(result));
      },
    );
    on<InsertWatchlistTv>(
      (event, emit) async {
        emit(WatchlistTvLoading());

        final tvSeries = event.tvDetail;

        final result = await _saveTvFromWatchlist.execute(tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTvError(failure.message));
          },
          (message) {
            emit(MessageTvWatchlist(message));
            emit(InsertDataTvToWatchlist(true));
          },
        );
      },
    );
    on<DeleteWatchlistTv>(
      (event, emit) async {
        emit(WatchlistTvLoading());

        final tvSeries = event.tvDetail;

        final result = await _deleteTvFromWatchlist.execute(tvSeries);

        result.fold(
          (failure) {
            emit(WatchlistTvError(failure.message));
          },
          (message) {
            emit(MessageTvWatchlist(message));
            emit(InsertDataTvToWatchlist(false));
          },
        );
      },
    );
  }
}
