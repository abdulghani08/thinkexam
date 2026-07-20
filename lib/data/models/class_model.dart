import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/class_room.dart';

part 'class_model.freezed.dart';
part 'class_model.g.dart';

/// Firestore representation of a [ClassRoom].
@freezed
class ClassModel with _$ClassModel {
  const ClassModel._();

  const factory ClassModel({
    required String id,
    required String className,
    required int grade,
    String? homeroomTeacherId,
    DateTime? createdAt,
  }) = _ClassModel;

  factory ClassModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return ClassModel(
      id: doc.id,
      className: data['className'] as String? ?? '',
      grade: data['grade'] as int? ?? 0,
      homeroomTeacherId: data['homeroomTeacherId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  factory ClassModel.fromEntity(ClassRoom classRoom) => ClassModel(
    id: classRoom.id,
    className: classRoom.className,
    grade: classRoom.grade,
    homeroomTeacherId: classRoom.homeroomTeacherId,
    createdAt: classRoom.createdAt,
  );

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);

  ClassRoom toEntity() => ClassRoom(
    id: id,
    className: className,
    grade: grade,
    academicYear: '',
    homeroomTeacherId: homeroomTeacherId,
    createdAt: createdAt,
  );

  Map<String, dynamic> toCreateMap() => {
    'className': className,
    'grade': grade,
    'homeroomTeacherId': homeroomTeacherId,
    'createdAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'className': className,
    'grade': grade,
    'homeroomTeacherId': homeroomTeacherId,
  };
}
