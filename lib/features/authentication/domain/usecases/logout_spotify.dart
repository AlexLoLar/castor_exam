import 'package:castor_exam/core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LogoutSpotify implements Usecase<void, void> {
  final AuthRepository repository;

  LogoutSpotify({required this.repository});

  @override
  Future<void> call({void params}) async {
    return await repository.logout();
  }
}
