part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();

  @override
  List<Object> get props => [];
}

class DetailTvEmpty extends DetailTvState {
  @override
  List<Object> get props => [];
}

class DetailTvLoading extends DetailTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DetailTvError extends DetailTvState {
  String message;
  DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvLoaded extends DetailTvState {
  final TvDetail result;

  DetailTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
