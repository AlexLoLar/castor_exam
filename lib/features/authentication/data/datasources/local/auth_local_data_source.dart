import 'package:castor_exam/features/authentication/domain/entities/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:castor_exam/features/authentication/data/models/auth_model.dart';

class AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSource({required this.prefs});

  Future<void> saveAuthData(AuthModel authModel) async {
    await prefs.setString('access_token', authModel.accessToken);
    await prefs.setString('refresh_token', authModel.refreshToken);
    await prefs.setString('expires_at', authModel.expiresAt.toIso8601String());
  }

  Future<AuthEntity?> getAuthData() async {
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');
    final expiresAt = prefs.getString('expires_at');

    if (accessToken == null || refreshToken == null || expiresAt == null) {
      return null;
    }

    return AuthEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: DateTime.parse(expiresAt),
    );
  }

  Future<bool> isLoggedIn() async {
    final authData = await getAuthData();
    if (authData == null) return false;
    return authData.expiresAt.isAfter(DateTime.now());
  }

  Future<void> clearAuthData() async {
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('expires_at');
  }
}
