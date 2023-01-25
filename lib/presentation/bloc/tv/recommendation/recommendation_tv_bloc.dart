import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(this._getTvRecommendations)
      : super(RecommendationTvEmpty()) {
    on<LoadRecommendationTv>(
      (event, emit) async {
        final id = event.id;
        emit(RecommendationTvLoading());

        final result = await _getTvRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(RecommendationTvError(failure.message));
          },
          (data) {
            if (data.isNotEmpty) {
              emit(RecommendationTvLoaded(data));
            } else {
              emit(RecommendationTvEmpty());
            }
          },
        );
      },
    );
  }
}
