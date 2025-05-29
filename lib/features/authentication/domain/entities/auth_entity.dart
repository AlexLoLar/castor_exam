import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, expiresAt];
}
