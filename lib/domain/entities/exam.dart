import 'base_entity.dart';

class Exam extends BaseEntity {
  final String id;
  final String title;
  final String? description;
  final String subjectId;
  final List<String> allowedClassIds;
  final int durationMinutes;
  final DateTime? startTime;
  final DateTime? endTime;
  final String status;
  final bool randomQuestion;
  final bool randomOption;
  final bool showResult;
  final int? passingGrade;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Exam({
    required this.id,
    required this.title,
    this.description,
    required this.subjectId,
    this.allowedClassIds = const [],
    required this.durationMinutes,
    this.startTime,
    this.endTime,
    this.status = 'draft',
    this.randomQuestion = false,
    this.randomOption = false,
    this.showResult = true,
    this.passingGrade,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Exam copyWith({
    String? title,
    String? description,
    String? subjectId,
    List<String>? allowedClassIds,
    int? durationMinutes,
    DateTime? startTime,
    DateTime? endTime,
    String? status,
    bool? randomQuestion,
    bool? randomOption,
    bool? showResult,
    int? passingGrade,
    DateTime? updatedAt,
  }) => Exam(
    id: id,
    title: title ?? this.title,
    description: description ?? this.description,
    subjectId: subjectId ?? this.subjectId,
    allowedClassIds: allowedClassIds ?? this.allowedClassIds,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    status: status ?? this.status,
    randomQuestion: randomQuestion ?? this.randomQuestion,
    randomOption: randomOption ?? this.randomOption,
    showResult: showResult ?? this.showResult,
    passingGrade: passingGrade ?? this.passingGrade,
    createdBy: createdBy,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    subjectId,
    allowedClassIds,
    durationMinutes,
    startTime,
    endTime,
    status,
    randomQuestion,
    randomOption,
    showResult,
    passingGrade,
    createdBy,
    createdAt,
    updatedAt,
  ];
}
