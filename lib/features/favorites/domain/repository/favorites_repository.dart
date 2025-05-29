import 'package:castor_exam/core/resources/data_state.dart';

abstract class FavoritesRepository {
  Future<DataState<void>> addTrackToFavorites(String trackId);
  Future<DataState<void>> removeTrackFromFavorites(String trackId);
  Future<DataState<void>> addAlbumToFavorites(String albumId);
  Future<DataState<void>> removeAlbumFromFavorites(String albumId);
}
