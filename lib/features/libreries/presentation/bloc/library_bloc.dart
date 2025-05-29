// features/library/presentation/bloc/library_bloc.dart
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/libreries/data/models/library_album_model.dart';
import 'package:castor_exam/features/libreries/data/models/library_track_model.dart';
import 'package:castor_exam/features/libreries/domain/usecases/get_user_albums.dart';
import 'package:castor_exam/features/libreries/domain/usecases/get_user_tracks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:castor_exam/core/error/failures.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetUserTracksUseCase _getUserTracksUseCase;
  final GetUserAlbumsUseCase _getUserAlbumsUseCase;

  LibraryBloc({
    required GetUserTracksUseCase getUserTracksUseCase,
    required GetUserAlbumsUseCase getUserAlbumsUseCase,
  })  : _getUserTracksUseCase = getUserTracksUseCase,
        _getUserAlbumsUseCase = getUserAlbumsUseCase,
        super(LibraryInitial()) {
    on<LoadTracksEvent>(_onLoadTracks);
    on<LoadAlbumsEvent>(_onLoadAlbums);
  }

  Future<void> _onLoadTracks(
      LoadTracksEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    final result = await _getUserTracksUseCase();

    print(result.data);

    switch (result) {
      case DataSuccess(data: final tracks):
        emit(TracksLoaded(tracks!));
      case DataFailed(failure: final failure):
        emit(LibraryError(failure!));
    }
  }

  Future<void> _onLoadAlbums(
      LoadAlbumsEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    final result = await _getUserAlbumsUseCase();

    print(result.data);

    switch (result) {
      case DataSuccess(data: final albums):
        emit(AlbumsLoaded(albums!));
      case DataFailed(failure: final failure):
        emit(LibraryError(failure!));
    }
  }
}
