import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeEmpty extends HomeState {}

class HomeLoading extends HomeState {}

// ignore: must_be_immutable
class HomeLoaded extends HomeState {
  int index = 0;

  HomeLoaded(this.index);

  @override
  List<Object> get props => [index];
}
