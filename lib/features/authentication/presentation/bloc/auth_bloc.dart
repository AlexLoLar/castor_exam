import 'package:castor_exam/features/authentication/domain/repository/auth_repository.dart';
import 'package:castor_exam/features/authentication/domain/usecases/is_login_spotify.dart';
import 'package:castor_exam/features/authentication/domain/usecases/logout_spotify.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_with_spotify.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithSpotify loginWithSpotify;
  final LogoutSpotify logoutSpotify;
  final IsLoginSpotify isLoginSpotify;
  final AuthRepository repository;

  AuthBloc(
      {required this.loginWithSpotify,
      required this.logoutSpotify,
      required this.isLoginSpotify,
      required this.repository})
      : super(AuthUnauthenticated()) {
    on<LoginWithSpotifyEvent>(_onLoginWithSpotify);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoginWithSpotify(
    LoginWithSpotifyEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final authEntity = await loginWithSpotify();
      emit(AuthAuthenticated(authEntity: authEntity));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await isLoginSpotify();
      if (isLoggedIn) {
        // Obtener los datos del usuario si es necesario
        final authEntity = await repository.getStoredAuth();
        if (authEntity != null) {
          emit(AuthAuthenticated(authEntity: authEntity));
          return;
        }
      }
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await logoutSpotify();
      emit(AuthUnauthenticated()); // Esto ya está correcto en tu código
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
