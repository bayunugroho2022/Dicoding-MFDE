part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();
}

class RecommendationTvEmpty extends RecommendationTvState {
  @override
  List<Object> get props => [];
}

class RecommendationTvLoading extends RecommendationTvState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class RecommendationTvError extends RecommendationTvState {
  String message;
  RecommendationTvError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationTvLoaded extends RecommendationTvState {
  final List<Tv> result;

  RecommendationTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
