part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvEmpty extends PopularTvState {
  @override
  List<Object> get props => [];
}

class PopularTvLoading extends PopularTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class PopularTvError extends PopularTvState {
  String message;

  PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> result;

  PopularTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
