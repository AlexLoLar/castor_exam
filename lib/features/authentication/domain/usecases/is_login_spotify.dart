import 'package:castor_exam/core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class IsLoginSpotify implements Usecase<bool, void> {
  final AuthRepository repository;

  IsLoginSpotify({required this.repository});

  @override
  Future<bool> call({void params}) async {
    return await repository.isLoggedIn();
  }
}
