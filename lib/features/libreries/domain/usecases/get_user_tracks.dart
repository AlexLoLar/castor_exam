// features/library/domain/usecases/get_user_tracks.dart
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/core/usecase/usecase.dart';
import 'package:castor_exam/features/libreries/data/models/library_track_model.dart';
import 'package:castor_exam/features/libreries/domain/repository/library_repository.dart';

class GetUserTracksUseCase
    implements Usecase<DataState<List<LibraryTrackModel>>, void> {
  final LibraryRepository _libraryRepository;

  GetUserTracksUseCase(this._libraryRepository);

  @override
  Future<DataState<List<LibraryTrackModel>>> call({void params}) {
    return _libraryRepository.getUserTracks();
  }
}
