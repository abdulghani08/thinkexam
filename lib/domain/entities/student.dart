import 'base_entity.dart';

class Student extends BaseEntity {
  final String id;
  final String fullName;
  final String email;
  final String? studentNumber;
  final String classId;
  final String? photoUrl;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Student({
    required this.id,
    required this.fullName,
    required this.email,
    this.studentNumber,
    required this.classId,
    this.photoUrl,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  Student copyWith({
    String? fullName,
    String? email,
    String? studentNumber,
    String? classId,
    String? photoUrl,
    bool? isActive,
    DateTime? updatedAt,
  }) => Student(
    id: id,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    studentNumber: studentNumber ?? this.studentNumber,
    classId: classId ?? this.classId,
    photoUrl: photoUrl ?? this.photoUrl,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    studentNumber,
    classId,
    photoUrl,
    isActive,
    createdAt,
    updatedAt,
  ];
}
