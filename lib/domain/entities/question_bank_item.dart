import 'base_entity.dart';
import 'question_option.dart';

class QuestionBankItem extends BaseEntity {
  final String id;
  final String subjectId;
  final String questionText;
  final String? questionImage;
  final String questionType;
  final List<QuestionOption> options;
  final List<String> correctAnswers;
  final String? explanation;
  final int score;
  final String? category;
  final List<String> tags;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuestionBankItem({
    required this.id,
    required this.subjectId,
    required this.questionText,
    this.questionImage,
    required this.questionType,
    this.options = const [],
    this.correctAnswers = const [],
    this.explanation,
    this.score = 1,
    this.category,
    this.tags = const [],
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    subjectId,
    questionText,
    questionImage,
    questionType,
    options,
    correctAnswers,
    explanation,
    score,
    category,
    tags,
    createdBy,
    createdAt,
    updatedAt,
  ];
}
