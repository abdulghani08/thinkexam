import 'base_entity.dart';

class ExamAnswer extends BaseEntity {
  final String id;
  final String sessionId;
  final String questionId;
  final String? selectedAnswer;
  final bool? isCorrect;
  final DateTime? answeredAt;

  const ExamAnswer({
    required this.id,
    required this.sessionId,
    required this.questionId,
    this.selectedAnswer,
    this.isCorrect,
    this.answeredAt,
  });

  @override
  List<Object?> get props => [
        id,
        sessionId,
        questionId,
        selectedAnswer,
        isCorrect,
        answeredAt,
      ];

  ExamAnswer copyWith({
    String? id,
    String? sessionId,
    String? questionId,
    String? selectedAnswer,
    bool? isCorrect,
    DateTime? answeredAt,
  }) =>
      ExamAnswer(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        questionId: questionId ?? this.questionId,
        selectedAnswer: selectedAnswer ?? this.selectedAnswer,
        isCorrect: isCorrect ?? this.isCorrect,
        answeredAt: answeredAt ?? this.answeredAt,
      );
}
