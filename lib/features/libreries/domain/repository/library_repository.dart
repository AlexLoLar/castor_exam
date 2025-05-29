// features/library/domain/repository/library_repository.dart
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/libreries/data/models/library_album_model.dart';
import 'package:castor_exam/features/libreries/data/models/library_track_model.dart';

abstract class LibraryRepository {
  Future<DataState<List<LibraryTrackModel>>> getUserTracks();
  Future<DataState<List<LibraryAlbumModel>>> getUserAlbums();
}
