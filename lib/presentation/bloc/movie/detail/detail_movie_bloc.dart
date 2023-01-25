import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_movie_state.dart';
part 'detail_movie_event.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()) {
    on<LoadDetailMovie>(
      (event, emit) async {
        final id = event.id;

        emit(DetailMovieLoading());
        final result = await _getMovieDetail.execute(id);
        result.fold(
          (failure) {
            emit(DetailMovieError(failure.message));
          },
          (data) {
            emit(DetailMovieHasData(data));
          },
        );
      },
    );
  }
}
