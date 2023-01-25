import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()){
    on<LoadMoviePopular>((event, emit) async {
      emit(MoviePopularLoading());

      final result = await _getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          if (data.isNotEmpty) {
            emit(MoviePopularLoaded(data));
          } else {
            emit(MoviePopularLoading());
          }
        },
      );
    });
  }

}