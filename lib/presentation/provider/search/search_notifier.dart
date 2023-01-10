import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies? searchMovies;
  final SearchTv? searchTv;

  SearchNotifier({this.searchMovies, this.searchTv});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Tv> _tvResult = [];

  List<Tv> get tvResult => _tvResult;

  List<Movie> _movieResult = [];

  List<Movie> get movieResult => _movieResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchMovieAndTvSearch(String query, String type) async {
    _state = RequestState.Loading;
    notifyListeners();

    final resultMovies = await searchMovies?.execute(query);
    final resultTv = await searchTv?.execute(query);

    if (type.contains("movie")) {
      resultMovies?.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          _movieResult = data;
          _state = RequestState.Loaded;
          notifyListeners();
        },
      );
    } else {
      resultTv?.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          _tvResult = data;
          _state = RequestState.Loaded;
          notifyListeners();
        },
      );
    }
  }
}
