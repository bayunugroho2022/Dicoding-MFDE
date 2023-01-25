part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();
}

class LoadRecommendationMovies extends RecommendationMoviesEvent {
  final int id;

  LoadRecommendationMovies(this.id);

  @override
  List<Object> get props => [];
}
