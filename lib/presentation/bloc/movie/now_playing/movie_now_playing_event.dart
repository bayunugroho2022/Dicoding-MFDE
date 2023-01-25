part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();
}

class LoadMovieNowPlaying extends MovieNowPlayingEvent {
  @override
  List<Object?> get props => [];
}