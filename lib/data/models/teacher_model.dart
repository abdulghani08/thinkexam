import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/teacher.dart';

part 'teacher_model.freezed.dart';
part 'teacher_model.g.dart';

/// Firestore representation of a [Teacher].
@freezed
class TeacherModel with _$TeacherModel {
  const TeacherModel._();

  const factory TeacherModel({
    required String id,
    required String fullName,
    required String email,
    String? photoUrl,
    @Default('ADMIN') String role,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(true) bool isActive,
  }) = _TeacherModel;

  factory TeacherModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return TeacherModel(
      id: doc.id,
      fullName: data['fullName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String?,
      role: data['role'] as String? ?? 'ADMIN',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      isActive: data['isActive'] as bool? ?? true,
    );
  }

  factory TeacherModel.fromEntity(Teacher teacher) => TeacherModel(
    id: teacher.id,
    fullName: teacher.fullName,
    email: teacher.email,
    photoUrl: teacher.photoUrl,
    role: teacher.role,
    createdAt: teacher.createdAt,
    updatedAt: teacher.updatedAt,
    isActive: teacher.isActive,
  );

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Teacher toEntity() => Teacher(
    id: id,
    fullName: fullName,
    email: email,
    photoUrl: photoUrl,
    role: role,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isActive: isActive,
  );

  Map<String, dynamic> toCreateMap() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'photoUrl': photoUrl,
    'role': role,
    'isActive': isActive,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'fullName': fullName,
    'email': email,
    'photoUrl': photoUrl,
    'role': role,
    'isActive': isActive,
    'updatedAt': FieldValue.serverTimestamp(),
  };
}
