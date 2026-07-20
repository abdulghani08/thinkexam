/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => message;
}

/// Server exceptions
class ServerException extends AppException {
  const ServerException(super.message, {super.code});
}

/// Network exceptions
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}

/// Cache exceptions
class CacheException extends AppException {
  const CacheException(super.message, {super.code});
}

/// Authentication exceptions
class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

/// Validation exceptions
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}

/// Permission exceptions
class PermissionException extends AppException {
  const PermissionException(super.message, {super.code});
}

/// Not found exceptions
class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code});
}

/// Conflict exceptions
class ConflictException extends AppException {
  const ConflictException(super.message, {super.code});
}

/// Timeout exceptions
class TimeoutException extends AppException {
  const TimeoutException(super.message, {super.code});
}

/// Unknown exceptions
class UnknownException extends AppException {
  const UnknownException(super.message, {super.code});
}
