import 'package:equatable/equatable.dart';
import 'base_entity.dart';

/// Authentication user entity
/// Represents the authenticated user from Firebase Auth
class AuthUser extends BaseEntity {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool? isEmailVerified;

  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isEmailVerified,
  });

  /// Check if user is authenticated
  bool get isAuthenticated => id.isNotEmpty;

  /// Create empty/unauthenticated user
  static const empty = AuthUser(id: '', email: '');

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    photoUrl,
    phoneNumber,
    isEmailVerified,
  ];
}
