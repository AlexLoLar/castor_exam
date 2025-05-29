import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthEntity authEntity;
  AuthAuthenticated({required this.authEntity});
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
