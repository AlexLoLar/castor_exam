import 'package:castor_exam/features/authentication/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel(
    String accessToken,
    String refreshToken,
    DateTime expiresAt,
  ) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      json['access_token'],
      json['refresh_token'],
      DateTime.now().add(
        Duration(seconds: json['expires_in']),
      ),
    );
  }
}
