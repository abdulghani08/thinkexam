import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/subject.dart';

part 'subject_model.freezed.dart';
part 'subject_model.g.dart';

/// Firestore representation of a [Subject].
@freezed
class SubjectModel with _$SubjectModel {
  const SubjectModel._();

  const factory SubjectModel({
    required String id,
    required String subjectName,
    String? description,
    DateTime? createdAt,
  }) = _SubjectModel;

  factory SubjectModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return SubjectModel(
      id: doc.id,
      subjectName: data['subjectName'] as String? ?? '',
      description: data['description'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  factory SubjectModel.fromEntity(Subject subject) => SubjectModel(
    id: subject.id,
    subjectName: subject.subjectName,
    description: subject.description,
    createdAt: subject.createdAt,
  );

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Subject toEntity() => Subject(
    id: id,
    subjectName: subjectName,
    subjectCode: '',
    description: description,
    createdAt: createdAt,
  );

  Map<String, dynamic> toCreateMap() => {
    'subjectName': subjectName,
    'description': description,
    'createdAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'subjectName': subjectName,
    'description': description,
  };
}
