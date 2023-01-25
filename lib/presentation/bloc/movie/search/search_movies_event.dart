part of 'search_movies_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedMovie extends SearchEvent {
  final String query;

  OnQueryChangedMovie(this.query);

  @override
  List<Object> get props => [query];
}
