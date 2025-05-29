import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/core/usecase/usecase.dart';
import 'package:castor_exam/features/favorites/domain/repository/favorites_repository.dart';

class AddAlbumToFavoritesUseCase implements Usecase<DataState<void>, String> {
  final FavoritesRepository _repository;

  AddAlbumToFavoritesUseCase(this._repository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _repository.addAlbumToFavorites(params!);
  }
}
