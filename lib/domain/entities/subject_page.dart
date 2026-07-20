import 'base_entity.dart';
import 'subject.dart';

class SubjectPage extends BaseEntity {
  final List<Subject> subjects;
  final bool hasMore;
  final String? nextCursor;

  const SubjectPage({
    required this.subjects,
    this.hasMore = false,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [subjects, hasMore, nextCursor];
}
