import 'base_entity.dart';
import 'student.dart';

class StudentPage extends BaseEntity {
  final List<Student> students;
  final bool hasMore;
  final String? nextCursor;

  const StudentPage({
    required this.students,
    this.hasMore = false,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [students, hasMore, nextCursor];
}
