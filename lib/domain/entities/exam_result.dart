import 'base_entity.dart';

class ExamResult extends BaseEntity {
  final String id;
  final String sessionId;
  final String studentId;
  final String examId;
  final double totalScore;
  final int totalCorrect;
  final int totalWrong;
  final DateTime? submittedAt;

  const ExamResult({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.examId,
    required this.totalScore,
    this.totalCorrect = 0,
    this.totalWrong = 0,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [
    id,
    sessionId,
    studentId,
    examId,
    totalScore,
    totalCorrect,
    totalWrong,
    submittedAt,
  ];
}
