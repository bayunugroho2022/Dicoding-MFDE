part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();
}

class LoadRecommendationTv extends RecommendationTvEvent {
  final int id;

  LoadRecommendationTv(this.id);

  @override
  List<Object> get props => [];
}
