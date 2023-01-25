part of 'movie_top_rated_bloc.dart';

class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedEmpty extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}

class MovieTopRatedLoading extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class MovieTopRatedError extends MovieTopRatedState {
  String message;
  MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}