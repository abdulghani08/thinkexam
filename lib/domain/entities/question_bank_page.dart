import 'base_entity.dart';
import 'question.dart';

class QuestionBankPage extends BaseEntity {
  final List<Question> questions;
  final bool hasMore;
  final String? nextCursor;

  const QuestionBankPage({
    required this.questions,
    this.hasMore = false,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [questions, hasMore, nextCursor];
}
