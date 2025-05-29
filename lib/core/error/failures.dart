abstract class Failure {
  final String message;
  final int? code;

  const Failure(this.message, [this.code]);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error', super.code]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String message = 'Unauthorized'])
      : super(message, 401);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}
