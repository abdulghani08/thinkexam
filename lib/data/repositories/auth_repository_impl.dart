import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';
import '../datasources/firestore_auth_datasource.dart';
import 'base_repository_impl.dart';

/// Authentication repository implementation
class AuthRepositoryImpl extends BaseRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  final FirestoreAuthDataSource firestoreAuthDataSource;

  AuthRepositoryImpl({
    required this.firebaseAuthDataSource,
    required this.firestoreAuthDataSource,
  });

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser() async {
    try {
      final user = await firebaseAuthDataSource.getCurrentUser();

      if (user == null) {
        return const Left(AuthFailure('No user is currently signed in'));
      }

      final authUser = AuthUser(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
        phoneNumber: user.phoneNumber,
        isEmailVerified: user.emailVerified,
      );

      return Right(authUser);
    } on AuthException catch (e) {
      AppLogger.e('Auth exception in getCurrentUser: $e');
      return Left(AuthFailure(e.message, code: e.code));
    } on ServerException catch (e) {
      AppLogger.e('Server exception in getCurrentUser: $e');
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      AppLogger.e('Unknown exception in getCurrentUser: $e');
      return Left(UnknownFailure('Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithGoogle() async {
    try {
      final userCredential = await firebaseAuthDataSource.signInWithGoogle();
      final user = userCredential.user;

      if (user == null) {
        return const Left(AuthFailure('Sign in failed: No user returned'));
      }

      final authUser = AuthUser(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
        phoneNumber: user.phoneNumber,
        isEmailVerified: user.emailVerified,
      );

      return Right(authUser);
    } on AuthException catch (e) {
      AppLogger.e('Auth exception in signInWithGoogle: $e');
      return Left(AuthFailure(e.message, code: e.code));
    } on ServerException catch (e) {
      AppLogger.e('Server exception in signInWithGoogle: $e');
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      AppLogger.e('Unknown exception in signInWithGoogle: $e');
      return Left(UnknownFailure('Failed to sign in with Google'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuthDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      AppLogger.e('Auth exception in signOut: $e');
      return Left(AuthFailure(e.message, code: e.code));
    } on ServerException catch (e) {
      AppLogger.e('Server exception in signOut: $e');
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      AppLogger.e('Unknown exception in signOut: $e');
      return Left(UnknownFailure('Failed to sign out'));
    }
  }

  @override
  Future<Either<Failure, UserRole>> getUserRole(String userId, {String? email}) async {
    try {
      final role = await firestoreAuthDataSource.getUserRole(userId, email: email);

      if (role == null) {
        return const Left(NotFoundFailure('User role not found'));
      }

      return Right(role);
    } on ServerException catch (e) {
      AppLogger.e('Server exception in getUserRole: $e');
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      AppLogger.e('Unknown exception in getUserRole: $e');
      return Left(UnknownFailure('Failed to get user role'));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserAuthorized(String userId, {String? email}) async {
    try {
      final isAuthorized = await firestoreAuthDataSource.isUserAuthorized(
        userId,
        email: email,
      );
      return Right(isAuthorized);
    } on ServerException catch (e) {
      AppLogger.e('Server exception in isUserAuthorized: $e');
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      AppLogger.e('Unknown exception in isUserAuthorized: $e');
      return Left(UnknownFailure('Failed to check user authorization'));
    }
  }
}
