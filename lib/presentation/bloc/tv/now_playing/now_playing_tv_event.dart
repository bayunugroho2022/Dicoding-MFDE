part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvEvent extends Equatable {
  const NowPlayingTvEvent();
}

class LoadNowPlayingTv extends NowPlayingTvEvent {
  @override
  List<Object> get props => [];
}