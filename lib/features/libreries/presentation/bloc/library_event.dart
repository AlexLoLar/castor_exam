// features/library/presentation/bloc/library_event.dart
part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LoadTracksEvent extends LibraryEvent {}

class LoadAlbumsEvent extends LibraryEvent {}
