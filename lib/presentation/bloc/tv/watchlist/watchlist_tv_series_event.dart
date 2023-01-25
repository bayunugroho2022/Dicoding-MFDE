part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();
}

class LoadAllWatchlistTv extends WatchlistTvEvent {
  @override
  List<Object> get props => [];
}

class LoadWatchlistTv extends WatchlistTvEvent {
  final int id;

  LoadWatchlistTv(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  InsertWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DeleteWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  DeleteWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
