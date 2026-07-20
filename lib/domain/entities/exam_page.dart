import 'base_entity.dart';
import 'exam.dart';

class ExamPage extends BaseEntity {
  final List<Exam> exams;
  final bool hasMore;
  final String? nextCursor;

  const ExamPage({
    required this.exams,
    this.hasMore = false,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [exams, hasMore, nextCursor];
}
