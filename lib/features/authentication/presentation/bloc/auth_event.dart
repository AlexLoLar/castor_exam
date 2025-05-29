abstract class AuthEvent {}

class LoginWithSpotifyEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
