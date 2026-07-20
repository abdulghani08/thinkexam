import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firebase_auth_datasource.dart';
import '../../data/datasources/firestore_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth/check_user_authorized_usecase.dart';
import '../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../domain/usecases/auth/get_user_role_usecase.dart';
import '../../domain/usecases/auth/sign_in_with_google_usecase.dart';
import '../../domain/usecases/auth/sign_out_usecase.dart';

// Firebase Auth Data Source
final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(ref.watch(FirebaseProviders.firebaseAuthProvider));
});

// Firestore Auth Data Source
final firestoreAuthDataSourceProvider = Provider<FirestoreAuthDataSource>((
  ref,
) {
  return FirestoreAuthDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Auth Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    firebaseAuthDataSource: ref.watch(firebaseAuthDataSourceProvider),
    firestoreAuthDataSource: ref.watch(firestoreAuthDataSourceProvider),
  );
});

// Use Cases
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
});

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((
  ref,
) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
});

final getUserRoleUseCaseProvider = Provider<GetUserRoleUseCase>((ref) {
  return GetUserRoleUseCase(ref.watch(authRepositoryProvider));
});

final checkUserAuthorizedUseCaseProvider = Provider<CheckUserAuthorizedUseCase>(
  (ref) {
    return CheckUserAuthorizedUseCase(ref.watch(authRepositoryProvider));
  },
);
