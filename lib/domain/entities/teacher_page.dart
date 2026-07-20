import 'base_entity.dart';
import 'teacher.dart';

/// A cursor-based page of teacher records.
class TeacherPage extends BaseEntity {
  final List<Teacher> teachers;
  final String? nextCursor;
  final bool hasMore;

  const TeacherPage({
    required this.teachers,
    this.nextCursor,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [teachers, nextCursor, hasMore];
}
