import 'base_entity.dart';

/// An administrator profile stored in the Firestore teachers collection.
class Teacher extends BaseEntity {
  final String id;
  final String fullName;
  final String email;
  final String? photoUrl;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  const Teacher({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoUrl,
    this.role = 'ADMIN',
    this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  Teacher copyWith({
    String? fullName,
    String? email,
    String? photoUrl,
    bool? isActive,
    DateTime? updatedAt,
  }) {
    return Teacher(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    photoUrl,
    role,
    createdAt,
    updatedAt,
    isActive,
  ];
}
