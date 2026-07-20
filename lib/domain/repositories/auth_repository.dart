import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/auth_user.dart';
import '../entities/user_role.dart';
import 'base_repository.dart';

/// Authentication repository interface
/// Handles all authentication-related operations
abstract class AuthRepository extends BaseRepository {
  /// Get current authenticated user
  Future<Either<Failure, AuthUser>> getCurrentUser();

  /// Sign in with Google
  Future<Either<Failure, AuthUser>> signInWithGoogle();

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Get user role from Firestore
  Future<Either<Failure, UserRole>> getUserRole(String userId, {String? email});

  /// Check if user is authorized (role exists in database)
  Future<Either<Failure, bool>> isUserAuthorized(String userId, {String? email});
}
