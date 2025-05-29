// features/library/domain/usecases/get_user_albums.dart
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/core/usecase/usecase.dart';
import 'package:castor_exam/features/libreries/data/models/library_album_model.dart';
import 'package:castor_exam/features/libreries/domain/repository/library_repository.dart';

class GetUserAlbumsUseCase
    implements Usecase<DataState<List<LibraryAlbumModel>>, void> {
  final LibraryRepository _libraryRepository;

  GetUserAlbumsUseCase(this._libraryRepository);

  @override
  Future<DataState<List<LibraryAlbumModel>>> call({void params}) {
    return _libraryRepository.getUserAlbums();
  }
}
