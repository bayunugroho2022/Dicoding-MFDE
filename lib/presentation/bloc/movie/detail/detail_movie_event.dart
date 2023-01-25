part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class LoadDetailMovie extends DetailMovieEvent {
  final int id;

  LoadDetailMovie(this.id);

  @override
  List<Object> get props => [];
}
