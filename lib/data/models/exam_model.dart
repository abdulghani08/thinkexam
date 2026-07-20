import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exam.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

/// Firestore representation of an [Exam].
@freezed
class ExamModel with _$ExamModel {
  const ExamModel._();

  const factory ExamModel({
    required String id,
    required String title,
    String? description,
    required String subjectId,
    @Default([]) List<String> allowedClassIds,
    required int durationMinutes,
    DateTime? startTime,
    DateTime? endTime,
    @Default('draft') String status,
    @Default(false) bool randomQuestion,
    @Default(false) bool randomOption,
    @Default(true) bool showResult,
    int? passingGrade,
    required String createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExamModel;

  factory ExamModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return ExamModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String?,
      subjectId: data['subjectId'] as String? ?? '',
      allowedClassIds: (data['allowedClassIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      durationMinutes: data['durationMinutes'] as int? ?? 0,
      startTime: (data['startTime'] as Timestamp?)?.toDate(),
      endTime: (data['endTime'] as Timestamp?)?.toDate(),
      status: data['status'] as String? ?? 'draft',
      randomQuestion: data['randomQuestion'] as bool? ?? false,
      randomOption: data['randomOption'] as bool? ?? false,
      showResult: data['showResult'] as bool? ?? true,
      passingGrade: data['passingGrade'] as int?,
      createdBy: data['createdBy'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  factory ExamModel.fromEntity(Exam exam) => ExamModel(
    id: exam.id,
    title: exam.title,
    description: exam.description,
    subjectId: exam.subjectId,
    allowedClassIds: exam.allowedClassIds,
    durationMinutes: exam.durationMinutes,
    startTime: exam.startTime,
    endTime: exam.endTime,
    status: exam.status,
    randomQuestion: exam.randomQuestion,
    randomOption: exam.randomOption,
    showResult: exam.showResult,
    passingGrade: exam.passingGrade,
    createdBy: exam.createdBy,
    createdAt: exam.createdAt,
    updatedAt: exam.updatedAt,
  );

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Exam toEntity() => Exam(
    id: id,
    title: title,
    description: description,
    subjectId: subjectId,
    allowedClassIds: allowedClassIds,
    durationMinutes: durationMinutes,
    startTime: startTime,
    endTime: endTime,
    status: status,
    randomQuestion: randomQuestion,
    randomOption: randomOption,
    showResult: showResult,
    passingGrade: passingGrade,
    createdBy: createdBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  Map<String, dynamic> toCreateMap() => {
    'title': title,
    'description': description,
    'subjectId': subjectId,
    'allowedClassIds': allowedClassIds,
    'durationMinutes': durationMinutes,
    'startTime': startTime,
    'endTime': endTime,
    'status': status,
    'randomQuestion': randomQuestion,
    'randomOption': randomOption,
    'showResult': showResult,
    'passingGrade': passingGrade,
    'createdBy': createdBy,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'title': title,
    'description': description,
    'subjectId': subjectId,
    'allowedClassIds': allowedClassIds,
    'durationMinutes': durationMinutes,
    'startTime': startTime,
    'endTime': endTime,
    'status': status,
    'randomQuestion': randomQuestion,
    'randomOption': randomOption,
    'showResult': showResult,
    'passingGrade': passingGrade,
    'updatedAt': FieldValue.serverTimestamp(),
  };
}
