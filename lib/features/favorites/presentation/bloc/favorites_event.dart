part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddTrackToFavoritesEvent extends FavoritesEvent {
  final String trackId;

  const AddTrackToFavoritesEvent(this.trackId);

  @override
  List<Object> get props => [trackId];
}

class RemoveTrackFromFavoritesEvent extends FavoritesEvent {
  final String trackId;

  const RemoveTrackFromFavoritesEvent(this.trackId);

  @override
  List<Object> get props => [trackId];
}

// 🚀 Nuevos eventos para álbumes
class AddAlbumToFavoritesEvent extends FavoritesEvent {
  final String albumId;

  const AddAlbumToFavoritesEvent(this.albumId);

  @override
  List<Object> get props => [albumId];
}

class RemoveAlbumFromFavoritesEvent extends FavoritesEvent {
  final String albumId;

  const RemoveAlbumFromFavoritesEvent(this.albumId);

  @override
  List<Object> get props => [albumId];
}
