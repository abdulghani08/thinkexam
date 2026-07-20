import 'base_entity.dart';
import 'question_option.dart';

class Question extends BaseEntity {
  final String id;
  final String examId;
  final String questionText;
  final String? questionImage;
  final String questionType;
  final List<QuestionOption> options;
  final List<String> correctAnswers;
  final String? explanation;
  final int score;
  final int order;
  final bool isRequired;

  const Question({
    required this.id,
    required this.examId,
    required this.questionText,
    this.questionImage,
    required this.questionType,
    this.options = const [],
    this.correctAnswers = const [],
    this.explanation,
    this.score = 1,
    this.order = 0,
    this.isRequired = true,
  });

  Question copyWith({
    String? questionText,
    String? questionImage,
    String? questionType,
    List<QuestionOption>? options,
    List<String>? correctAnswers,
    String? explanation,
    int? score,
    int? order,
    bool? isRequired,
  }) => Question(
    id: id,
    examId: examId,
    questionText: questionText ?? this.questionText,
    questionImage: questionImage ?? this.questionImage,
    questionType: questionType ?? this.questionType,
    options: options ?? this.options,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    explanation: explanation ?? this.explanation,
    score: score ?? this.score,
    order: order ?? this.order,
    isRequired: isRequired ?? this.isRequired,
  );

  @override
  List<Object?> get props => [
    id,
    examId,
    questionText,
    questionImage,
    questionType,
    options,
    correctAnswers,
    explanation,
    score,
    order,
    isRequired,
  ];
}
