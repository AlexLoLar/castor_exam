import 'package:castor_exam/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:castor_exam/features/authentication/domain/entities/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/remote/spotify_auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SpotifyAuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthEntity> loginWithSpotify() async {
    final code = await remoteDataSource.getAuthorizationCode();
    final authModel = await remoteDataSource.getAccessToken(code);

    await localDataSource.saveAuthData(authModel);

    return AuthEntity(
      accessToken: authModel.accessToken,
      refreshToken: authModel.refreshToken,
      expiresAt: authModel.expiresAt,
    );
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearAuthData();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<AuthEntity?> getStoredAuth() async {
    final authModel = await localDataSource.getAuthData();
    if (authModel == null) return null;
    return AuthEntity(
      accessToken: authModel.accessToken,
      refreshToken: authModel.refreshToken,
      expiresAt: authModel.expiresAt,
    );
  }
}
