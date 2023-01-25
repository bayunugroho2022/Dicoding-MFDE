part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {
  @override
  List<Object> get props => [];
}

class TopRatedTvLoading extends TopRatedTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TopRatedTvError extends TopRatedTvState {
  String message;

  TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> result;

  TopRatedTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
