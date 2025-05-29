/// Excepciones personalizadas para la aplicación
class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  @override
  String toString() => 'AppException: $message';
}

/// Excepción para errores de servidor (500, 404, etc.)
class ServerException extends AppException {
  const ServerException([super.message = 'Server error', super.stackTrace]);
}

/// Excepción para errores de red (timeout, no conexión)
class NetworkException extends AppException {
  const NetworkException([super.message = 'Network error', super.stackTrace]);
}

/// Excepción para errores de autenticación (401, 403)
class UnauthorizedException extends AppException {
  const UnauthorizedException(
      [super.message = 'Unauthorized', super.stackTrace]);
}

/// Excepción para datos no encontrados (404)
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Not found', super.stackTrace]);
}

/// Excepción para errores de caché
class CacheException extends AppException {
  const CacheException([super.message = 'Cache error', super.stackTrace]);
}

/// Excepción para datos inválidos
class InvalidDataException extends AppException {
  const InvalidDataException(
      [super.message = 'Invalid data', super.stackTrace]);
}

/// Excepción para límites de tasa excedidos (429)
class RateLimitException extends AppException {
  final Duration? retryAfter;

  const RateLimitException({
    String message = 'Rate limit exceeded',
    this.retryAfter,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

/// Excepción para tiempo de espera agotado
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Request timeout', super.stackTrace]);
}

/// Excepción para cuando no hay datos disponibles
class NoDataException extends AppException {
  const NoDataException(
      [super.message = 'No data available', super.stackTrace]);
}
