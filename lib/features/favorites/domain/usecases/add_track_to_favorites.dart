import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/core/usecase/usecase.dart';
import 'package:castor_exam/features/favorites/domain/repository/favorites_repository.dart';

class AddTrackToFavoritesUseCase implements Usecase<DataState<void>, String> {
  final FavoritesRepository _repository;

  AddTrackToFavoritesUseCase(this._repository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _repository.addTrackToFavorites(params!);
  }
}
