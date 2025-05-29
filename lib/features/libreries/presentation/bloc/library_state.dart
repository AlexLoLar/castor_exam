// features/library/presentation/bloc/library_state.dart
part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class TracksLoaded extends LibraryState {
  final List<LibraryTrackModel> tracks;

  const TracksLoaded(this.tracks);

  @override
  List<Object> get props => [tracks];
}

class AlbumsLoaded extends LibraryState {
  final List<LibraryAlbumModel> albums;

  const AlbumsLoaded(this.albums);

  @override
  List<Object> get props => [albums];
}

class LibraryError extends LibraryState {
  final Failure failure;

  const LibraryError(this.failure);

  @override
  List<Object> get props => [failure];
}
