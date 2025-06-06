part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchResultEntity results;

  const SearchLoaded(this.results);

  @override
  List<Object> get props => [results];
}

class SearchError extends SearchState {
  final Failure failure;

  const SearchError(this.failure);

  @override
  List<Object> get props => [failure];
}
