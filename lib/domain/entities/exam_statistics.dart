import 'base_entity.dart';

class ExamStatistics extends BaseEntity {
  final String examId;
  final int participantCount;
  final double averageScore;
  final double highestScore;
  final double lowestScore;

  const ExamStatistics({
    required this.examId,
    this.participantCount = 0,
    this.averageScore = 0,
    this.highestScore = 0,
    this.lowestScore = 0,
  });

  @override
  List<Object?> get props => [
    examId,
    participantCount,
    averageScore,
    highestScore,
    lowestScore,
  ];
}
