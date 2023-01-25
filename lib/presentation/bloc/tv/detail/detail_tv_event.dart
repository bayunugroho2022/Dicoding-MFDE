part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();
}

class LoadDetailTv extends DetailTvEvent {
  final int id;

  LoadDetailTv(this.id);

  @override
  List<Object> get props => [];
}
