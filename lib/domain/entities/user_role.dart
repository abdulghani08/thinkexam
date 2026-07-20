import 'package:equatable/equatable.dart';
import 'base_entity.dart';

/// User role entity
/// Represents the role of a user in the system (ADMIN or STUDENT)
class UserRole extends BaseEntity {
  final String id;
  final String userId;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserRole({
    required this.id,
    required this.userId,
    required this.role,
    this.createdAt,
    this.updatedAt,
  });

  /// Check if user is admin (teacher/administrator)
  bool get isAdmin => role == 'ADMIN';

  /// Check if user is student
  bool get isStudent => role == 'STUDENT';

  @override
  List<Object?> get props => [id, userId, role, createdAt, updatedAt];
}