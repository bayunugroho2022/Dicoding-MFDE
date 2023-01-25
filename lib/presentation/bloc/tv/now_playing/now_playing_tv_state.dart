part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvEmpty extends NowPlayingTvState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvLoading extends NowPlayingTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class NowPlayingTvError extends NowPlayingTvState {
  String message;
  NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<Tv> result;

  NowPlayingTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
