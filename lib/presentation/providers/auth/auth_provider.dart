import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/auth_providers.dart';
import '../../../core/logging/app_logger.dart';
import '../../../domain/entities/auth_user.dart';
import '../../../domain/entities/user_role.dart';
import '../../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../../domain/usecases/auth/get_user_role_usecase.dart';
import '../../../domain/usecases/auth/sign_in_with_google_usecase.dart';
import '../../../domain/usecases/auth/sign_out_usecase.dart';
import '../../../domain/usecases/base_usecase.dart';

/// Authentication state
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final AuthUser? user;
  final UserRole? userRole;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.userRole,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    UserRole? userRole,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      userRole: userRole ?? this.userRole,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isAdmin => userRole?.isAdmin ?? false;
  bool get isStudent => userRole?.isStudent ?? false;
}

/// Authentication provider
/// Manages authentication state and operations
class AuthNotifier extends StateNotifier<AuthState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetUserRoleUseCase _getUserRoleUseCase;

  AuthNotifier({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignOutUseCase signOutUseCase,
    required GetUserRoleUseCase getUserRoleUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _signInWithGoogleUseCase = signInWithGoogleUseCase,
       _signOutUseCase = signOutUseCase,
       _getUserRoleUseCase = getUserRoleUseCase,
       super(const AuthState());

  /// Initialize authentication state
  Future<void> initialize() async {
    AppLogger.i('Auth initialization started');
    state = state.copyWith(status: AuthStatus.loading);

    try {
      AppLogger.i('Getting current user...');
      final result = await _getCurrentUserUseCase(const NoParams()).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          AppLogger.e('Authentication check timed out');
          throw Exception('Authentication check timed out');
        },
      );

      result.fold(
        (failure) {
          AppLogger.e('Get current user failed: ${failure.message}');
          // Don't show error message for "no user signed in" - this is normal
          final shouldShowError = !failure.message.contains('No user is currently signed in');
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            errorMessage: shouldShowError ? failure.message : null,
          );
        },
        (user) async {
          AppLogger.i('Current user retrieved: ${user.email}');
          if (user.isAuthenticated) {
            AppLogger.i('User is authenticated, getting role...');
            // Get user role with timeout
            final roleResult = await _getUserRoleUseCase(
              GetUserRoleParams(userId: user.id, email: user.email),
            ).timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                AppLogger.e('User role check timed out');
                throw Exception('User role check timed out');
              },
            );

            roleResult.fold(
              (failure) {
                AppLogger.w('Failed to get user role: ${failure.message}');
                state = state.copyWith(
                  status: AuthStatus.authenticated,
                  user: user,
                  userRole: null,
                );
              },
              (role) {
                AppLogger.i('User role retrieved: ${role.role}');
                state = state.copyWith(
                  status: AuthStatus.authenticated,
                  user: user,
                  userRole: role,
                );
              },
            );
          } else {
            AppLogger.i('User is not authenticated');
            state = state.copyWith(status: AuthStatus.unauthenticated);
          }
        },
      );
    } catch (e) {
      AppLogger.e('Initialization failed: $e');
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Initialization failed: ${e.toString()}',
      );
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    final result = await _signInWithGoogleUseCase(const NoParams());

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (user) async {
        // Get user role after successful sign in
        final roleResult = await _getUserRoleUseCase(
          GetUserRoleParams(userId: user.id, email: user.email),
        );

        roleResult.fold(
          (failure) {
            state = state.copyWith(
              status: AuthStatus.authenticated,
              user: user,
              userRole: null,
            );
          },
          (role) {
            state = state.copyWith(
              status: AuthStatus.authenticated,
              user: user,
              userRole: role,
            );
          },
        );
      },
    );
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _signOutUseCase(const NoParams());

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (_) {
        state = const AuthState(
          status: AuthStatus.unauthenticated,
          user: null,
          userRole: null,
        );
      },
    );
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
    signInWithGoogleUseCase: ref.watch(signInWithGoogleUseCaseProvider),
    signOutUseCase: ref.watch(signOutUseCaseProvider),
    getUserRoleUseCase: ref.watch(getUserRoleUseCaseProvider),
  );
});
