part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {}

class FavoritesFailure extends FavoritesState {
  final Failure failure;

  const FavoritesFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
