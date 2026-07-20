import 'base_entity.dart';

/// A school class record stored in the classes collection.
class ClassRoom extends BaseEntity {
  final String id;
  final String className;
  final int grade;
  final String academicYear;
  final String? homeroomTeacherId;
  final bool isArchived;
  final int studentCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ClassRoom({
    required this.id,
    required this.className,
    required this.grade,
    required this.academicYear,
    this.homeroomTeacherId,
    this.isArchived = false,
    this.studentCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  ClassRoom copyWith({
    String? className,
    int? grade,
    String? academicYear,
    String? homeroomTeacherId,
    bool? isArchived,
    int? studentCount,
    DateTime? updatedAt,
  }) => ClassRoom(
    id: id,
    className: className ?? this.className,
    grade: grade ?? this.grade,
    academicYear: academicYear ?? this.academicYear,
    homeroomTeacherId: homeroomTeacherId ?? this.homeroomTeacherId,
    isArchived: isArchived ?? this.isArchived,
    studentCount: studentCount ?? this.studentCount,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  List<Object?> get props => [
    id,
    className,
    grade,
    academicYear,
    homeroomTeacherId,
    isArchived,
    studentCount,
    createdAt,
    updatedAt,
  ];
}
