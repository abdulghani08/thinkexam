import 'base_entity.dart';

class Subject extends BaseEntity {
  final String id;
  final String subjectName;
  final String subjectCode;
  final String? description;
  final bool isArchived;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Subject({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    this.description,
    this.isArchived = false,
    this.createdAt,
    this.updatedAt,
  });

  Subject copyWith({
    String? subjectName,
    String? subjectCode,
    String? description,
    bool? isArchived,
    DateTime? updatedAt,
  }) => Subject(
    id: id,
    subjectName: subjectName ?? this.subjectName,
    subjectCode: subjectCode ?? this.subjectCode,
    description: description ?? this.description,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    subjectName,
    subjectCode,
    description,
    isArchived,
    createdAt,
    updatedAt,
  ];
}
