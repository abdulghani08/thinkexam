import 'package:equatable/equatable.dart';

/// Base failure class for all failures
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Server failures
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

/// Network failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

/// Cache failures
class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.code});
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

/// Conflict failures
class ConflictFailure extends Failure {
  const ConflictFailure(super.message, {super.code});
}

/// Timeout failures
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message, {super.code});
}

/// Unknown failures
class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.code});
}
