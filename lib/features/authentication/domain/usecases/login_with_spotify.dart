import 'package:castor_exam/core/usecase/usecase.dart';
import 'package:castor_exam/features/authentication/domain/entities/auth_entity.dart';
import '../repository/auth_repository.dart';

class LoginWithSpotify implements Usecase<AuthEntity, void> {
  final AuthRepository repository;

  LoginWithSpotify({required this.repository});

  @override
  Future<AuthEntity> call({void params}) async {
    return await repository.loginWithSpotify();
  }
}
