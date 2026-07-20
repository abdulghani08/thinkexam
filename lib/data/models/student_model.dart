import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/student.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

/// Firestore representation of a [Student].
@freezed
class StudentModel with _$StudentModel {
  const StudentModel._();

  const factory StudentModel({
    required String id,
    required String fullName,
    required String email,
    String? studentNumber,
    String? classId,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(true) bool isActive,
  }) = _StudentModel;

  factory StudentModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return StudentModel(
      id: doc.id,
      fullName: data['fullName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      studentNumber: data['studentNumber'] as String?,
      classId: data['classId'] as String?,
      photoUrl: data['photoUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      isActive: data['isActive'] as bool? ?? true,
    );
  }

  factory StudentModel.fromEntity(Student student) => StudentModel(
    id: student.id,
    fullName: student.fullName,
    email: student.email,
    studentNumber: student.studentNumber,
    classId: student.classId,
    photoUrl: student.photoUrl,
    createdAt: student.createdAt,
    updatedAt: student.updatedAt,
    isActive: student.isActive,
  );

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Student toEntity() => Student(
    id: id,
    fullName: fullName,
    email: email,
    studentNumber: studentNumber,
    classId: classId ?? '',
    photoUrl: photoUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isActive: isActive,
  );

  Map<String, dynamic> toCreateMap() => {
    'fullName': fullName,
    'email': email,
    'studentNumber': studentNumber,
    'classId': classId,
    'photoUrl': photoUrl,
    'isActive': isActive,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'fullName': fullName,
    'email': email,
    'studentNumber': studentNumber,
    'classId': classId,
    'photoUrl': photoUrl,
    'isActive': isActive,
    'updatedAt': FieldValue.serverTimestamp(),
  };
}
