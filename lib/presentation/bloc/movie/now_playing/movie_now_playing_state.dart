part of 'movie_now_playing_bloc.dart';

class MovieNowPlayingState extends Equatable{
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingEmpty extends MovieNowPlayingState {
  @override
  List<Object> get props => [];
}

class MovieNowPlayingLoading extends MovieNowPlayingState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class MovieNowPlayingError extends MovieNowPlayingState {
  String message;
  MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> result;

  MovieNowPlayingLoaded(this.result);

  @override
  List<Object> get props => [result];
}
