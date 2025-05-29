import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> loginWithSpotify();
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<AuthEntity?> getStoredAuth();
}
