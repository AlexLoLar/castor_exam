import 'package:castor_exam/features/favorites/domain/usecases/add_album_to_favorites.dart';
import 'package:castor_exam/features/favorites/domain/usecases/add_track_to_favorites.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:castor_exam/core/error/failures.dart';
import 'package:castor_exam/core/resources/data_state.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AddTrackToFavoritesUseCase _addTrackToFavorites;
  final AddAlbumToFavoritesUseCase _addAlbumToFavorites;

  FavoritesBloc({
    required AddTrackToFavoritesUseCase addTrackToFavorites,
    required AddAlbumToFavoritesUseCase addAlbumToFavorites,
  })  : _addTrackToFavorites = addTrackToFavorites,
        _addAlbumToFavorites = addAlbumToFavorites,
        super(FavoritesInitial()) {
    on<AddTrackToFavoritesEvent>(_onAddTrack);
    on<AddAlbumToFavoritesEvent>(_onAddAlbum);
  }

  Future<void> _onAddTrack(
      AddTrackToFavoritesEvent event, Emitter<FavoritesState> emit) async {
    print('adreaafads');
    emit(FavoritesLoading());
    final result = await _addTrackToFavorites(params: event.trackId);
    switch (result) {
      case DataSuccess():
        emit(FavoritesSuccess());
      case DataFailed(failure: final failure):
        emit(FavoritesFailure(failure!));
    }
  }

  Future<void> _onAddAlbum(
      AddAlbumToFavoritesEvent event, Emitter<FavoritesState> emit) async {
    print('adfads');
    emit(FavoritesLoading());
    final result = await _addAlbumToFavorites(params: event.albumId);
    switch (result) {
      case DataSuccess():
        emit(FavoritesSuccess());
      case DataFailed(failure: final failure):
        emit(FavoritesFailure(failure!));
    }
  }
}
